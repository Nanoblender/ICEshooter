/*
This module generates a bullet
 */
module bullet(
	      input 	   clk,
	      input 	   clk_en,
	      input 	   hit,
	      input 	   swF_re,
	      input [1:0]  scene,
	      input [8:0]  player_X,
	      output [8:0] X,
	      output [8:0] Y
	      );

   reg [8:0] 		   X_reg=0;
   reg [8:0] 		   Y_reg=300;

   always@(posedge clk)
     begin
	if(Y_reg==0)Y_reg<=300;
	else if(swF_re & (Y_reg==300))
	  begin
	     X_reg<=player_X+7;
	     Y_reg<=215;
	  end
	else if(Y_reg<300 & clk_en)
	  begin
	     Y_reg<=Y_reg-1;
	  end
     end // always@ (posedge clk)
   
   assign X=X_reg;
   assign Y=Y_reg;
   
endmodule // bullet
