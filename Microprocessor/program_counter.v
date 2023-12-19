//program counter
module program_counter(
//Define Inputs and outputs
output wire [31:0] address,

input wire [25:0] Imm26,
input wire [15:0] Imm16,
input wire rst,
input wire clk,
input wire Z,
input wire J,
input wire Beq,
input wire Bne,
input wire IncPC
);

reg [31:0] pc;
assign address = {2'b00, pc[29:0]};

always @(posedge clk or posedge rst) begin
    if (rst) begin
      pc <= 0;
    end 
	else begin
      if (Z && Beq) begin
        pc <= pc + Imm26;
      end else if (!Z && Bne) begin
        pc <= pc + Imm26;
      end else if (J) begin
        pc <= Imm26;
      end else begin
        pc <= pc + 4;
      end
    end
  end

endmodule

/*
always @(posedge clk or CLB)
begin
	if(rst == 1'b0) begin
		pc <= 32'b0;
	end
	else begin
		if (LoadPC == 1'b1) begin
			pc <= selPC?regIn:{4'b0, imm};
		end
		else begin
			pc <= IncPC? (pc + 1) : pc;
		end
	end
end
*/
