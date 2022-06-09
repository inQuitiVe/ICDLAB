`timescale  1ns / 1ps
//~ `New testbench
//`include "Top.v"
`include "PE.v"
`include "Scheduler1.v"
`include "Scheduler2.v"


module tb_GCN;

// GCN Parameters
parameter PERIOD  = 10;


// GCN Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;
reg   i_req                                = 0 ;
reg   i_cmd                                = 0 ;
reg   i_p0                                 = 0 ;
reg   i_p1                                 = 0 ;
reg   i_p2                                 = 0 ;
reg   i_p3                                 = 0 ;
reg   i_p4                                 = 0 ;
reg   i_p5                                 = 0 ;
reg   i_p6                                 = 0 ;
reg   i_p7                                 = 0 ;
reg   i_p8                                 = 0 ;
reg   i_p9                                 = 0 ;
reg   i_p10                                = 0 ;
reg   i_p11                                = 0 ;
reg   i_p12                                = 0 ;
reg   i_p13                                = 0 ;
reg   i_p14                                = 0 ;
reg   i_p15                                = 0 ;

// GCN Outputs
wire  o_rdy                                ;
wire  o_result                             ;
wire  o_p0                                 ;
wire  o_p1                                 ;
wire  o_p2                                 ;
wire  o_p3                                 ;
wire  o_p4                                 ;
wire  o_p5                                 ;
wire  o_p6                                 ;
wire  o_p7                                 ;
wire  o_p8                                 ;
wire  o_p9                                 ;
wire  o_p10                                ;
wire  o_p11                                ;
wire  o_p12                                ;
wire  o_p13                                ;
wire  o_p14                                ;
wire  o_p15                                ;

// integer
integer  idx=0, idx2=0;
integer  count=0;
integer  i=0,j=0;

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst  =  1;
end

GCN  u_GCN (
    .clk                     ( clk        ),
    .rst                     ( rst        ),
    .i_req                   ( i_req      ),
    .i_cmd                   ( i_cmd      ),
    .i_p0                    ( i_p0       ),
    .i_p1                    ( i_p1       ),
    .i_p2                    ( i_p2       ),
    .i_p3                    ( i_p3       ),
    .i_p4                    ( i_p4       ),
    .i_p5                    ( i_p5       ),
    .i_p6                    ( i_p6       ),
    .i_p7                    ( i_p7       ),
    .i_p8                    ( i_p8       ),
    .i_p9                    ( i_p9       ),
    .i_p10                   ( i_p10      ),
    .i_p11                   ( i_p11      ),
    .i_p12                   ( i_p12      ),
    .i_p13                   ( i_p13      ),
    .i_p14                   ( i_p14      ),
    .i_p15                   ( i_p15      ),

    .o_rdy                   ( o_rdy      ),
    .o_result                ( o_result   ),
    .o_p0                    ( o_p0       ),
    .o_p1                    ( o_p1       ),
    .o_p2                    ( o_p2       ),
    .o_p3                    ( o_p3       ),
    .o_p4                    ( o_p4       ),
    .o_p5                    ( o_p5       ),
    .o_p6                    ( o_p6       ),
    .o_p7                    ( o_p7       ),
    .o_p8                    ( o_p8       ),
    .o_p9                    ( o_p9       ),
    .o_p10                   ( o_p10      ),
    .o_p11                   ( o_p11      ),
    .o_p12                   ( o_p12      ),
    .o_p13                   ( o_p13      ),
    .o_p14                   ( o_p14      ),
    .o_p15                   ( o_p15      )
);

reg [15:0] gold [0:99][0:7];
reg [15:0] golden [0:799];
reg [15:0] i_ipt [0:2511];
reg        cmd [0:2511];
reg [7:0]  w_col1, w_col2; 

task task1;
    if(o_result == 1'b0) begin     
        if (count == 0) begin
            {w_col2,w_col1} = {o_p15, o_p14, o_p13, o_p12, o_p11, o_p10, o_p9, o_p8, o_p7, o_p6, o_p5, o_p4, o_p3, o_p2, o_p1, o_p0};
            idx2 = 0;
        end
        else if (idx2 < 10'd100) begin
            if (gold[idx2][w_col1] == {o_p15, o_p14, o_p13, o_p12, o_p11, o_p10, o_p9, o_p8, o_p7, o_p6, o_p5, o_p4, o_p3, o_p2, o_p1, o_p0}) begin
                $display("output[%d][%d] is right\n",idx2, w_col1);
            end
            else begin
                $display("output[%d][%d] is wrong\n",idx2-10'd100, w_col1);
            end
        end
        else if (idx2 >= 10'd100) begin
            if (gold[idx2-100][w_col2] === {o_p15, o_p14, o_p13, o_p12, o_p11, o_p10, o_p9, o_p8, o_p7, o_p6, o_p5, o_p4, o_p3, o_p2, o_p1, o_p0}) begin
                $display("output[%d][%d] is right\n",idx2, w_col2);
            end
            else begin
                $display("output[%d][%d] is wrong\n",idx2-10'd100, w_col2);
            end
        end
	end
endtask

integer tt=0;
always @(posedge clk) begin
    tt <= tt+1;
end
always @(*)begin
    if(tt==20'd80000)begin
        $display("timeout!!!!!!!!!!!!!");
        $finish;
    end
end

initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0,tb_GCN);
    $readmemb("input_v.txt",i_ipt);
    $readmemb("golden.txt",golden);
    $readmemb("cmd_v.txt",cmd);

    @(posedge clk);
     for (i=0; i<100; i = i+1)begin
        for (j=0; j<8; j = j+1)begin
            gold[i][j] = golden[i*100+j];
        end
    end
    repeat(4) begin
        count = 0;
        idx = 0;
        idx2 = 0;
        @(posedge clk)
        while(o_rdy == 1'b0) begin
            @(posedge clk)
                if (idx <= 1) i_req = 1;
                else i_req = 0;
                {i_p15, i_p14, i_p13, i_p12, i_p11, i_p10, i_p9, i_p8, i_p7, i_p6, i_p5, i_p4, i_p3, i_p2, i_p1, i_p0} = i_ipt[idx];
                i_cmd = cmd[idx];
            @(negedge clk)
                if (o_result == 1'b0) begin
                    idx=idx+1;
                end
        end   
        @(posedge clk)
        while(o_rdy == 1'b1) begin
            @(posedge clk)
            task1;
            count = count + 1;
        end
    end
    $finish;
end

endmodule