module road(
	    input 	 clk,
	    input 	 clk_en,
	    input [1:0]  scene,
	    input [7:0]  speed,
	    output [4:0] Y
	    );

   reg [4:0] 		 Y_reg=0;
   reg [7:0] 		 k=0;
   wire 		 cntr_maxed=(k==speed);   
   
   always@(posedge clk)
     begin
	if(clk_en)
	  begin
	     if(cntr_maxed)
	       begin
		  k<=0;
		  Y_reg<=Y_reg+1;
	       end
	     else k<=k+1;
	  end
     end // always@ (posedge clk)

   assign Y=Y_reg;
   
endmodule // road
