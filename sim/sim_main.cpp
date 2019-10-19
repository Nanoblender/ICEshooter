#include <stdlib.h>
#include "Vtop.h"
#include "verilated.h"



int main(int argc, char **argv){


  Verilated::commandArgs(argc, argv);
  Vtop *top= new Vtop;
  while(!Verilated::gotFinish()){
    top->clk=1;
    top->eval();
    top->clk=0;
    top->eval();
    printf("scene %i\n",top->top__DOT__mainFSM__DOT__scene_reg);
    usleep(100000);
  }
  delete top;
  exit(0);
}
