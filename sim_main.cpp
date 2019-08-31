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
    printf("cntr %i f_cntr: %i\n",top->top__DOT__scene,top->top__DOT__score);
    usleep(100000);
  }
  delete top;
  exit(0);
}
