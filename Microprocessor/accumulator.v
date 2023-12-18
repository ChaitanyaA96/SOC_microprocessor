module accumulator(clk, rst, alu_out, SelAcc, LoadAcc, Imm, Reg_data, acc_data);

	input clk,clb,LoadAcc;
	input [1:0]SelAcc;
	input [3:0]Imm;
	input [7:0]Reg_data,alu_out;
	
	output reg [7:0]acc_data;
	
	wire [7:0]lowermux_out,uppermux_out;
	
	assign lowermux_out=((SelAcc[0]==0)?{4'd0,Imm}:Reg_data);
	assign uppermux_out=((SelAcc[1]==0)?lowermux_out:alu_out);
	
	always @(posedge clk)
	begin
		if(clb==0)
			acc_data<=0;
		else if (LoadAcc==0)
			acc_data<=acc_data;
		else 
			acc_data<=uppermux_out;
	end 
	
endmodule