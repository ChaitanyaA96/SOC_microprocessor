module FSM(
	input rst,
	input zero,
	input [5:0]opcode,
	input [5:0]funct,
	output reg reg_dst, reg_write, ext_op, alu_src, mem_read, mem_write, mem_to_reg, branch_on_eq, branch_on_neq, jump,
	output reg [3:0]ALUCtrl);
	
	always @(*)
		begin
			case(opcode)
				// R-type instruction
				6'b000000:
				begin
					case(funct)
					6'b100000://Add
						begin
							reg_dst=1'b1;
							reg_write=1'b1;
							alu_src = 1'b0;
							branch_on_eq = 1'b1;
							branch_on_neq = 1'b0;
							jump = 1'b0;
							mem_read = 1'b0;
							mem_write = 1'b0;
							mem_to_reg = 1'b0;
							ALUCtrl=4'b0000;
						end	
					6'b100010://Subtarct
						begin
							reg_dst=1'b1;
							reg_write=1'b1;
							alu_src = 1'b0;
							branch_on_eq = 1'b1;
							branch_on_neq = 1'b0;
							jump = 1'b0;
							mem_read = 1'b0;
							mem_write = 1'b0;
							mem_to_reg = 1'b0;
							ALUCtrl=4'b0010;
						end
					6'b100111://NOR
						begin
							reg_dst=1'b1;
							reg_write=1'b1;
							alu_src = 1'b0;
							branch_on_eq = 1'b1;
							branch_on_neq = 1'b0;
							jump = 1'b0;
							mem_read = 1'b0;
							mem_write = 1'b0;
							mem_to_reg = 1'b0;
							ALUCtrl=4'b0101;
						end
					6'b100100://AND
						begin
							reg_dst=1'b1;
							reg_write=1'b1;
							alu_src = 1'b0;
							branch_on_eq = 1'b1;
							branch_on_neq = 1'b0;
							jump = 1'b0;
							mem_read = 1'b0;
							mem_write = 1'b0;
							mem_to_reg = 1'b0;
							ALUCtrl=4'b0100;
						end
					6'b000000://Shift Left
						begin
							reg_dst=1'b1;
							reg_write=1'b1;
							alu_src = 1'b0;
							branch_on_eq = 1'b1;
							branch_on_neq = 1'b0;
							jump = 1'b0;
							mem_read = 1'b0;
							mem_write = 1'b0;
							mem_to_reg = 1'b0;
							ALUCtrl=4'b1010;
						end
					6'b000010://Shift Right
						begin
							reg_dst=1'b1;
							reg_write=1'b1;
							branch_on_eq = 1'b1;
							branch_on_neq = 1'b0;
							jump = 1'b0;
							alu_src = 1'b0;
							mem_read = 1'b0;
							mem_write = 1'b0;
							mem_to_reg = 1'b0;
							ALUCtrl=4'b1011;
						end
					6'b001000://Jump Reg
						begin
						end
					endcase
				end
				
				6'b001000://Add Immediate
				begin
					reg_dst = 1'b0;
					branch_on_eq = 1'b1;
					branch_on_neq = 1'b0;
					jump = 1'b0;
					mem_read = 1'b0;
					mem_write = 1'b0;
					mem_to_reg = 1'b0;
					alu_src = 1'b1;
					reg_write = 1'b1;
					ALUCtrl = 4'b0000;
				end

				6'b001100://And Immediate
				begin
					reg_dst = 1'b0;
					branch_on_eq = 1'b1;
					branch_on_neq = 1'b0;
					jump = 1'b0;
					mem_read = 1'b0;
					mem_write = 1'b0;
					mem_to_reg = 1'b0;
					alu_src = 1'b1;
					reg_write = 1'b1;
					ALUCtrl = 4'b0100;
				end

				6'b000100://Branch on EQ
				begin
					reg_dst = 1'b0;
					branch_on_eq = 1'b1;
					branch_on_neq = 1'b0;
					mem_read = 1'b0;
					mem_write = 1'b0;
					mem_to_reg = 1'b0;
					alu_src = 1'b1;
					reg_write = 1'b0;
					ALUCtrl = 4'b0010;
				end


				6'b000101://Branch on NEQ
				begin
					reg_dst = 1'b0;
					branch_on_eq = 1'b0;
					branch_on_neq = 1'b1;
					mem_read = 1'b0;
					mem_write = 1'b0;
					mem_to_reg = 1'b0;
					alu_src = 1'b1;
					reg_write = 1'b0;
					ALUCtrl = 4'b0010;
				end


				6'b000010://Jump
				begin
					reg_dst = 1'b0;
					branch_on_eq = 1'b0;
					branch_on_neq = 1'b0;
					jump = 1'b1;
					mem_read = 1'b0;
					mem_write = 1'b0;
					mem_to_reg = 1'b0;
					alu_src = 1'b0;
					reg_write = 1'b0;
					ALUCtrl = 4'b1111;
				end


				6'b000011://Jump and Link
				begin
					
				end

				6'b110000://Load Word
				begin
					reg_dst = 1'b0;
					branch_on_eq = 1'b0;
					branch_on_neq = 1'b0;
					jump = 1'b0;
					mem_read = 1'b1;
					mem_write = 1'b0;
					mem_to_reg = 1'b1;
					alu_src = 1'b1;
					reg_write = 1'b1;
					ALUCtrl = 4'b0000;
				end

				6'b101011://Store Word
				begin
					reg_dst = 1'b0;
					branch_on_eq = 1'b0;
					branch_on_neq = 1'b0;
					jump = 1'b0;
					mem_read = 1'b0;
					mem_write = 1'b1;
					mem_to_reg = 1'b0;
					alu_src = 1'b1;
					reg_write = 1'b0;
					ALUCtrl = 4'b0000;
				end

				6'b111111://No operation
				begin
					begin
						
					end
				end

				6'b000110://Stall
				begin
					begin
						
					end
				end

				default:
				begin
					reg_dst = 0;
					reg_write = 0;
					ext_op = 0;
					alu_src = 0;
					mem_write = 0;
					mem_read = 0;
					mem_to_reg = 0;
					branch_on_eq = 0;
					branch_on_neq = 0;
					jump = 0;
					ALUCtrl=4'b1111;
				end
			endcase
		end
	
endmodule