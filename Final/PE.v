module PE (
    input clk,
    input rst,
    input InnerAccum_ctr,    
    input [15:0] i_wgt,
    input [15:0] i_ipt,
    input [15:0] i_psum,
    output[15:0] o_result,
    output       o_finish
);
    reg ctr1;
    wire ctr1_r;
    reg [15:0] out_r;
    wire[15:0] out_w;

    // multiplication 
    reg [15:0] mul_r;
    wire[15:0] mul_w;
    FP16_multi u1_multi(i_wgt, i_ipt, mul_w);

    // partial sum
    wire[15:0] psum, psum_w;
    reg [15:0] psum_r, p_r;
    
    assign o_finish = (ctr1==1'b0) ? 1'b1 : 1'b0;
    assign psum = (ctr1==1'b1) ? out_r : p_r;

    // addition

    FP16_add u1_add(mul_r, psum, out_w);

	 
	assign o_result = out_r;
    assign ctr1_r = InnerAccum_ctr ? 1'b1 : 1'b0;



    always@(posedge clk or negedge rst) begin
        if(!rst) begin
            mul_r <= 16'b0;
            out_r <= 16'b0;
            p_r   <= 16'b0;
            ctr1  <= 1'b1;
        end
        else begin
            mul_r <= mul_w;
            out_r <= out_w;
            p_r   <=     0;
            ctr1  <= ctr1_r;
        end
    end

endmodule

module FP16_multi(
    input [15:0] fp1,fp2,
    output[15:0] result
);
    // wire & register declaration
    wire result_sig;
    wire [4:0] result_exp;
    wire [9:0] result_manti, result_mantipre;
    wire [6:0] add;
    wire [21:0] multipli;
    wire [10:0] shiftnum1, shiftnum2;
    wire [10:0] Num1, Num2;
    wire [3:0]  LD1, LD2;
    wire [3:0]  shiftex1, shiftex2;
    wire [15:0] resultpre;
    wire [4:0] exp1, exp2;
    wire is_overflow, is_underflow;

    // preparation for multiplication 
    assign LD1  = (fp1[9] == 1'b0) ?
                  (fp1[8] == 1'b0) ?
                  (fp1[7] == 1'b0) ?
                  (fp1[6] == 1'b0) ?
                  (fp1[5] == 1'b0) ?
                  (fp1[4] == 1'b0) ?
                  (fp1[3] == 1'b0) ?
                  (fp1[2] == 1'b0) ?
                  (fp1[1] == 1'b0) ?
                  (fp1[0] == 1'b0) ? 4'd11 : 4'd10 : 4'd9 : 4'd8 : 4'd7 : 4'd6 : 4'd5 : 4'd4 : 4'd3 : 4'd2 : 4'd1;
    assign LD2  = (fp2[9] == 1'b0) ?
                  (fp2[8] == 1'b0) ?
                  (fp2[7] == 1'b0) ?
                  (fp2[6] == 1'b0) ?
                  (fp2[5] == 1'b0) ?
                  (fp2[4] == 1'b0) ?
                  (fp2[3] == 1'b0) ?
                  (fp2[2] == 1'b0) ?
                  (fp2[1] == 1'b0) ?
                  (fp2[0] == 1'b0) ? 4'd11 : 4'd10 : 4'd9 : 4'd8 : 4'd7 : 4'd6 : 4'd5 : 4'd4 : 4'd3 : 4'd2 : 4'd1;

    assign Num1 = (fp1[14:10] == 5'b0) ? (fp1 << LD1) : {1'b1, fp1[9:0]};
    // assign Num1 = {1'b1, shiftnum1};
    assign Num2 = (fp2[14:10] == 5'b0) ? (fp2 << LD2) : {1'b1, fp2[9:0]};
    // assign Num2 = {1'b1, shiftnum2};
    assign multipli = Num1 * Num2;

    // result assignment of each part
    assign result_sig = fp1[15] ^ fp2[15];
    assign shiftex1 = (fp1[14:10] == 5'b0) ?  4'd10 - LD1 : 4'd10;
    assign shiftex2 = (fp2[14:10] == 5'b0) ?  4'd10 - LD2 : 4'd10;
    assign exp1 = (fp1[14:10] == 5'b0) ? 5'b1 : fp1[14:10];
    assign exp2 = (fp2[14:10] == 5'b0) ? 5'b1 : fp2[14:10];
    assign add = (multipli[21] == 1'b1) ? exp1 + exp2 + 1'b1 + shiftex1 + shiftex2: exp1 + exp2 + shiftex1 +  shiftex2;

    assign is_overflow = (add > 7'd65) ? 1'b1 : 1'b0;
    assign is_underflow = ((add < 7'd26) | (fp1[14:0] == 15'b0) | (fp2[14:0] == 15'b0)) ? 1'b1 : 1'b0;
    assign result_exp = (add < 7'd36) ? 5'b0 : (add - 7'd35);
    assign result_manti = (add >= 7'd36) ? (multipli[21] == 1'b1) ? multipli[20-:10] : multipli[19-:10] : (multipli[21] == 1'b1) ? multipli[21-:10] : multipli[20-:10];
    //assign result_manti = (add >= 7'd36) ? result_mantipre : result_mantipre >> 7'd36 - add;
    // result assignment of each part
    assign resultpre = is_underflow ? 16'b0 : {result_sig, result_exp, result_manti};
    assign result = is_overflow ? {result_sig, 15'b11110_1111111111} : resultpre;

endmodule

module FP16_add (
    input [15:0] num1,num2,
    output reg [15:0] result
    );

    reg [15:0] bigNum, smallNum;
    reg 	   big_sig, small_sig; 
    reg        result_sig;
    reg [ 9:0] big_manti, small_manti; 
    reg [ 4:0] big_exp, small_exp;
    reg [10:0] big_manti_recover, small_manti_recover; 
    reg [10:0] small_manti_shift; 
    reg [11:0] result_initial, result_shift; 
    reg [ 9:0] result_manti; 
    reg [ 4:0] result_exp; 
    reg [ 4:0] exp_diff, exp_diffminus1, exp_diffminus2;
    reg [ 4:0] LOP;
    reg [4:0] exp1, exp2;

    always @(*) begin
        
        // compare two number to find bigger absolute value
        if(num2[14:0] > num1[14:0]) begin
            bigNum = num2;
            smallNum = num1;
        end
        else begin
            bigNum = num1;
            smallNum = num2;
        end

        // separate floating point (1 + 5 + 10)
        {big_sig, big_exp, big_manti} = bigNum; 
        {small_sig, small_exp, small_manti} = smallNum;

        // recover leading 1
        big_manti_recover = (big_exp != 5'b0) ? {1'b1, big_manti} : {1'b0, big_manti};
        small_manti_recover = (small_exp != 5'b0) ? {1'b1, small_manti} : {1'b0, small_manti};

        // alignment
        exp1 = (big_exp == 5'b0) ? 5'b1 : big_exp;
        exp2 = (small_exp == 5'b0) ? 5'b1 : small_exp;
        exp_diff = exp1 - exp2 ;
        // exp_diffminus1 = exp_diff - 1'd1;
        // exp_diffminus2 = exp_diff - 2'd2;
        if (exp_diff == 5'b0) begin
            small_manti_shift = small_manti_recover;
        end
        else if (exp_diff == 5'b1) begin
            if (small_manti_recover[exp_diff -: 2] == 2'b11) begin
                small_manti_shift = (small_manti_recover >> exp_diff) + 1;
            end
            else begin
                small_manti_shift = (small_manti_recover >> exp_diff);
            end
        end
        else begin
            if ((small_manti_recover[exp_diff -: 3] == 3'b111) || (small_manti_recover[exp_diff -: 3] == 3'b110) || (small_manti_recover[exp_diff -: 3] == 3'b011) ) begin
				small_manti_shift = (small_manti_recover >> exp_diff) + 1;
            end
				else begin
					small_manti_shift = small_manti_recover >> exp_diff ;
				end
        end

        // same signal
        if (big_sig == small_sig) begin
            result_initial = big_manti_recover + small_manti_shift;
            // subnormal handling
            if(result_initial[11] == 1'b1 && big_exp != 5'b11110 && big_exp != 5'b00000) begin
                result_exp = big_exp + 1'b1;
                // round to the nearest even
                if (result_initial[1:0] == 2'b11) begin
                    result_manti = result_initial[10:1] + 1;
                end
                else begin
                    result_manti = result_initial[10:1];
                end
            end
            else if(result_initial[11] == 1'b1 && big_exp == 5'b11110) begin
                result_exp = big_exp;
                result_manti = 10'b11_1111_1111;
            end
            else if(result_initial[10] == 1'b1 && big_exp == 5'b00000) begin
                result_exp = 5'b1;
                result_manti = result_initial[9:0];
            end
            else begin
                result_exp = big_exp;
                result_manti = result_initial[9:0];
            end
            result_sig = big_sig;
        end
        
        // different signal
        else begin
            result_initial = big_manti_recover - small_manti_shift;

            casex(result_initial)
                12'b1xxxxxxxxxx: LOP = 5'd0;
                12'b01xxxxxxxxx: LOP = 5'd1;
                12'b001xxxxxxxx: LOP = 5'd2;
                12'b0001xxxxxxx: LOP = 5'd3;
                12'b00001xxxxxx: LOP = 5'd4;
                12'b000001xxxxx: LOP = 5'd5;
                12'b0000001xxxx: LOP = 5'd6;
                12'b00000001xxx: LOP = 5'd7;
                12'b000000001xx: LOP = 5'd8;
                12'b0000000001x: LOP = 5'd9;
                12'b00000000001: LOP = 5'd10;
                default: LOP = 5'd11;
            endcase

            if(LOP == 5'd11)begin
                result_exp = 5'b0;
                result_shift = 12'b0;
                result_sig = 1'b0;
            end
            else if(big_exp < LOP) begin
                result_exp = 5'b0;
                result_sig = big_sig;
                result_shift = result_initial << big_exp;
            end
            else if(big_exp == LOP)begin
                result_sig = big_sig;
                result_exp = 5'b0;
                result_shift = result_initial << (big_exp-1);
            end
            else begin
                result_exp = big_exp - LOP;
                result_sig = big_sig;
                result_shift = result_initial << LOP;
            end

            result_manti = result_shift[9:0];
        end   

        result = {result_sig, result_exp, result_manti};
    end

endmodule
