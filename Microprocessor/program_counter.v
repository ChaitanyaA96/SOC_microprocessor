module program_counter(
    input clk,
    input rst,
    input [31:0] next_pc_addr,
    input pc_src,
    input inc_pc,
    output wire [31:0] address
);

    reg [31:0] PC;
	assign address = PC;

    always @(posedge clk or posedge rst) begin
        if (rst) 
            PC <= 32'b0;  // Reset PC to 0
        else if(inc_pc)
            PC <= pc_src ? next_pc_addr : PC + 4;
        else
            PC <= PC;
    end

endmodule
