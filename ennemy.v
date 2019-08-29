module ennemy(
	      input 	   clk,
	      input 	   clk_en,
	      input 	   colision,
	      input [1:0]  scene,
	      output [8:0] X,
	      output [8:0] Y,
	      output avoided
	      );

   reg [8:0] 		   X_reg=130;
   reg [8:0] 		   Y_reg=190;
   reg [6:0] 		   k=0;

   always@(posedge clk)
     begin
	
	if(Y_reg==238)
	  begin
	     Y_reg<=0;
	     X_reg<=72+k;
	     k<=k+435;
	  end
	else if(clk_en)//clk/700000
	  begin
	     Y_reg<=Y_reg+1; 
	  end // if (clk_en)
	else if(colision) X_reg<=400;
	
     end // always@ (posedge clk)
   
   assign X=X_reg;
   assign Y=Y_reg;
   assign avoided=Y_reg==238;
   
endmodule // player
