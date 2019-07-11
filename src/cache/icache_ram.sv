module icache_ram #(
	// default data width if the fifo is of type logic
	parameter int unsigned DATA_WIDTH = 32,
	// $bits(dtype) * SIZE = bits of the block RAM
	parameter int unsigned SIZE       = 1024,
	parameter type dtype              = logic [DATA_WIDTH-1:0]
) (
	input  logic  clk,
	input  logic  rst,
	input  logic  we,
	input  logic  [$clog2(SIZE)-1:0] addr,
	input  dtype  din,
	output dtype  dout
);

// xpm_memory_spram: Single Port RAM
// Xilinx Parameterized Macro, Version 2016.2
xpm_memory_spram #(
	// Common module parameters
	.MEMORY_SIZE($bits(dtype) * SIZE),
	.MEMORY_PRIMITIVE("auto"),
	.CLOCKING_MODE("common_clock"),
	.USE_MEM_INIT(0),
	.WAKEUP_TIME("disable_sleep"),
	.MESSAGE_CONTROL(0),

	// Port A module parameters
	.WRITE_DATA_WIDTH_A($bits(dtype)),
	.READ_DATA_WIDTH_A($bits(dtype)),
	.READ_RESET_VALUE_A("0"),
	.READ_LATENCY_A(1),
	.WRITE_MODE_A("write_first")
) xpm_mem (
	// Common module ports
	.sleep          ( 1'b0  ),

	// Port A module ports
	.clka           ( clk   ),
	.rsta           ( rst   ),
	.ena            ( 1'b1  ),
	.regcea         ( 1'b0  ),
	.wea            ( we    ),
	.addra          ( addr  ),
	.dina           ( din   ),
	.injectsbiterra ( 1'b0  ), // do not change
	.injectdbiterra ( 1'b0  ), // do not change
	.douta          ( dout  ),
	.sbiterra       (       ), // do not change
	.dbiterra       (       )  // do not change
);

endmodule
