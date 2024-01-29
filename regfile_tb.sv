module stimulus ();

   logic clock;
   logic we3;
   logic [4:0] ra1;
   logic [4:0] ra2;
   logic [4:0] wa3;
   logic [31:0] wd3;
   logic [31:0] rd1;
   logic [31:0] rd2;
   logic [31:0] rd1_expected;
   logic [31:0] rd2_expected;

   logic [31:0] vectornum, errors;
   logic [111:0] testvectors[10000:0];

   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   regfile dut (clock, we3, ra1, ra2, wa3, wd3, rd1, rd2);

   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clock = 1'b1;
	forever #5 clock = ~clock;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("reg_test.out");
	// Tells when to finish simulation
	#500000 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	
	#5 $fdisplay(desc3, "%b | %b %b %b | %h || %h %h", 
		     we3, ra1, ra2, wa3, wd3, rd1, rd2);
     end   
   

   initial
	 	begin
			$readmemb("regfile.tv", testvectors);
			vectornum = 0;
			errors = 0;
			we3 = 1'b0;
			#22 we3 = 1'b1;
		end
		
	always @(posedge clock)
		begin
			#5 {ra1, ra2, wa3, wd3, rd1_expected, rd2_expected} = testvectors[vectornum];
		end

	always @(negedge clock)
		if (we3 == 1'b1) begin
			if (rd1 != rd1_expected | rd2 != rd2_expected) begin
				$display("Error: rd1 = %h, rd2 = %h, expected rd1 = %h, expected rd2 = %h", rd1, rd2, rd1_expected, rd2_expected);
				errors = errors + 1;
			end
			vectornum = vectornum + 1;
			if (testvectors[vectornum] === 'bx) begin
				$display("Simulation complete. %d errors detected.", errors);
				$stop;
			end
		end
endmodule // regfile_tb
