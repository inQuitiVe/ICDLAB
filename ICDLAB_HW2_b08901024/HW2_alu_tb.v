`timescale  1ns / 1ps

module tb_alu;

// alu Parameters
parameter PERIOD = 10    ;

// alu Inputs
reg   clk_p_i                              = 0 ;
reg   reset_n_i                            = 1 ;
reg   [7:0]  data_a_i                      = 0 ;
reg   [7:0]  data_b_i                      = 0 ;
reg   [2:0]  inst_i                        = 0 ;

// alu Outputs
wire  [15:0]  data_o                       ;


initial
begin
    forever #(PERIOD/2)  clk_p_i=~clk_p_i;
end

initial
begin
    #(PERIOD) reset_n_i  =  0;
    #(PERIOD/2) reset_n_i  =  1;
end

alu u_alu (
    .clk_p_i                 ( clk_p_i           ),
    .reset_n_i               ( reset_n_i         ),
    .data_a_i                ( data_a_i   [7:0]  ),
    .data_b_i                ( data_b_i   [7:0]  ),
    .inst_i                  ( inst_i     [2:0]  ),

    .data_o                  ( data_o     [15:0] )
);

initial
begin
    $fsdbDumpfile("alu.fsdb");
	$fsdbDumpvars(0,"+mda");
    data_a_i = 8'd0;
    data_b_i = 8'd0;
    inst_i = 3'b0;
    #(PERIOD)
    data_a_i = 8'd25;
    data_b_i = 8'd35;
    inst_i = 3'b011;
    #(PERIOD)
    data_a_i = 8'd37;
    data_b_i = 8'd128;
    inst_i = 3'b100;
    #(PERIOD)
    data_a_i = 8'd50;
    data_b_i = 8'd60;
    inst_i = 3'b110;
    #(PERIOD)
    data_a_i = 8'd65;
    data_b_i = 8'd100;
    inst_i = 3'b110;
    #(PERIOD/2)
    data_a_i = 8'd65;
    data_b_i = 8'd100;
    inst_i = 3'b111;
    #(PERIOD/2)
    $finish;
end

endmodule