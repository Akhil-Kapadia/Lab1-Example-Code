/*
Filename: pwm.v
-------------------------------------------------------
Pulse Width Modulation Module
-------------------------------------------------------
Creates a pwm signal with a given period and duty cycle. Counting is incremented every
10 ns which is the clock speed of the BASYS 3 board. By specifying the parameters we can 
precisely create different clocks and pwms of varying width/duty. SIZE is the bit size of
the period, and the PERIOD parameter is used to fine tune the period/frequency of the signal.
The input "duty" is the duration of the pulse width and duty/period can be used to calculate the
duty cycle.
-------------------------------------------------------
Author : Akhil Kapadia
-------------------------------------------------------
*/
//Instantiate the module and declare inputs, output, and/or parameters.
module pwm #(parameter SIZE = 8, PERIOD = 255)
(input clk,				//The clock the PWM is based off. (BASYS 10 ns)
input [SIZE-1:0] duty,	//The percentage of time the PWM is on for
output reg pulse);

//Create local register to count to the duty cycle
reg [SIZE-1:0] count;	//This controls the period of the PWM.

//Initalize all registers. This is useful for testbench purposes.
initial
	begin
		count <=0;
		pulse <= 0;
	end

//As the pwm is based on the BASYS clk, we use procedural assignment.
always @ (posedge clk)
	begin
//Increase Count each time the BASYS clock pulses. 
//The ? is called the ternary operator and it is shorthand for ifelse.
//It works with the assign statement and is the only way to do condtional statements
//outside of a procedural (always@) block.
		count <= (count < PERIOD) ? count + 1 : 0;
//Send out a signal according to what duty is.
		pulse <= (count < duty) ? 1 : 0;
		//<= is nonblocking and = is blocking. <= doesn't wait for code to execute, 
		//while = waits for the previous line to execute.
	end
endmodule