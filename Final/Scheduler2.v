`define WEIGHT_ROW_SIZE 50
`define INPUT_ADDR_BITS 8
`define INPUT_DATA_BITS 16
`define INPUT_ROW_SIZE 200
`define INPUT_DATA_SIZE 100


module Scheduler_2 (
    input                           clk,
    input                           rst,
    input                           i_rdy_1,
    input                           i_rdy_2,
    input [`INPUT_DATA_BITS-1:0]    i_data_1,
    input [`INPUT_DATA_BITS-1:0]    i_data_2,
    input                           i_pe_done_1,
    input                           i_pe_done_2,
    input [`INPUT_DATA_BITS-1:0]    i_col_data_1,
    input [`INPUT_DATA_BITS-1:0]    i_col_data_2,
    input [2:0]                     i_col_idx_1,
    input [2:0]                     i_col_idx_2,
    output [`INPUT_DATA_BITS-1:0]   o_col_1,
    output [`INPUT_DATA_BITS-1:0]   o_col_2,
    output [2:0]                    o_col_idx_1,
    output [2:0]                    o_col_idx_2,
    output [`INPUT_DATA_BITS-1:0]   o_data_1,
    output [`INPUT_DATA_BITS-1:0]   o_data_2,
    output [`INPUT_DATA_BITS-1:0]   o_adj_1,
    output [`INPUT_DATA_BITS-1:0]   o_adj_2,
    output                          o_pe_valid,
    output                          o_result
);
    reg adj_matrix [0:`INPUT_DATA_SIZE-1][0:`INPUT_DATA_SIZE-1];  // 100*100 sparse adjacency matrix
    reg o_result_r, o_result_w;
    reg o_pe_valid_r, o_pe_valid_w;
    //reg pe_done_1, pe_done_2;
    reg busy, busy_w;
    reg o_rdy, o_rdy_w;
    
    reg [`INPUT_DATA_BITS-1:0] out_buffer_1_r [`WEIGHT_ROW_SIZE-1:0];
    reg [`INPUT_DATA_BITS-1:0] out_buffer_1_w [`WEIGHT_ROW_SIZE-1:0];
    reg [`INPUT_DATA_BITS-1:0] out_buffer_2_r [`WEIGHT_ROW_SIZE-1:0];
    reg [`INPUT_DATA_BITS-1:0] out_buffer_2_w [`WEIGHT_ROW_SIZE-1:0];
    reg [`INPUT_DATA_BITS-1:0] o_col_1_r;
    reg [`INPUT_DATA_BITS-1:0] o_col_1_w;
    reg [`INPUT_DATA_BITS-1:0] o_col_2_r;
    reg [`INPUT_DATA_BITS-1:0] o_col_2_w;
    reg [7:0]                  buf_cnt_1, buf_cnt_1_w;
    reg [7:0]                  buf_cnt_2, buf_cnt_2_w;
    reg [7:0]                  row_cnt_1, row_cnt_1_w;
    reg [7:0]                  row_cnt_2, row_cnt_2_w;
    reg [7:0]                  output_cnt, output_cnt_w;
    reg [2:0]                  col_idx_1, col_idx_1_w;
    reg [2:0]                  col_idx_2, col_idx_2_w;
    reg [2:0]                  o_col_idx_1_r, o_col_idx_1_w;
    reg [2:0]                  o_col_idx_2_r, o_col_idx_2_w;
    reg [`INPUT_DATA_BITS-1:0] o_data_1_r, o_data_1_w;
    reg [`INPUT_DATA_BITS-1:0] o_data_2_r, o_data_2_w;
    reg [`INPUT_DATA_BITS-1:0] o_adj_1_r, o_adj_1_w;
    reg [`INPUT_DATA_BITS-1:0] o_adj_2_r, o_adj_2_w;

    assign o_col_1 = o_col_1_r;
    assign o_col_2 = o_col_2_r;
    assign o_col_idx_1 = o_col_idx_1_r;
    assign o_col_idx_2 = o_col_idx_2_r;
    assign o_data_1 = o_data_1_r;
    assign o_data_2 = o_data_2_r;
    assign o_adj_1 = o_adj_1_r;
    assign o_adj_2 = o_adj_2_r;
    assign o_result = o_result_r;
    assign o_pe_valid = o_pe_valid_r;
    integer i, j;

    // Data from first layer are ready
    always @(*) begin
        if (i_rdy_1 && i_rdy_2) begin
            busy_w = 1;
            col_idx_1_w = i_col_idx_1;
            col_idx_2_w = i_col_idx_2;
        end 
    end

    //test
    wire [15:0] ob1, ob2, ob3;
    assign ob1 = out_buffer_1_r[0];
    assign ob2 = out_buffer_1_r[1];
    assign ob3 = out_buffer_1_r[2];

    // Getting result element from first layer PEs
    always @(*) begin
        if (busy) begin
            o_data_1_w = i_data_1;
            o_data_2_w = i_data_2;
            o_adj_1_w = adj_matrix[buf_cnt_1][row_cnt_1];
            o_adj_2_w = adj_matrix[buf_cnt_2][row_cnt_2];
            o_pe_valid_w = 0;
            // One element * one element of adj matrix is done 
            if (i_pe_done_1 && i_pe_done_2) begin
                out_buffer_1_w[buf_cnt_1] = out_buffer_1_r[buf_cnt_1] + i_col_data_1;
                out_buffer_2_w[buf_cnt_2] = out_buffer_2_r[buf_cnt_2] + i_col_data_2;
                if (buf_cnt_1 == 99 && buf_cnt_2 == 99) begin
                    buf_cnt_1_w = 0;
                    buf_cnt_2_w = 0;
                    // One column of adj matrix is finished
                    if (row_cnt_1 == 99 && row_cnt_2 == 99) begin
                        // When row_index and buf_cnt counts to 100
                        // One column of output is finished
                        o_result_w = 1'b1;
                        //busy_w = 0;
                        row_cnt_1_w = 0;
                        row_cnt_2_w = 0;
                        o_rdy_w = 1;
                    end else begin
                        row_cnt_1_w = row_cnt_1 + 1;
                        row_cnt_2_w = row_cnt_2 + 1;
                    end 
                end else begin
                    buf_cnt_1_w = buf_cnt_1 + 1;
                    buf_cnt_2_w = buf_cnt_2 + 1;    
                    /*o_col_idx_1_w = 0;
                    o_col_idx_2_w = 0;
                    o_col_1_w = 0;
                    o_col_2_w = 0;*/
                    o_result_w = 1'b0;
                end
            end else begin
                out_buffer_1_w[buf_cnt_1] = out_buffer_1_r[buf_cnt_1];// + i_col_data_1;
                out_buffer_2_w[buf_cnt_2] = out_buffer_2_r[buf_cnt_2];// + i_col_data_2;
            end  
        end else begin
            o_pe_valid_w = 1;
            row_cnt_1_w = 0;
            row_cnt_2_w = 0;
            buf_cnt_1_w = 0;
            buf_cnt_2_w = 0;
            out_buffer_1_w[buf_cnt_1] = out_buffer_1_r[buf_cnt_1];
            out_buffer_2_w[buf_cnt_2] = out_buffer_2_r[buf_cnt_2];
        end
    end
    
    always @(*) begin
        if (o_rdy) begin
            o_result_w = 0; // pull down ?
            o_rdy_w = 1;
            output_cnt_w = output_cnt + 1;
            if (output_cnt < 100) begin
                o_col_idx_1_w = col_idx_1;
                o_col_1_w = out_buffer_1_r[output_cnt];
                o_col_idx_2_w = 0;
                o_col_2_w = 0;
            end else if (output_cnt < 200) begin
                o_col_idx_1_w = 0;
                o_col_1_w = 0;
                o_col_idx_2_w = col_idx_2;
                o_col_2_w = out_buffer_2_r[output_cnt];
            end else begin
                // Output finished
                o_rdy_w = 0;
                busy_w = 0;
                output_cnt_w = 0;
                o_col_idx_1_w = 0;
                o_col_1_w = 0;
                o_col_idx_2_w = 0;
                o_col_2_w = 0;
            end
        end else begin
            output_cnt_w = 0;
            o_col_idx_1_w = 0;
            o_col_idx_2_w = 0;
            o_col_1_w = 0;
            o_col_2_w = 0;
        end
    end

    always @(posedge clk or negedge rst) begin
        if (~rst) begin
            o_pe_valid_r <= 0;
            o_result_r <= 0;
            buf_cnt_1 <= 0;
            buf_cnt_2 <= 0;
            row_cnt_1 <= 0;
            row_cnt_2 <= 0;
            output_cnt <= 0;
            col_idx_1 <= 0;
            col_idx_2 <= 0;
            o_col_idx_1_r <= 0;
            o_col_idx_2_r <= 0;
            o_data_1_r <= 0;
            o_data_2_r <= 0;
            o_adj_1_r <= 0;
            o_adj_2_r <= 0;
            o_col_1_r <= 0;
            o_col_2_r <= 0;
            busy <= 0;
            o_rdy <= 0;

            for (i = 0; i < `INPUT_DATA_SIZE; i=i+1) begin
                out_buffer_1_r[i] <= 0;
                out_buffer_2_r[i] <= 0;
            end

            for (i = 0; i < `INPUT_DATA_SIZE; i=i+1) begin
                for (j = 0; j < `INPUT_DATA_SIZE; j=j+1) begin
                    adj_matrix[i][j] <= 1; // for test
                end
            end

        end else begin
            o_pe_valid_r <= o_pe_valid_w;
            o_result_r <= o_result_w;
            buf_cnt_1 <= buf_cnt_1_w;
            buf_cnt_2 <= buf_cnt_2_w;
            row_cnt_1 <= row_cnt_1_w;
            row_cnt_2 <= row_cnt_2_w;
            output_cnt <= output_cnt_w;
            col_idx_1 <= col_idx_1_w;
            col_idx_2 <= col_idx_2_w;
            o_data_1_r <= o_data_1_w;
            o_data_2_r <= o_data_2_w;
            o_adj_1_r <= o_adj_1_w;
            o_adj_2_r <= o_adj_2_w;
            o_col_idx_1_r <= o_col_idx_1_w;
            o_col_idx_2_r <= o_col_idx_2_w;
            o_col_1_r <= o_col_1_w;
            o_col_2_r <= o_col_2_w;
            busy <= busy_w;
            o_rdy <= o_rdy_w;

            for (i = 0; i < `INPUT_DATA_SIZE; i=i+1) begin
                out_buffer_1_r[i] <= out_buffer_1_w[i];
                out_buffer_2_r[i] <= out_buffer_2_w[i];
            end
        end
    end
endmodule