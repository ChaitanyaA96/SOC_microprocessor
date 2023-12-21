`timescale 1ns/1ps

module test_pc;

  reg clk;             // Clock signal
  reg rst;             // Reset signal

  wire [31:0] PC;
  wire [31:0] alu_result;
  


  // Clock generation
  initial begin
    clk <= 0;
    rst <= 0;


    #10
    rst <= 1;
    #500 $stop;
  end

  // Toggle the clock every 5 time units
  always begin
    #5 clk = ~clk;
  end

 processor uut (
    .clk(clk),
    .rst(rst),
    .alu_result(alu_result),
    .Addr(PC)

  );

endmodule