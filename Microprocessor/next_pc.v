module next_pc(
    input [15:0] immediate16,
    input [25:0] immediate26,
    input [31:0] pc,
    input zero,
    input jump,
    input branch_on_eq,
    input branch_on_neq,
    output reg pc_src,
    output reg [31:0] target_address
);

    wire [31:0] sign_extended;
    wire [31:0] branch_target;
    wire [31:0] jump_target;

    assign sign_extended = {{14{immediate16[15]}}, immediate16, 2'b00};

    assign branch_target = pc + 1 + sign_extended;

    assign jump_target = {pc[31:28], immediate26, 2'b00};

    always @(*) begin
        if (jump == 1'b1) begin
            pc_src = 1'b1;
            target_address = jump_target;
        end
        else if (((branch_on_eq == 1'b1) && (zero == 1'b1)) || ((branch_on_neq == 1'b1) && (zero == 1'b0))) begin
            pc_src = 1'b1;
            target_address = branch_target;
        end
        else begin
            pc_src = 1'b0;
            target_address = 32'b0;  // Default case
        end
    end

endmodule
