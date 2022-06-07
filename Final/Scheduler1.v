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
`define INPUT_DATA_SIZE 100

module Scheduler1 (
    input                           clk,
    input                           rst,
    input                           i_rdy, // weight data must also be ready
    input  [`DATA_BITS-1:0]         i_data,
    input  [`INPUT_ROW_BITS-1:0]    i_row_ptr,
    input  [`INPUT_COL_BITS-1:0]    i_col_idx,
    input                           i_done, // finish whole matrix input pass, next iteration
    input  [`DATA_BITS-1:0]         i_w_data, // Read first column ,done all rows, switch to second column
    //input  [`DATA_BITS-1:0]         w_data_1 [0:`WEIGHT_ROW_SIZE-1],
    //input  [`DATA_BITS-1:0]         w_data_2 [0:`WEIGHT_ROW_SIZE-1],
    input  [`WEIGHT_COL_BITS-1:0]   i_w_col_idx, //
    output [`DATA_BITS-1:0]         o_pe1_input,
    output [`DATA_BITS-1:0]         o_pe2_input,
    output [`DATA_BITS-1:0]         o_pe1_weight,
    output [`DATA_BITS-1:0]         o_pe2_weight,
    output                          o_pe1_ctrl, // ctrl = 1 ==> sum, ctrl = 0 ==> reset
    output                          o_pe2_ctrl,
    input  [`DATA_BITS-1:0]         i_pe1_result,
    input  [`DATA_BITS-1:0]         i_pe2_result,
    input                           i_pe1_done,
    input                           i_pe2_done,
    output [`DATA_BITS-1:0]         o_result_1,
    output [`DATA_BITS-1:0]         o_result_2,
    output [`OUTPUT_COL_BITS-1:0]   o_col_idx_1,
    output [`OUTPUT_COL_BITS-1:0]   o_col_idx_2,
    output [`OUTPUT_ROW_BITS-1:0]   o_row_idx_1,
    output [`OUTPUT_ROW_BITS-1:0]   o_row_idx_2,
    output                          o_valid,
    output                          o_w_switch
);

reg [`DATA_BITS-1:0]        pe1_input_w, pe1_input_r;
reg [`DATA_BITS-1:0]        pe2_input_w, pe2_input_r;
reg [`DATA_BITS-1:0]        pe1_weight_w, pe1_weight_r;
reg [`DATA_BITS-1:0]        pe2_weight_w, pe2_weight_r;
reg [`DATA_BITS-1:0]        result_1_w, result_1_r;
reg [`DATA_BITS-1:0]        result_2_w, result_2_r;
reg                         pe1_ctrl_r, pe1_ctrl_w, pe2_ctrl_r, pe2_ctrl_w;
reg [`DATA_BITS-1:0]        i_data_w, i_data_r;
reg [`INPUT_ROW_BITS-1:0]   row_ptr_r, row_ptr_w;
reg [`OUTPUT_ROW_BITS-1:0]  o_row_idx_r, o_row_idx_w;
reg o_valid_w, o_valid_r;
reg w_switch_w, w_switch_r;
reg [`WEIGHT_COL_BITS-1:0]  w_col_idx_1_w, w_col_idx_1_r;
reg [`WEIGHT_COL_BITS-1:0]  w_col_idx_2_w, w_col_idx_2_r;
// weight buffer
reg [`DATA_BITS-1:0] w_data_1_w [0:`WEIGHT_ROW_SIZE-1];
reg [`DATA_BITS-1:0] w_data_1_r [0:`WEIGHT_ROW_SIZE-1];
reg [`DATA_BITS-1:0] w_data_2_w [0:`WEIGHT_ROW_SIZE-1];
reg [`DATA_BITS-1:0] w_data_2_r [0:`WEIGHT_ROW_SIZE-1];
reg [`WEIGHT_ROW_BITS-1:0] w_row_cnt_w, w_row_cnt_r;
reg w_buf_cnt_w, w_buf_cnt_r;

assign o_pe1_input = pe1_input_r;
assign o_pe2_input = pe2_input_r;
assign o_pe1_ctrl = pe1_ctrl_r;
assign o_pe2_ctrl = pe2_ctrl_r;
assign o_pe1_weight = pe1_weight_r;
assign o_pe2_weight = pe2_weight_r;
assign o_row_idx_1 = o_row_idx_r;
assign o_row_idx_2 = o_row_idx_r;
assign o_col_idx_1 = w_col_idx_1_r;
assign o_col_idx_2 = w_col_idx_2_r;
assign o_valid = o_valid_r;
assign o_result_1 = result_1_r;
assign o_result_2 = result_2_r;
assign o_w_switch = w_switch_r;




integer i;
always@(*) begin // switch weight column
    w_switch_w = (i_done) ? 1'b1 : w_switch_r; // i_done switch weight column
    w_col_idx_1_w = w_col_idx_1_r;
    w_col_idx_2_w = w_col_idx_2_r;
    w_row_cnt_w = w_row_cnt_r;
    w_buf_cnt_w = w_buf_cnt_r;
    for (i=1;i<`WEIGHT_ROW_SIZE;i=i+1) begin
        w_data_1_w[i] = w_data_1_r[i];
        w_data_2_w[i] = w_data_2_r[i];
    end
    if (w_switch_r) begin
        if (i_w_col_idx[0] == 1'b0) begin // odd row
            w_col_idx_1_w = i_w_col_idx;
            w_buf_cnt_w = w_buf_cnt_r + 1;
            w_data_1_w[`WEIGHT_ROW_SIZE-1] = i_w_data;
            for (i=1;i<`WEIGHT_ROW_SIZE;i=i+1) begin
                w_data_1_w[i-1] = w_data_1_r[i];
            end
        end
        else begin // even row
            w_col_idx_2_w = i_w_col_idx;
            if (w_buf_cnt_r) begin
                w_row_cnt_w = w_row_cnt_r + 1;
                w_data_2_w[`WEIGHT_ROW_SIZE-1] = i_w_data;
                for (i=1;i<`WEIGHT_ROW_SIZE;i=i+1) begin
                    w_data_2_w[i-1] = w_data_2_r[i];
                end
            end
            if (w_row_cnt_r == `WEIGHT_ROW_SIZE) begin
                w_switch_w = 1'b0;
                w_row_cnt_w = 5'd0;
            end
        end
    end
end


always@(*) begin
    o_row_idx_w = o_row_idx_r;
    o_valid_w = o_valid_r;
    result_1_w = result_1_r;
    result_2_w = result_2_r;
    pe1_ctrl_w = pe1_ctrl_r;
    pe2_ctrl_w = pe2_ctrl_r;
    pe1_input_w = pe1_input_r;
    pe2_input_w = pe2_input_r;
    pe1_weight_w = pe1_weight_r;
    pe2_weight_w = pe1_weight_r;
    if (i_rdy) begin
        if (i_row_ptr != row_ptr_r) begin // row switch
            if (i_pe1_done && i_pe2_done) begin
                o_row_idx_w = i_row_ptr;
                pe1_ctrl_w = 1'b0; // reset
                pe2_ctrl_w = 1'b0; // reset
                result_1_w = i_pe1_result;
                result_2_w = i_pe2_result;
                o_valid_w = 1'b1;
            end
        end
        else begin
            if (i_pe1_done && i_pe2_done) begin
                pe1_input_w = i_data;
                pe2_input_w = i_data;
                pe1_weight_w = w_data_1_r[i_col_idx];
                pe2_weight_w = w_data_2_r[i_col_idx];
                row_ptr_w = i_row_ptr;
                pe1_ctrl_w = 1'b1; // sum
                pe2_ctrl_w = 1'b1; // sum
                o_valid_w = 1'b0;
            end
        end
    end
end


always@(posedge clk or negedge rst) begin
    if (!rst) begin
        pe1_input_r  <= 0;
        pe2_input_r  <= 0;
        pe1_weight_r <= 0;
        pe2_weight_r <= 0;
        result_1_r   <= 0;
        result_2_r   <= 0;
        pe1_ctrl_r   <= 0;
        pe2_ctrl_r   <= 0;
        i_data_r     <= 0;
        row_ptr_r    <= 0;
        o_row_idx_r  <= 0;
        o_valid_r    <= 0;
        w_switch_r   <= 0;
        w_col_idx_1_r  <= 0;
        w_col_idx_2_r  <= 0;
        w_row_cnt_r <= 0;
    end
    else begin
        pe1_input_r  <= pe1_input_w;
        pe2_input_r  <= pe2_input_w;
        pe1_weight_r <= pe1_weight_w;
        pe2_weight_r <= pe2_weight_w;
        result_1_r   <= result_1_w;
        result_2_r   <= result_2_w;
        pe1_ctrl_r   <= pe1_ctrl_w;
        pe2_ctrl_r   <= pe2_ctrl_w;
        i_data_r     <= i_data_w;
        row_ptr_r    <= row_ptr_w;
        o_row_idx_r  <= o_row_idx_w;
        o_valid_r    <= o_valid_w;
        w_switch_r   <= w_switch_w;
        w_col_idx_1_r  <= w_col_idx_1_w;
        w_col_idx_2_r  <= w_col_idx_2_w;
        w_row_cnt_r <= w_row_cnt_w;
    end
end




endmodule
