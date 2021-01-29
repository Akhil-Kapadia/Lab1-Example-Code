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
`timescale 1ns/1ps

module pwm_tb();
     // Create the register for the simulated BASYS clk.
     reg clk;
     // Create a wire for the duty to be used. Make the bit size equal to whatever you instantiate the pwm with.
     reg [7:0] duty = 8;
     wire pulse;

     // Instantiate the modules we're testbenching.
     //pwm module with default period and size.     
     pwm #(8, 255)
     wave1(
          .clk(clk),
          .duty(duty),
          .pulse(pulse)
     );

     initial begin
     // Initialize the clock to 0.
          clk = 0;
          //After a period passes change the duty cycle.
          #2560
          duty = 128; //50% duty cycle
          #10240
          duty = 192; //75% duty cycle


     end

     //Simulate the BASYS 10ns clock.
     always #5 clk = ~clk;

endmodule