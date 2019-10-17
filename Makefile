PROJ_NAME=ICEshooter
TARGET=hx8k
PACKAGE=ct256
TOP_CELL=top
VERILOG=$$(ls verilog/*.v)
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'




gen:

	@echo -e "${GREEN} ---------------Synthesis--------------------------------${NC}\n"
	yosys -p "synth_ice40 -top ${TOP_CELL} -json ${PROJ_NAME}.json" ${VERILOG}
	@echo -e "${GREEN} ---------------Place and route--------------------------${NC}\n"
	nextpnr-ice40 --json ${PROJ_NAME}.json --pcf fpga/${PROJ_NAME}.pcf --asc ${PROJ_NAME}.txt --${TARGET} --package ${PACKAGE}
	@echo -e "${GREEN} ---------------Bitstream generation---------------------${NC}\n"
	icepack ${PROJ_NAME}.txt ${PROJ_NAME}.bin

pnr:
	yosys -p "synth_ice40 -top ${TOP_CELL} -json ${PROJ_NAME}.json" *.v
	nextpnr-ice40 --json ${PROJ_NAME}.json --pcf ${PROJ_NAME}.pcf --asc ${PROJ_NAME}.txt --${TARGET} --package ${PACKAGE} --gui

flash: ${PROJ_NAME}.bin
	@echo -e "${GREEN} ----------------Programming------------------------------${NC}\n"
	iceprog ${PROJ_NAME}.bin

sim:
	verilator -Wall -Wno-UNUSED -cc ${TOP_CELL}.v --exe sim_main.cpp
	make -C obj_dir -f V${TOP_CELL}.mk
	obj_dir/V${TOP_CELL}


clean-sim:
	rm -r obj_dir/

clean:
	rm ${PROJ_NAME}.json ${PROJ_NAME}.txt ${PROJ_NAME}.bin
