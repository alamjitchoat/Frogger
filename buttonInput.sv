module buttonInput (Clock, Reset, Out, Key);
	input logic Clock, Reset, Key;
	output logic Out;
	
	logic [1:0] ps; // Present State
	logic [1:0] ns; // Next State

	// State encoding
	parameter [1:0] on = 2'b10, off = 2'b00, pause = 2'b01;

	// Next State logic
	always_comb
		case (ps)
			on: if (on)	ns = pause;
				else     ns = off;
			off: if (Key)	ns = on;
				else		ns = off;
				
			pause: if(Key) ns = pause;
				else 	   ns = off;
		endcase

	// Output logic - could also be another always, or part of above block
	assign Out = (ps == on);

	// DFFs
	always_ff @(posedge Clock)
		if (Reset)
			ps <= off;
		else
			ps <= ns;

endmodule

module buttonInput_testbench();
	logic Clock, Reset, Key;
	logic Out;

	buttonInput dut (Clock, Reset, Out, Key);
    
	// Set up the clock
	parameter CLOCK_PERIOD = 100;
	initial begin
    	Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		@(posedge Clock); Reset <= 1;
		@(posedge Clock); Reset <= 0; 
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock);
		@(posedge Clock); Key <= 0;
		@(posedge Clock);           
		@(posedge Clock);            
		@(posedge Clock); Key <= 1;
		@(posedge Clock);           
		@(posedge Clock);            
		@(posedge Clock); Key <= 0;
		@(posedge Clock);           
		@(posedge Clock); 
		$stop; // End the simulation
	end
endmodule
	
	