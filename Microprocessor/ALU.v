module ALU (
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [3:0] alu_ctrl,
    input wire [4:0] shamt,
    output reg [31:0] result,
    output wire zout
);

// Declare necessary registers or wires
always @* begin
    case (alu_ctrl) 
        4'b0000: result = a + b;   // ADD
        4'b0010: result = a - b;   // SUB
        4'b0100: result = a & b;   // AND
        4'b0101: result = ~(a | b); // NOR
        4'b1010: result = (shamt == 0) ? b : (b << shamt);// SLL
        4'b1011: result = (shamt == 0) ? b : (b >> shamt); // SRL
        default: result = 32'hxxxx_xxxx; // Default value for not specified cases
    endcase
end

assign zout = (result == 32'h0000_0000);

endmodule
