//~ `New testbench
`timescale  1ns / 1ps

module tb_alu;

// alu Parameters
parameter PERIOD = 10;
parameter S_ADD  = 0;
parameter S_SUB  = 1;
parameter S_MUL  = 2;
parameter S_DVD  = 3;
parameter S_NSB  = 4;
parameter S_XOR  = 5;
parameter S_ABS  = 6;

// alu Inputs
reg   clk_p_i                              = 0 ;
reg   reset_n_i                            = 0 ;
reg   [7:0]  data_a_i                      = 0 ;
reg   [7:0]  data_b_i                      = 0 ;
reg   [2:0]  inst_i                        = 0 ;

// alu Outputs
wire  [15:0]  data_o                       ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

alu #(
    .S_ADD ( S_ADD ),
    .S_SUB ( S_SUB ),
    .S_MUL ( S_MUL ),
    .S_DVD ( S_DVD ),
    .S_NSB ( S_NSB ),
    .S_XOR ( S_XOR ),
    .S_ABS ( S_ABS ))
 u_alu (
    .clk_p_i                 ( clk_p_i           ),
    .reset_n_i               ( reset_n_i         ),
    .data_a_i                ( data_a_i   [7:0]  ),
    .data_b_i                ( data_b_i   [7:0]  ),
    .inst_i                  ( inst_i     [2:0]  ),

    .data_o                  ( data_o     [15:0] )
);

initial
begin

    $finish;
end

endmodule