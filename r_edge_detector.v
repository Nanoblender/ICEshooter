module r_edge_detector(
		     input clk,
		     input sig,
		     output detected
		     );

   reg 			    sig_p;
   always@(posedge clk)sig_p<=sig;
   assign detected=sig&~sig_p;
   
   
	       endmodule // r_edge_detector

   
