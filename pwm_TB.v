/*
Filename : pwm_TB.v
-------------------------------------------------------
Pulse Width Modulation TestBench
-------------------------------------------------------
Instantiates the "pwm" module from "pwm.v" and creates several wayforms of varying
periods and duty cycles.
-------------------------------------------------------
Author : Akhil Kapadia
-------------------------------------------------------
*/

module pwm_tb();
     // Create the register for the simulated BASYS clk.
     reg clk;
     // Create a wire for the duty to be used. Make the bit size equal to whatever you instantiate the pwm with.
     wire [16:0] duty1;
     wire [17:0] duty2;
     wire pulse1;
     wire pulse2;
     // Instantiate the modules we're testbenching.

     //pwm 1: Period of the full 16 bits and a duty cycle of 40%
     assign duty1[16:0] = 26214; //65535 * 0.40 = 26214
     pwm #(17,  65535)
     wave1(
          .clk(clk),
          .duty(duty1),
          .pulse(pulse1)
     );

     //pwm 2: Create a period of 1 ms and a duty cycle of 10%
     assign duty2[17:0] = 10000;
     pwm #(17,  100000)
     wave2(
          .clk(clk),
          .duty(duty2),
          .pulse(pulse2)
     );

     initial begin
     // Initialize the clock to 0.
          clk = 0;
          // Simulate the clock using a forever loop. 
          forever #5 clk = !clk;
     end

endmodule