module true_dual_port_ram_single_clock_tb
(
lcd1, 
lcd2, 
lcd3, 
lcd4,
clk
);

reg[15:0] data_a, data_b;
reg[9:0] addr_a, addr_b;
reg we_a, we_b;
wire[15:0] q_a, q_b;
output wire[6:0] lcd1, lcd2, lcd3, lcd4;
input clk;

integer counter = 0;

mem_lab uut
(
	.data_a(data_a), 
	.data_b(data_b),
	.addr_a(addr_a), 
	.addr_b(addr_b),
	.we_a(we_a), 
	.we_b(we_b), 
	.clk(clk),
	.q_a(q_a), 
	.q_b(q_b)
);

	hexTo7Seg seg1(q_a[3:0], lcd1);
	hexTo7Seg seg2(q_a[7:4], lcd2);
	hexTo7Seg seg3(q_a[11:8], lcd3);
	hexTo7Seg seg4(q_a[15:12], lcd4);

	always @ (negedge clk)
		begin
			counter = counter+1;
			case(counter)
			 1: begin
					we_a = 1;
					addr_a = 10'b0;
					data_a = 30;
				end
			2: begin
					we_a = 0;
					addr_a = 10'b0;
					data_a = 0;
				end
			3: begin
					we_a = 1;
					addr_a = 0;
					data_a = 400;
				end
			endcase
		end
	
	
	
endmodule
