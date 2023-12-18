module processor(clk,CLB,instruction_in,z,c,address);
		
	
	input clk,rst;
	input [31:0]instr_op;
	
	wire RegDst, RegWrite, ExtOp, ALUSrc, MemWrite, MemRead, MemtoReg, Beq, Bne, J;
	wire [3:0]ALUCtrl;

	//Any additional wires if required
	//wire [7:0]reg_data,acc_data,instr,alu_out;
	
	always @(posedge clk)
		imm=instr[3:0];
	assign opcode=instr[7:4];
	assign RegAddr=imm;

	inst_mem inst_mem(.clk(clk),.rst(rst),.addr(address),.instruction(instr)); //complted

	//accumulator accumulator(.clk(clk),.clb(CLB),.SelAcc(SelAcc),.LoadAcc(LoadAcc),.Imm(imm),.Reg_data(reg_data),.acc_data(acc_data),.alu_out(alu_out));

	ALU ALU(.a(acc_data), .b(reg_data), .alu_ctrl(ALUCtrl), .shamt(shamt), .result(result));

	//FSM fsm_control(.clk(clk),.clb(CLB),.z(z),.c(c),.opcode(opcode),.LoadIR(LoadIR),.IncPC(IncPC),.SelAcc(SelAcc),.SelPC(SelPC),.LoadPC(LoadPC),.LoadReg(LoadReg),.LoadAcc(LoadAcc),.SelALU(SelALU),.cycle_status(cycle_status));

	//reg_file reg_mem(.clk(clk),.CLB(CLB),.LoadReg(LoadReg),.reg_in(acc_data),.RegAddr(RegAddr),.reg_out(reg_data));

	//program_counter prog_count(.clk(clk),.CLB(CLB),.IncPC(IncPC),.LoadPC(LoadPC),.selPC(SelPC),.regIn(reg_data),.imm(imm),.address(address));
		
endmodule