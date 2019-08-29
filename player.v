module player(
	      input 	   clk,
	      input 	   clk_en,
	      input 	   swL,
	      input 	   swR, 
	      input [1:0]  scene,
	      output [8:0] pos
	      );

   reg 			   switchs_p[0:2];//Left,Right,fire
   reg [8:0] 		   pos_reg=150;
      
   always@(posedge clk)
     begin
	if(clk_en)//clk/700000
	  begin
	     switchs_p[0]<=swL;
	     switchs_p[1]<=swR;
	     if(~(~swL & ~swR))
	       begin
		  if(!swL)
		    begin
		       if(pos_reg-1<64)pos_reg<=64;
		       else pos_reg<=pos_reg-1;
		    end
		  if(!swR)
		    begin
		       if(pos_reg+1>208)pos_reg<=208;
		       else pos_reg<=pos_reg+1;
		    end
	       end // if (~(swL & ~swR))
	  end // if (clk_en)
     end // always@ (posedge clk)
   
   assign pos=pos_reg;

endmodule // player

   
