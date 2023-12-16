module DataMemory (
  input wire clk,        // Clock input
  input wire rst,        // Reset input
  input wire [31:0] addr, // Address input (32-bit address)
  input wire [31:0] data_in, // Write data input (32-bit data)
  input wire mem_read,
  input wire mem_write,        
  output wire [31:0] data_out // Read data output (32-bit data)
);

  // Parameter definitions
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 20;
  parameter MEM_DEPTH = 1 << ADDR_WIDTH;
  integer i;


  // Internal memory array
  reg [DATA_WIDTH-1:0] mem [MEM_DEPTH-1:0];
 
  assign data_out = (mem_read)?32'hx:mem[addr];

  // Sequential logic for read and write operations
  always @(posedge clk) begin
      // Write operation
      if (mem_write) begin
        mem[addr] <= data_in;
      end
  end

endmodule