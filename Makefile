PROJ_NAME=ICEshooter
TARGET=hx8k
PACKAGE=ct256
TOP_CELL=top
INCDIR=-Iverilog/game -Iverilog/display -Iverilog/utils
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'



.PHONY: all sim clean
gen:

	@echo -e "${GREEN} ---------------Synthesis--------------------------------${NC}\n"
	yosys -s verilog/top.ys
	@echo -e "${GREEN} ---------------Place and route--------------------------${NC}\n"
	nextpnr-ice40 --json ${PROJ_NAME}.json --pcf fpga/${PROJ_NAME}.pcf --asc ${PROJ_NAME}.txt --${TARGET} --package ${PACKAGE}
	@echo -e "${GREEN} ---------------Bitstream generation---------------------${NC}\n"
	icepack ${PROJ_NAME}.txt ${PROJ_NAME}.bin

show :
	@echo -e "${GREEN} ---------------Displaying top--------------------------------${NC}\n"
	yosys -s verilog/show.ys


pnr:
	yosys -p "synth_ice40 -top ${TOP_CELL} -json ${PROJ_NAME}.json" *.v
	nextpnr-ice40 --json ${PROJ_NAME}.json --pcf ${PROJ_NAME}.pcf --asc ${PROJ_NAME}.txt --${TARGET} --package ${PACKAGE} --gui

flash: ${PROJ_NAME}.bin
	@echo -e "${GREEN} ----------------Programming------------------------------${NC}\n"
	iceprog ${PROJ_NAME}.bin

sim:
	verilator -Wall -Wno-UNUSED -cc verilog/${TOP_CELL}.v ${INCDIR} -Mdir sim/obj_dir --exe ../sim_main.cpp -o ../sim_main
	make -C sim/obj_dir -f V${TOP_CELL}.mk	
	@echo -e "${BLUE}You can now run sim/sim_main${NC}\n"



clean-sim:
	rm -r sim/obj_dir sim/sim_main

clean:
	rm ${PROJ_NAME}.json ${PROJ_NAME}.txt ${PROJ_NAME}.bin
