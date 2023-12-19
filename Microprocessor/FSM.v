module FSM(Addr, clk, rst, RegDst, RegWrite, ExtOp, ALUSrc, ALUOp, MemWrite, MemRead, MemtoReg, Beq, Bne, J, ALUCtrl, Z);
	// Inputs
	input clk,rst,Z;
	input [5:0]Addr;

	//Outputs
	output reg RegDst, RegWrite, ExtOp, ALUSrc, ALUOp, MemWrite, MemRead, MemtoReg, Beq, Bne, J;
	output reg [3:0]ALUCtrl;
	
	always @(posedge clk)
	begin
		if(clb==0)
			begin
				RegDst <= 0;
				RegWrite <= 0;
				ExtOp <= 0;
				ALUSrc <= 0;
				ALUOp <= 0;
				MemWrite <= 0;
				MemRead <= 0;
				MemtoReg <= 0;
				Beq <= 0;
				Bne <= 0;
				J <= 0;
			end
		else
		begin

			case(opcode)
				// R-type instruction
				6'b000000:
				begin
					case(funct)
					6'b100000://Add
						begin
							RegDst<=1;
							RegWrite<=1;
							ALUOp<=1;
							ALUSrc<=0;
							Beq <= 0;
							Bne <= 0;
							J <= 0;
							MemWrite <= 0;
							MemRead <= 0;
							MemtoReg <= 0;
							ALUCtrl<=4'b0000;
						end	
					6'b100010://Subtarct
						begin
							RegDst<=1;
							RegWrite<=1;
							ALUOp<=1;
							ALUSrc<=0;
							Beq <= 0;
							Bne <= 0;
							J <= 0;
							MemWrite <= 0;
							MemRead <= 0;
							MemtoReg <= 0;
							ALUCtrl<=4'b0010;
						end
					6'b100111://NOR
						begin
							RegDst<=1;
							RegWrite<=1;
							ALUOp<=1;
							ALUSrc<=0;
							Beq <= 0;
							Bne <= 0;
							J <= 0;
							MemWrite <= 0;
							MemRead <= 0;
							MemtoReg <= 0;
							ALUCtrl<=4'b0101;
						end
					6'b100100://AND
						begin
							RegDst<=1;
							RegWrite<=1;
							ALUOp<=1;
							ALUSrc<=0;
							Beq <= 0;
							Bne <= 0;
							J <= 0;
							MemWrite <= 0;
							MemRead <= 0;
							MemtoReg <= 0;
							ALUCtrl<=4'b0100;
						end
					6'b000000://Shift Left
						begin
							RegDst<=1;
							RegWrite<=1;
							ALUOp<=1;
							ALUSrc<=0;
							Beq <= 0;
							Bne <= 0;
							J <= 0;
							MemWrite <= 0;
							MemRead <= 0;
							MemtoReg <= 0;
							ALUCtrl<=4'b1010;
						end
					6'b000010://Shift Right
						begin
							RegDst<=1;
							RegWrite<=1;
							ALUOp<=1;
							ALUSrc<=0;
							Beq <= 0;
							Bne <= 0;
							J <= 0;
							MemWrite <= 0;
							MemRead <= 0;
							MemtoReg <= 0;
							ALUCtrl<=4'b1011;
						end
					6'b001000://Jump Reg
						begin
							SelPC<=1'b0;
							LoadPC<=1'b0;
							LoadReg<=1'b0;
							LoadAcc<=1;
							SelAcc<=2'b10;
							ALUOp<=1;
							ALUCtrl<=4'b0001;
						end
					//Add testcase for Jump Reg
					endcase
				end
				
				6'b001000://Add Immediate
				begin
					if(z==1'b1)
					begin
						SelPC<=1'b1;LoadPC<=1'b1;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
					else 
					begin
						SelPC<=1'b0;LoadPC<=1'b0;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
				end

				6'b001100://And Immediate
				begin
					if(z==1'b1)
					begin
						SelPC<=1'b1;LoadPC<=1'b1;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
					else 
					begin
						SelPC<=1'b0;LoadPC<=1'b0;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
				end

				6'b000100://Branch on EQ
				begin
					if(z==1'b1)
					begin
						SelPC<=1'b1;LoadPC<=1'b1;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
					else 
					begin
						SelPC<=1'b0;LoadPC<=1'b0;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
				end

				6'b000101://Branch on NEQ
				begin
					if(z==1'b1)
					begin
						SelPC<=1'b1;LoadPC<=1'b1;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
					else 
					begin
						SelPC<=1'b0;LoadPC<=1'b0;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
				end

				6'b000010://Jump
				begin
					if(z==1'b1)
					begin
						SelPC<=1'b1;LoadPC<=1'b1;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
					else 
					begin
						SelPC<=1'b0;LoadPC<=1'b0;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
				end

				6'b000011://Jump and Link
				begin
					if(z==1'b1)
					begin
						SelPC<=1'b1;LoadPC<=1'b1;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
					else 
					begin
						SelPC<=1'b0;LoadPC<=1'b0;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
				end

				6'b110000://Load Word
				begin
					if(z==1'b1)
					begin
						SelPC<=1'b1;LoadPC<=1'b1;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
					else 
					begin
						SelPC<=1'b0;LoadPC<=1'b0;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
				end

				6'b101011://Store Word
				begin
					if(z==1'b1)
					begin
						SelPC<=1'b1;LoadPC<=1'b1;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
					else 
					begin
						SelPC<=1'b0;LoadPC<=1'b0;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
				end

				6'b111111://No operation
				begin
					if(z==1'b1)
					begin
						SelPC<=1'b1;LoadPC<=1'b1;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
					else 
					begin
						SelPC<=1'b0;LoadPC<=1'b0;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
				end

				6'b000110://Stall
				begin
					if(z==1'b1)
					begin
						SelPC<=1'b1;LoadPC<=1'b1;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
					else 
					begin
						SelPC<=1'b0;LoadPC<=1'b0;LoadReg<=1'b0;LoadAcc<=0;SelAcc<=2'b00;ALUCtrl<=4'b0000;
					end
				end

				default:
				begin
					SelPC<=SelPC;LoadPC<=LoadPC;LoadReg<=LoadReg;LoadAcc<=1'b0;SelAcc<=SelAcc;ALUCtrl<=ALUCtrl;
				end
			endcase
		end
	end 
	
	always @(posedge cycle_status)
	begin
		if(rst==0)
			LoadIR<=0;
		else 
			LoadIR<=(cycle_status==1)?1:0;
	end
	
	always @(posedge clk)
	begin
		if(rst==0)
			IncPC<=0;
		else if(((opcode==4'b0110)&(z==1'b1))|((opcode==4'b0111)&(z==1'b1))|((opcode==4'b1000)&(c==1'b1))|((opcode==4'b1010)&(c==1'b1))|(opcode==4'b1111))
			IncPC<=0;
		else 
			IncPC<=~IncPC;
	end
	
	always @(posedge clk)
	begin
		if(clb==0)
			cycle_status<=0;
		else
			cycle_status<=~cycle_status;
	end
	
endmodule