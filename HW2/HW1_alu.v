//IC LAB HW1

module alu(
             clk_p_i,
             reset_n_i,
             data_a_i,
             data_b_i,
             inst_i,
             data_o
             );

  /*========================IO declaration============================ */	  
      input           clk_p_i;
      input           reset_n_i;
      input   [7:0]   data_a_i;
      input   [7:0]   data_b_i;
      input   [2:0]   inst_i;

      output  [15:0]  data_o;

  /* =======================REG & wire================================ */
	  
      //declare reg&wire you need
      //parameters and logic
      parameter S_ADD = 0;
      parameter S_SUB = 1;
      parameter S_MUL = 2;
      parameter S_DVD = 3;
      parameter S_NSB = 4;
      parameter S_XOR = 5;
      parameter S_ABS = 6;
      wire [15:0]  out1, out2, out3, out4, out5, out6, out7;
	    reg [2:0] state_w, state_r;
      reg [15:0] out_r, out_w, data_a, data_b;
      
      //wire assignment
      assign out1 = data_a + data_b;
      assign out2 = $signed(data_b) - $signed(data_a);
      assign out3 = data_a * data_b;
      assign out4 = data_a >>> 1;
      assign out5 = ~ out2;
      assign out6 = data_a ^ data_b;
      assign out7 = out2[15] ? ~out2+1 : out2;
      assign data_o = out_r;

  /* ====================Combinational Part================== */
  //next-state logic

		always@(*) begin
      case(state_r)
        S_ADD:   state_w = inst_i == 7 ? state_r : inst_i;
        S_SUB:   state_w = inst_i == 7 ? state_r : inst_i;
        S_MUL:   state_w = inst_i == 0 || inst_i == 1 || inst_i == 3 || inst_i == 5 ? inst_i : state_r;  
        S_DVD:   state_w = inst_i == 0 || inst_i == 1 || inst_i == 6 ? inst_i : state_r;  
        S_NSB:   state_w = inst_i == 1 || inst_i == 5 ? inst_i : state_r;  
        S_XOR:   state_w = inst_i == 0 || inst_i == 1 || inst_i == 2 ? inst_i : state_r;  
        S_ABS:   state_w = inst_i == 1 || inst_i == 5 ? inst_i : state_r;  
        default: state_w = state_r;
      endcase
    end	  
			  
			  
  // output logic
    always@(*) begin
      case(state_r)
        S_ADD: out_w = out1;
        S_SUB: out_w = out2;
        S_MUL: out_w = out3;
        S_DVD: out_w = out4;
        S_NSB: out_w = out5;
        S_XOR: out_w = out6;
        S_ABS: out_w = out7;
        default: out_w = out_r;
      endcase
    end	  

  /* ====================Sequential Part=================== */
    always@(posedge clk_p_i or negedge reset_n_i)
    begin
        if (reset_n_i == 1'b0) begin
			     //todo
           out_r   <= 16'b0;
           state_r <= 3'b0; 
           data_a  <= 8'b0;
           data_b  <= 8'b0;
        end
        else begin
              //todo 
            out_r   <= out_w;
            state_r <= state_w;
            data_a  <= {8'b0,data_a_i};
            data_b  <= {8'b0,data_b_i};   
        end
    end
  /* ====================================================== */

endmodule

