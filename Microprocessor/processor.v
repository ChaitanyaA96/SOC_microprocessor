module processor(clk, rst, Addr, alu_result);
	
	input clk,rst;
	input [31:0]Addr;
	output [31:0]alu_result;
	wire [3:0]ALUCtrl;
	
	wire [31:0] instruction;
	wire [5:0] opcode, funct;
	wire [4:0] rs, rt, rd, shamt, reg_rw_mux;
	wire [15:0] immediate16;
	wire [25:0] immediate26;
	wire [31:0] target_address;
	wire [31:0] acc_input_1, acc_input_2, sign_extended;
	wire [31:0] data_mem_out, bus_w_mux, register_out_bus_b;
	wire reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write; 
	wire branch_on_eq, branch_on_neq, alu_zero, jump, ext_op, zero, inc_pc, pc_src;
	wire write_to_reg32;
	



	program_counter prog_count(.clk(clk),
							   .rst(rst),
							   .next_pc_addr(target_address),
							   .inc_pc(inc_pc),
							   .pc_src(pc_src),
							   .address(Addr));
	
	next_pc next_pc(.immediate16(immediate16),
						  .immediate26(immediate26),
						  .pc(Addr),
						  .jump(jump),
						  .zero(zero),
						  .branch_on_eq(branch_on_eq),
						  .branch_on_neq(branch_on_neq),
						  .pc_src(pc_src),
						  .target_address(target_address));

	inst_mem inst_mem(.clk(clk),
					  .rst(rst),
					  .addr(Addr),
					  .instruction(instruction));

	// Decode the instruction
	assign opcode = instruction[31:26];
	assign rs = instruction[25:21];
	assign rt = instruction[20:16];
	assign rd = instruction[15:11];
	assign shamt = instruction[10:6];
	assign funct = instruction[5:0];
	assign immediate16 = instruction[15:0];
	assign immediate26 = instruction[25:0];
	assign write_to_reg32 <= (opcode == 6'b000011) ? 1'b1 : 1'b0;
	
	assign sign_extended = {{16{immediate16[15]}}, immediate16};

	assign acc_input_2 = (alu_src)?sign_extended:register_out_bus_b;

	ALU ALU(.a(acc_input_1), 
			.b(acc_input_2), 
			.alu_ctrl(ALUCtrl), 
			.shamt(shamt), 
			.result(alu_result),
			.zout(zero));

	FSM fsm_control(.clk(clk),
					.rst(rst),
					.opcode(opcode),
					.funct(funct),
					.zero(zero),
					.reg_write(reg_write),
					.reg_dst(reg_dst),
					.ext_op(ext_op),
					.alu_src(alu_src),
					.mem_read(mem_read),
					.mem_to_reg(mem_to_reg),
					.mem_write(mem_write),
					.branch_on_eq(branch_on_eq),
					.branch_on_neq(branch_on_neq),
					.jump(jump),
					.ALUCtrl(ALUCtrl),
					.inc_pc(inc_pc)
					);
	
	assign reg_rw_mux = write_to_reg32 ? 5'b10000 : (reg_dst)?rd:rt;

	assign bus_w_mux = write_to_reg32 ? Addr : (mem_to_reg)?data_mem_out:alu_result;

	Register Register(.clk(clk),
					  .rst(rst),
					  .Ra(rs),
					  .Rb(rt),
					  .Rw(reg_rw_mux),
					  .bus_w(bus_w_mux),
					  .regWrite(reg_write),
					  .bus_a(acc_input_1),
					  .bus_b(register_out_bus_b)					  
					  );
	
	DataMemory DataMemory(
		.clk(clk),
		.rst(rst),
		.addr(alu_result),
		.data_in(register_out_bus_b),
		.mem_read(mem_read),
		.mem_write(mem_write),
		.data_out(data_mem_out)
	);

endmodule