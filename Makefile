blinky_minze:
	mkdir -p output
	yosys -q -p "synth_ecp5 -top blinky -json output/blinky_minze.json" rtl/blinky_minze.v
	nextpnr-ecp5 --12k --package CABGA256 --lpf minze_v1.lpf --json output/blinky_minze.json --textcfg output/minze_blinky_out.config
	ecppack -v --compress --freq 2.4 output/minze_blinky_out.config --bit output/minze.bit

prog:
	openFPGALoader -c dirtyJtag output/minze.bit
