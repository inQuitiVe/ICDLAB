`define WEIGHT_ROW_SIZE 32
`define WEIGHT_ROW_BITS 5
`define INPUT_ADDR_BITS 8
`define DATA_BITS 16
`define INPUT_ROW_SIZE 100
`define INPUT_ROW_BITS 7 // 2^7=128>100
`define INPUT_COL_BITS 5 // 2^5=32
`define OUTPUT_ROW_BITS 7 // 2^7=128>100
`define OUTPUT_COL_BITS 3 // 2^3=8
`define WEIGHT_COL_BITS 3 // 2^3=8
`define WEIGHT_ADDR_BITS 16
`define INPUT_DATA_SIZE 100

module GCN(clk, rst,
        i_req, i_cmd, o_rdy, o_result,
        i_p0, i_p1, i_p2, i_p3, i_p4, i_p5, i_p6, i_p7,
        i_p8, i_p9, i_p10, i_p11, i_p12, i_p13, i_p14, i_p15,
        o_p0, o_p1, o_p2, o_p3, o_p4, o_p5, o_p6, o_p7,
        o_p8, o_p9, o_p10, o_p11, o_p12, o_p13, o_p14, o_p15);
// I/O signals
input clk, rst;
input i_req, i_cmd;
output o_rdy, o_result;
input i_p0, i_p1, i_p2, i_p3, i_p4, i_p5, i_p6, i_p7;
input i_p8, i_p9, i_p10, i_p11, i_p12, i_p13, i_p14, i_p15;
output o_p0, o_p1, o_p2, o_p3, o_p4, o_p5, o_p6, o_p7;
output o_p8, o_p9, o_p10, o_p11, o_p12, o_p13, o_p14, o_p15;
// Temp

// reg [`WEIGHT_ADDR_BITS-1:0] w_col1_r, w_col1_w;
// reg [`WEIGHT_ADDR_BITS-1:0] w_col2_r, w_col2_w;

reg [15:0] o_buf_w, o_buf_r;
reg [7:0]  o_cnt_w, o_cnt_r; // counts 0 to 200
reg [3:0] state_r, state_w;
reg [15:0] w_data1_r [0:`WEIGHT_ROW_SIZE-1];
reg [15:0] w_data1_w [0:`WEIGHT_ROW_SIZE-1];
reg [15:0] w_data2_r [0:`WEIGHT_ROW_SIZE-1];
reg [15:0] w_data2_w [0:`WEIGHT_ROW_SIZE-1];
reg [15:0] i_data_r [0:`INPUT_DATA_SIZE-1];
reg [15:0] i_data_w [0:`INPUT_DATA_SIZE-1];
reg [15:0] i_row_w  [0:`INPUT_DATA_SIZE-1];
reg [15:0] i_row_r  [0:`INPUT_DATA_SIZE-1];
reg [15:0] i_col_w  [0:`INPUT_DATA_SIZE-1];
reg [15:0] i_col_r  [0:`INPUT_DATA_SIZE-1];
reg [7:0] w_cnt_r, w_cnt_w;
reg [7:0] i_cnt_r, i_cnt_w;
reg [2:0] i_buf_cnt_r, i_buf_cnt_w;
reg [2:0] o_buf_cnt_r, o_buf_cnt_w;
reg o_result_w, o_result_r;
//reg [10:0] o_cnt_r, o_cnt_w;
reg o_rdy_w, o_rdy_r;
localparam IDLE = 0;
localparam READ_WEIGHT_ADDR = 1;
localparam READ_WEIGHT_DATA = 2;
localparam READ_INPUT = 3;
localparam WAIT = 4;
localparam S2_COMPUTE = 5;
localparam OUTPUT = 6;

// localparam ROW  = 0;
// localparam COL  = 1;
// localparam LOW  = 2;
// localparam HIGH = 3;
// If i_req=1, start reading weight. 
// if i_cmd=1, full input matrix done.
localparam COL  = 0;
localparam DATA = 1;
integer i, j;



reg s1_rdy;
reg  [`DATA_BITS-1:0]         s1_data;
reg  [`DATA_BITS-1:0]         s1_data_buffer;
reg  [`INPUT_ROW_BITS-1:0]    s1_row_ptr;
reg  [`INPUT_ROW_BITS-1:0]    s1_row_ptr_buffer;
reg  [`INPUT_COL_BITS-1:0]    s1_col_idx;
reg  [`INPUT_COL_BITS-1:0]    s1_col_idx_buffer;
reg                        switch; // finish whole matrix input pass, next iteration
reg  [`DATA_BITS-1:0]         s1_w_data; // Read first column ,done all rows, switch to second column
wire [`WEIGHT_COL_BITS-1:0]   s1_w_col_idx; //
reg  [`WEIGHT_COL_BITS-1:0]   w_col_idx_w, w_col_idx_r;
wire [`DATA_BITS-1:0]         s1_pe1_result;
wire [`DATA_BITS-1:0]         s1_pe2_result;
wire [`DATA_BITS-1:0]         s2_pe1_result;
wire [`DATA_BITS-1:0]         s2_pe2_result;
wire [`OUTPUT_COL_BITS-1:0]   s2_o_col_idx_1;
wire [`OUTPUT_COL_BITS-1:0]   s2_o_col_idx_2;
wire                          s1_pe1_done;
wire                          s1_pe2_done;
wire                          s2_pe1_done;
wire                          s2_pe2_done;
wire [`DATA_BITS-1:0]         s1_pe1_input;
wire [`DATA_BITS-1:0]         s1_pe2_input;
wire [`DATA_BITS-1:0]         s2_data_1;
wire [`DATA_BITS-1:0]         s2_data_2;
wire                          s2_adj_1;
wire                          s2_adj_2;
wire                          s1_pe1_ctrl; // ctrl = 1 ==> sum, ctrl = 0 ==> reset
wire                          s1_pe2_ctrl;
wire                          s2_pe1_ctrl; // ctrl = 1 ==> sum, ctrl = 0 ==> reset
wire                          s2_pe2_ctrl;
wire [`DATA_BITS-1:0]         s1_result_1;
wire [`DATA_BITS-1:0]         s1_result_2;
wire [`DATA_BITS-1:0]         s2_col_1;
wire [`DATA_BITS-1:0]         s2_col_2;
wire [`OUTPUT_COL_BITS-1:0]   s1_col_idx_1;
wire [`OUTPUT_COL_BITS-1:0]   s1_col_idx_2;
wire [`OUTPUT_ROW_BITS-1:0]   s1_row_idx_1;
wire [`OUTPUT_ROW_BITS-1:0]   s1_row_idx_2;
wire                          s1_valid;
wire                          s1_w_switch;
wire [`DATA_BITS-1:0]         s1_pe1_weight;
wire [`DATA_BITS-1:0]         s1_pe2_weight;
reg                           i_s1_rdy=0;
reg                           i_s2_rdy=0;
reg                           s1_switch;
wire  [`DATA_BITS-1:0]         s2_psum1;
wire  [`DATA_BITS-1:0]         s2_psum2;
// reg                           i_s1_finish;
// submodule declaration, TODO: scheduler
Scheduler1 Scheduler_1(
    .clk(clk),
    .rst(rst),
    .i_rdy(i_s1_rdy), // weight data must also be ready
    .i_data(s1_data),
    .i_row_ptr(s1_row_ptr),
    .i_col_idx(s1_col_idx),
    .i_done(s1_done), // finish whole matrix input pass, next iteration
    .i_switch(s1_switch),
    .i_w_data(s1_w_data), // Read first column ,done all rows, switch to second column
    .i_w_col_idx(s1_w_col_idx), //
    .i_pe1_result(s1_pe1_result),
    .i_pe2_result(s1_pe2_result),
    .i_pe1_done(s1_pe1_done),
    .i_pe2_done(s1_pe2_done),
    .o_pe1_input(s1_pe1_input),
    .o_pe2_input(s1_pe2_input),
    .o_pe1_weight(s1_pe1_weight),
    .o_pe2_weight(s1_pe2_weight),
    .o_pe1_ctrl(s1_pe1_ctrl), // ctrl = 1 ==> sum, ctrl = 0 ==> reset
    .o_pe2_ctrl(s1_pe2_ctrl),
    .o_result_1(s1_result_1),
    .o_result_2(s1_result_2),
    .o_col_idx_1(s1_col_idx_1),
    .o_col_idx_2(s1_col_idx_2),
    .o_row_idx_1(s1_row_idx_1),
    .o_row_idx_2(s1_row_idx_2),
    .o_valid(s1_valid),
    .o_w_switch(s1_w_switch)
);

Scheduler2 Scheduler_2 (
    .clk(clk),
    .rst(rst),
    .i_rdy_1(s1_valid),            // Scheduler 1 output valid
    .i_rdy_2(s1_valid),            // Scheduler 1 output valid
    .i_data_1(s1_result_1),        // result from PE_1
    .i_data_2(s1_result_2),        // result from PE_2
    .i_row_idx_1(s1_row_idx_1),
    .i_row_idx_2(s1_row_idx_2),
    .i_col_data_1(s2_pe1_result),  // PE_3 output
    .i_col_data_2(s2_pe2_result),  // PE_4 output
    .i_col_idx_1(s1_col_idx_1),
    .i_col_idx_2(s1_col_idx_2),
    // .i_s1_finish(i_s1_finish),
    .o_col_1(s2_col_1),            // buffer 1 output
    .o_col_2(s2_col_2),            // buffer 2 output
    .o_col_idx_1(s2_o_col_idx_1),  // buffer 1 idx
    .o_col_idx_2(s2_o_col_idx_2),  // buffer 2 idx
    .o_data_1(s2_data_1),          // PE_3 input
    .o_data_2(s2_data_2),          // PE_4 input
    .o_adj_1(s2_adj_1),            // PE_3 input
    .o_adj_2(s2_adj_2),            // PE_4 input
    .o_pe1_psum(s2_psum1),
    .o_pe2_psum(s2_psum2),
    .o_result(s2_valid)
);

PE  PE_1(
    .clk(clk),
    .rst(rst),
    .InnerAccum_ctr(s1_pe1_ctrl),    
    .i_wgt(s1_pe1_weight),
    .i_ipt(s1_pe1_input),
    .i_psum(16'd0),
    .o_result(s1_pe1_result),
    .o_finish(s1_pe1_done)
);

PE  PE_2(
    .clk(clk),
    .rst(rst),
    .InnerAccum_ctr(s1_pe2_ctrl),    
    .i_wgt(s1_pe2_weight),
    .i_ipt(s1_pe2_input),
    .i_psum(16'd0),
    .o_result(s1_pe2_result),
    .o_finish(s1_pe2_done)
);

PE2  PE_3(
    .clk(clk),
    .rst(rst),
    .i_wgt(s2_data_1),
    .i_ipt(s2_adj_1),
    .i_psum(s2_psum1),
    .o_result(s2_pe1_result)
);

PE2  PE_4(
    .clk(clk),
    .rst(rst),  
    .i_wgt(s2_data_2),
    .i_ipt(s2_adj_2),
    .i_psum(s2_psum2),
    .o_result(s2_pe2_result)
);





assign s1_w_col_idx = w_col_idx_r;
assign o_p0 = o_buf_r[0];
assign o_p1 = o_buf_r[1];
assign o_p2 = o_buf_r[2];
assign o_p3 = o_buf_r[3];
assign o_p4 = o_buf_r[4];
assign o_p5 = o_buf_r[5];
assign o_p6 = o_buf_r[6];
assign o_p7 = o_buf_r[7];
assign o_p8 = o_buf_r[8];
assign o_p9 = o_buf_r[9];
assign o_p10 = o_buf_r[10];
assign o_p11 = o_buf_r[11];
assign o_p12 = o_buf_r[12];
assign o_p13 = o_buf_r[13];
assign o_p14 = o_buf_r[14];
assign o_p15 = o_buf_r[15];
assign o_rdy = o_rdy_r;
assign o_result = o_result_r;

assign s1_done = i_cmd ? 1'b1 : 1'b0;

always@(*) begin
    s1_switch = 0; 
    for (i=0; i<`WEIGHT_ROW_SIZE; i=i+1) w_data1_w[i] = w_data1_r[i];
    for (i=0; i<`WEIGHT_ROW_SIZE; i=i+1) w_data2_w[i] = w_data2_r[i];
    for (j=0; j<`INPUT_DATA_SIZE; j=j+1) i_row_w[j]  = i_row_r[j];
    for (j=0; j<`INPUT_DATA_SIZE; j=j+1) i_col_w[j]  = i_col_r[j];
    for (j=0; j<`INPUT_DATA_SIZE; j=j+1) i_data_w[j] = i_data_r[j];
    // w_col_w = w_col_r;
    state_w = state_r;
    // i_buffer_w = i_buffer_r;
    // o_buffer_w = o_buffer_r;
    w_cnt_w = w_cnt_r;
    i_cnt_w = i_cnt_r;
    i_buf_cnt_w = i_buf_cnt_r;
    o_buf_cnt_w = o_buf_cnt_r;
    o_cnt_w = o_cnt_r;
    o_buf_w = o_buf_r;
    o_result_w = o_result_r;
    o_rdy_w = o_rdy_r;
    s1_row_ptr = s1_row_ptr_buffer;
    s1_col_idx = s1_col_idx_buffer;
    s1_w_data = 0;
    w_col_idx_w = w_col_idx_r;
    s1_data = s1_data_buffer;
    // i_s1_finish = 0;
    case (state_r)
        IDLE: begin
            o_result_w = 1'b1;
            if (i_req) begin
                state_w = READ_WEIGHT_ADDR;
                
                
            end
        end
        READ_WEIGHT_ADDR: begin
            o_result_w = 1'b0;
            w_col_idx_w = {i_p15, i_p14, i_p13, i_p12, i_p11, i_p10, i_p9, i_p8, i_p7, i_p6, i_p5, i_p4, i_p3, i_p2, i_p1, i_p0};
            state_w = READ_WEIGHT_DATA;
            s1_switch = 1;
            
        end
        READ_WEIGHT_DATA: begin
            s1_col_idx = w_col_idx_r;
            
            s1_w_data = {i_p15, i_p14, i_p13, i_p12, i_p11, i_p10, i_p9, i_p8, i_p7, i_p6, i_p5, i_p4, i_p3, i_p2, i_p1, i_p0};
            
            if (w_col_idx_r[0] == 1'b0 && w_cnt_r == `WEIGHT_ROW_SIZE) begin
                state_w = state_r;
                w_cnt_w = 8'd0;
                w_col_idx_w = w_col_idx_r + 1;
            end
            else if (w_col_idx_r[0] == 1'b1 && w_cnt_r == `WEIGHT_ROW_SIZE-1) begin
                state_w = READ_INPUT;
                w_cnt_w = 8'd0;
            end
            else begin
                state_w = state_r;
                w_cnt_w = w_cnt_r + 1;
            end
        end
        READ_INPUT: begin
            i_buf_cnt_w = i_buf_cnt_r + 1;
            case (i_buf_cnt_r[0])
                1'b0: begin
                    s1_row_ptr = {i_p15, i_p14, i_p13, i_p12, i_p11, i_p10, i_p9, i_p8};
                    s1_col_idx = {i_p7, i_p6, i_p5, i_p4, i_p3, i_p2, i_p1, i_p0};
                    s1_data = s1_data_buffer;
                    i_s1_rdy = 1'b0;
                end
                1'b1: begin
                    s1_data = {i_p15, i_p14, i_p13, i_p12, i_p11, i_p10, i_p9, i_p8, i_p7, i_p6, i_p5, i_p4, i_p3, i_p2, i_p1, i_p0};
                    s1_row_ptr = s1_row_ptr_buffer;
                    s1_col_idx = s1_col_idx_buffer;
                    i_s1_rdy = 1'b1;
                end
            endcase
            i_cnt_w = i_cmd ? 8'd0 : (i_cnt_r + 1);
            state_w = i_cmd ? WAIT : state_r; // i_cmd = 1, pass all input done, switch to WAIT state
            o_result_w = i_cmd ? 1'b1: 1'b0; 
            
        end

        WAIT: begin
            if (s1_valid) begin
                state_w = S2_COMPUTE;
                i_s1_rdy = 1'b0;
                // i_s1_finish = 1'b1;
            end
        end

        S2_COMPUTE: begin
            //TODO
            if (s2_valid) begin
                state_w = OUTPUT;
                o_buf_cnt_w = 0;
            end else begin
                state_w = state_r;
            end
        end
        OUTPUT: begin
            case (o_buf_cnt_r)
                COL: begin
                    o_buf_w[7:0] = s2_o_col_idx_1;
                    o_buf_w[15:8] = s2_o_col_idx_2;
                    o_buf_cnt_w = o_buf_cnt_r + 1;
                    state_w = state_r;
                    o_cnt_w = 0;
                    o_rdy_w = 0;
                end
                DATA: begin
                    if (o_cnt_r < 200) begin
                        o_cnt_w = o_cnt_r + 1;
                        o_buf_w = s2_col_1;
                        o_buf_cnt_w = o_buf_cnt_r;
                        state_w = state_r;
                        o_rdy_w = 0;
                    end 
                    else begin
                        o_cnt_w = 0;
                        o_buf_w = 0;
                        o_rdy_w = 1;
                        state_w = IDLE;
                        o_buf_cnt_w = 0;
                    end
                end
            endcase
            
        end   
    endcase              
                
end

always @(posedge clk or negedge rst)begin
    if(!rst) begin
        state_r      <=    4'b0;
        w_cnt_r      <=    0;
        i_cnt_r      <=    0;
        i_buf_cnt_r  <=    0;
        o_buf_cnt_r  <=    0;
        o_cnt_r      <=    0;
        o_buf_r      <=    0;
        o_result_r   <=    0;
        o_rdy_r      <=    0;
        w_col_idx_r  <=    0;
        for (i=0; i<`WEIGHT_ROW_SIZE; i=i+1) w_data1_r[i] <= 0;
        for (i=0; i<`WEIGHT_ROW_SIZE; i=i+1) w_data2_r[i] <= 0;
        for (j=0; j<`INPUT_DATA_SIZE; j=j+1) i_row_r[j] <= 0;
        for (j=0; j<`INPUT_DATA_SIZE; j=j+1) i_col_r[j] <= 0;
        for (j=0; j<`INPUT_DATA_SIZE; j=j+1) i_data_r[j] <= 0;
        s1_data_buffer      <=   0;
        s1_row_ptr_buffer   <=   0;
        s1_col_idx_buffer   <=   0; 
    end
    else begin
        state_r      <=    state_w;
        w_cnt_r      <=    w_cnt_w;
        i_cnt_r      <=    i_cnt_w;
        i_buf_cnt_r  <=    i_buf_cnt_w;
        o_buf_cnt_r  <=    o_buf_cnt_w;
        o_cnt_r      <=    o_cnt_w;
        o_buf_r      <=    o_buf_w;
        o_result_r   <=    o_result_w;
        o_rdy_r      <=    o_rdy_w;
        w_col_idx_r  <=    w_col_idx_w;
        for (i=0; i<`WEIGHT_ROW_SIZE; i=i+1) w_data1_r[i] <= w_data1_w[i];
        for (i=0; i<`WEIGHT_ROW_SIZE; i=i+1) w_data2_r[i] <= w_data2_w[i];
        for (j=0; j<`INPUT_DATA_SIZE; j=j+1) i_row_r[j]   <= i_row_w[j];
        for (j=0; j<`INPUT_DATA_SIZE; j=j+1) i_col_r[j]   <= i_col_w[j];
        for (j=0; j<`INPUT_DATA_SIZE; j=j+1) i_data_r[j]  <= i_data_w[j];
        s1_data_buffer      <=   s1_data;
        s1_row_ptr_buffer   <=   s1_row_ptr;
        s1_col_idx_buffer   <=   s1_col_idx; 
    end
end


endmodule



// Q1 : 該如何處理scheduler 2 latency問題？
// Sol1. 加buffer存scheduler 1的output
// Sol2. 加控制訊號檔scheduler 1和input data直到scheduler 2算完
// Q2 : 是否將adjacency matrix轉成sparse來減少latency(100 cycle --> 5 cycle)
// Sol1. 維持原樣
// Sol2. 大改scheduler2的架構並另外寫sparse matrix形式的adjacency matrix
