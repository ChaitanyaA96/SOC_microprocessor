module processor(clk, rst, PC, alu_result);
		
	
	input clk,rst;
	input [31:0]PC;
	output [31:0]alu_result;
	
	wire [3:0]ALUCtrl;
	
	// Internal Signals
	wire [31:0] instruction;
	wire [5:0] opcode, funct;
	wire [4:0] rs, rt, rd, shamt;
	wire [15:0] immediate;
	wire [31:0] read_data_1, read_data_2, alu_src_2, write_data;
	wire [31:0] alu_out, memory_out;
	wire reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch_on_eq, branch_on_neq, alu_zero, jump, inc_pc, ext_op;

	always @(posedge clk)
		imm=instr[3:0];
	assign opcode=instr[7:4];
	assign RegAddr=imm;

	program_counter prog_count(.clk(clk),
							   .CLB(CLB),
							   .IncPC(IncPC),
							   .LoadPC(LoadPC),
							   .selPC(SelPC),
							   .regIn(reg_data),
							   .imm(imm),
							   .address(address));

	inst_mem inst_mem(.clk(clk),
					  .rst(rst)
					  .addr(address),
					  .instruction(instruction));

	// Decode the instruction
	assign opcode = instruction[31:26];
	assign rs = instruction[25:21];
	assign rt = instruction[20:16];
	assign rd = instruction[15:11];
	assign shamt = instruction[10:6];
	assign funct = instruction[5:0];
	assign immediate = instruction[15:0];

	FSM fsm_control(.clk(clk),
					.rst(rst),
					.opcode(opcode),
					.funct(funct),
					.reg_write(reg_write),
					.reg_dst(reg_dst),
					.LoadPC(LoadPC)
					,.LoadReg(LoadReg),
					.LoadAcc(LoadAcc),
					.SelALU(SelALU),
					.cycle_status(cycle_status));

	//accumulator accumulator(.clk(clk),.clb(CLB),.SelAcc(SelAcc),.LoadAcc(LoadAcc),.Imm(imm),.Reg_data(reg_data),.acc_data(acc_data),.alu_out(alu_out));

	ALU ALU(.a(acc_data), .b(reg_data), .alu_ctrl(ALUCtrl), .shamt(shamt), .result(result));

	

	//reg_file reg_mem(.clk(clk),.CLB(CLB),.LoadReg(LoadReg),.reg_in(acc_data),.RegAddr(RegAddr),.reg_out(reg_data));

	//program_counter prog_count(.clk(clk),.CLB(CLB),.IncPC(IncPC),.LoadPC(LoadPC),.selPC(SelPC),.regIn(reg_data),.imm(imm),.address(address));
		
endmodule