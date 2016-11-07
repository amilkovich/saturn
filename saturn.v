module saturn (
	input clock_100MHz,

	//inout [7:0] data,
	//input rxf,
	//input txe,
	//output rd,
	//output wr,
	//output siwua,

	//output [12:0] dram_a,
	//inout [15:0] dram_dq,
	//output [1:0] dram_ba,
	//output dram_ras_n,
	//output dram_cas_n,
	//output dram_we_n,
	//output dram_ck,
	//output dram_ck_n,
	//output dram_cke,
	//output dram_dm,
	//inout dram_dqs,
	//output dram_udm,
	//inout dram_udqs,
	//inout rzq,

	inout [96:0] gpio_p3,
	inout [96:0] gpio_p2
);

reg led;
assign gpio_p3 [5] = led;

reg [31:0] counter = 0;

always @ (posedge clock_100MHz)
begin
	counter <= counter + 1;

	if (counter == 104857600)
	begin
		counter <= 0;
		led <= ~led;
	end
end

endmodule
