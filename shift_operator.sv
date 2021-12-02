module shift_operator (clk, reset, rowToShift, shiftedRow, shiftPattern); 
	
  input logic         clk, reset;
  input logic  [15:0] rowToShift;
  input logic  [15:0] shiftPattern;
  output logic [15:0] shiftedRow;
  
  
  logic [15:0] count = 16'b0000000000000000;
  
   
	 
	always_ff @(posedge clk)
		if (reset) begin
			shiftedRow <= rowToShift;
			count <= '0;
		end else if (count == 16'b000000111111111)  begin
			shiftedRow <= shiftedRow >> 1;
			count <= '0;
		end else if (shiftedRow == 16'b0000000000000000) begin
			shiftedRow <= shiftPattern;
		end else begin
			count <= count + 1'b1;
		end
		
endmodule


module shift_operator_testbench();
	logic clk, reset;
	logic [15:0] rowToShift;
	logic [15:0] shiftedRow;
	logic [15:0] count;
	logic  [15:0] shiftPattern;

	shift_operator dut (clk, reset, rowToShift, shiftedRow, shiftPattern);
    
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial begin
    	clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		@(posedge clk); reset <= 1;
		@(posedge clk); reset <= 0; 
		@(posedge clk); shiftedRow <= 16'b1000000000000000;
		@(posedge clk); count <= 16'b000000111111111;
		@(posedge clk);
		@(posedge clk); count <= 0;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 16'b000000111111111;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
		@(posedge clk); count <= 16'b000000111111111;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;		
		@(posedge clk); count <= 16'b000000111111111;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
		@(posedge clk); count <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
		@(posedge clk); count <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
		@(posedge clk); count <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
		@(posedge clk); count <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
		@(posedge clk); count <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
		@(posedge clk); count <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
		@(posedge clk); count <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
		@(posedge clk); count <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
				@(posedge clk); count <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
				@(posedge clk); count <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
				@(posedge clk); count <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
				@(posedge clk); count <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
				@(posedge clk); count <= 1;
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); count <= 0;
		
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); 
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk); 
		@(posedge clk);
		@(posedge clk); reset <= 1;
		@(posedge clk);
		@(posedge clk); 	
		$stop; // End the simulation
	end
endmodule