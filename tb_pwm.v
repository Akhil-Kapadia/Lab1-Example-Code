/*
Filename : pwm_TB.v
-------------------------------------------------------
Pulse Width Modulation TestBench
-------------------------------------------------------
Instantiates the "pwm" module from "pwm.v" and creates several wayforms of varying
periods and duty cycles.

Run these lines in console to simulate. Click on tb_pwm.vcd to see the waveform.
iverilog -o pwm tb_pwm.v
vvp pwm

Requires having installed iverilog (Windows: https://bleyer.org/icarus/) and the "WaveTrace" extension in VSCode.
-------------------------------------------------------
Author : Akhil Kapadia
-------------------------------------------------------
*/
`timescale 1ns/1ps
// delete this line if in vivado
`include "pwm.v"

module tb_pwm();
     // Create the register for the simulated BASYS clk.
     reg clk;
     // Create a wire for the duty to be used. Make the bit size equal to whatever you instantiate the pwm with.
     reg [7:0] duty = 8;
     wire pulse;

     // Instantiate the modules we're testbenching.
     //pwm module with default period and size.     
     pwm #(8, 255)
     wave1(
          .clk (clk),
          .duty (duty),
          .pulse (pulse)
     );

     initial begin
     // If simulating through VSCode and using iverilog (REQUIRED)
          $dumpfile("tb_pwm.vcd");     // Name of waveform output
          $dumpvars(0, tb_pwm);  
          $display("Begin testbench logging\n\n");
     end

     initial begin
     // Initialize the clock to 0.
          // add test conditions if needed to print to console.
          $display("The duty is: %d", duty);
          clk = 0;
          //After a period passes change the duty cycle.
          #2560
          duty = 128; //50% duty cycle
          #10240
          duty = 192; //75% duty cycle
          #10240
          $finish; // don't forget this or sim will run forever.
     end

     //Simulate the BASYS 10ns clock.
     always #5 clk = ~clk;

endmodule