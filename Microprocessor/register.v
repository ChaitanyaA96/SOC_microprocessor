module Register (
  input wire clk,        // Clock input
  input wire rst,        // Reset input
  input wire [4:0] Ra, // first register input (32-bit address)
  input wire [4:0] Rb, //second register input 
  input wire [4:0] Rw, //dst register address
  input wire [31:0] bus_w , // wirte operation to register
  input wire regWrite,

  output wire [31:0] bus_a,
  output wire [31:0] bus_b
);

integer i;



// Internal memory array
reg [31:0] register_mem [31:0];


assign bus_a = register_mem[Ra];
assign bus_b = register_mem[Rb];

always @(posedge clk or  rst) begin
	if (rst == 1'b0)begin
		for(i = 0; i < 32; i = i + 1) register_mem[i][31:0] = 0;
    	end 
	else begin
      // Write operation
     		 if (regWrite) begin
			 	register_mem[Rw]<= bus_w;
		 end 
		
      	end 
end

endmodule