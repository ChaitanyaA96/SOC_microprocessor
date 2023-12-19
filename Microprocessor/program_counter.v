module program_counter(
    input clk,
    input rst,
    input [31:0] next_pc,
    input pc_src,
    output wire [31:0] address
);

    reg [31:0] PC;
	assign address = PC;

    always @(posedge clk or posedge rst) begin
        if (rst) 
            PC <= 32'b0;  // Reset PC to 0
        else 
            PC <= pc_src ? next_pc : PC + 4;  // Select next PC based on pc_src
    end

endmodule
