module mojo_top(
    // 50MHz clock input
    input clk,
    // Input from reset button (active low)
    input rst_n,
    // cclk input from AVR, high when AVR is ready
    input cclk,
    // Outputs to the 8 onboard LEDs
    output[7:0]led,
    // AVR SPI connections
    output spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    // AVR ADC channel select
    output [3:0] spi_channel,
    // Serial connections
    input avr_tx, // AVR Tx => FPGA Rx
    output avr_rx, // AVR Rx => FPGA Tx
    input avr_rx_busy, // AVR Rx buffer full

    input pin_a,      // SN74LS49 bit A
    input pin_b,      // SN74LS49 bit B
    input pin_c,      // SN74LS49 bit C
    input pin_d,      // SN74LS49 bit D
    input pin_bi_n,   // SN74LS49 Blanking Input, active low
	 
    output segment_a, // SN74LS49 segment A output
    output segment_b, // SN74LS49 segment B output
    output segment_c, // SN74LS49 segment C output
    output segment_d, // SN74LS49 segment D output
    output segment_e, // SN74LS49 segment E output
    output segment_f, // SN74LS49 segment F output
    output segment_g  // SN74LS49 segment G output

    );

wire rst = ~rst_n; // make reset active high

// these signals should be high-z when not used
assign spi_miso = 1'bz;
assign avr_rx = 1'bz;
assign spi_channel = 4'bzzzz;

// LED 0 won't be used
assign led[0] = 1'b0;

// Outputs on onboard LEDs
sn74ls49 fpga74ls49_onboardLEDs (
	.pin_a(pin_a),
	.pin_b(pin_b),
	.pin_c(pin_c),
	.pin_d(pin_d),
	.pin_bi_n(pin_bi_n),
	.segment_a(led[7]),
	.segment_b(led[6]),
	.segment_c(led[5]),
	.segment_d(led[4]),
	.segment_e(led[3]),
	.segment_f(led[2]),
	.segment_g(led[1])
);

// Outputs on external pins
sn74ls49 fpga74ls49_externalLEDs (
	.pin_a(pin_a),
	.pin_b(pin_b),
	.pin_c(pin_c),
	.pin_d(pin_d),
	.pin_bi_n(pin_bi_n),
	.segment_a(segment_a),
	.segment_b(segment_b),
	.segment_c(segment_c),
	.segment_d(segment_d),
	.segment_e(segment_e),
	.segment_f(segment_f),
	.segment_g(segment_g)
);

endmodule