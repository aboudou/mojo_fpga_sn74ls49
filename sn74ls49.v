module sn74ls49(

    input pin_a,      // SN74LS49 bit A
    input pin_b,      // SN74LS49 bit B
    input pin_c,      // SN74LS49 bit C
    input pin_d,      // SN74LS49 bit D
    input pin_bi_n,   // SN74LS49 Blanking Input, active low
   
	 output segment_a, // SN74LS49 segment A output
    output segment_b, // SN74LS49 segment B output
    output segment_c, // SN74LS49 segment C output
    output segment_d, // SN74LS49 segment D output
    output segment_e, // SN74LS49 segment E output
    output segment_f, // SN74LS49 segment F output
    output segment_g  // SN74LS49 segment G output

    );

  // Some registers to store temporary values
  reg input_bi = 0;
  
  reg input_a_level2 = 0;
  reg input_b_level2 = 0;
  reg input_c_level2 = 0;
  reg input_d_level2 = 0;
  
  reg input_a_level3 = 0;
  reg input_b_level3 = 0;
  reg input_c_level3 = 0;
  reg input_d_level3 = 0;
  
  // The outputs
  assign segment_a = (
								  ~(input_b_level3 & input_d_level3)
								& ~(input_a_level2 & input_c_level3)
								& ~(input_a_level3 & input_b_level2 & input_c_level2 & input_d_level2)
							);
  assign segment_b = (
								  ~(input_b_level3 & input_d_level3) 
								& ~(input_a_level3 & input_b_level2 & input_c_level3) 
								& ~(input_a_level2 & input_b_level3 & input_c_level3)
							);
  assign segment_c = (
								  ~(input_c_level3 & input_d_level3) 
								& ~(input_a_level2 & input_b_level3 & input_c_level2)
							);
  assign segment_d = (
								  ~(input_a_level3 & input_b_level2 & input_c_level2) 
								& ~(input_a_level2 & input_b_level2 & input_c_level3) 
								& ~(input_a_level3 & input_b_level3 & input_c_level3)
							);
  assign segment_e = (
								  ~(input_a_level3)
								& ~(input_b_level2 & input_c_level3)
							);
  assign segment_f = (
								  ~(input_a_level3 & input_b_level3)
								& ~(input_b_level3 & input_c_level2)
								& ~(input_a_level3 & input_c_level2 & input_d_level2)
							);
  assign segment_g = (
								  ~(input_a_level3 & input_b_level3 & input_c_level3)
								& ~(input_b_level2 & input_c_level2 & input_d_level2)
							);

  always @(*) begin
 	 // BI is behind a NOT gate, and active low (double negation => value doesn't not change)
    input_bi = pin_bi_n;
	 
	 // Level 2 : A, B, C and D inputs are behind NOT gates
	 input_a_level2 = ~pin_a;
	 input_b_level2 = ~pin_b;
	 input_c_level2 = ~pin_c;
	 input_d_level2 = ~pin_d;
	 
	 // Level 3 : NAND gate between each level 2 and BI
	 input_a_level3 = ~(input_a_level2 & input_bi);
	 input_b_level3 = ~(input_b_level2 & input_bi);
	 input_c_level3 = ~(input_c_level2 & input_bi);
	 input_d_level3 = ~(input_d_level2 & input_bi);
	 
  end

endmodule
