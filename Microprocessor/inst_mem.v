module inst_mem(
input wire [31:0] addr,
input wire clk,
input wire rst,

output wire [31:0] instruction

);
// read text instruction into a memory bank and write it to memory register
parameter MEM_DEPTH = 19;

reg [31:0] inst_memory[MEM_DEPTH:0];

assign instruction = inst_memory[addr];

initial begin
    $readmemh("INST.txt", inst_memory);
end

endmodule 