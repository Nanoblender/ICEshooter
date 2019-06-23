/*
This module generates sync signals to display a 299x238 VGA image using a 12MHz clock.
 V_pos and H_pos are the position of the current pixel.
 VGA_enable is the blanking signal that must be applied to the colours output signals.
*/

module VGA(
	   input 	clk,
	   output 	V_sync,
	   output 	H_sync,
	   output [8:0] V_pos,
	   output [8:0] H_pos,
	   output 	VGA_enable
	   );

   reg [1:0] 		div_cntr;
   reg [8:0] 		H_cntr;
   reg [9:0] 		V_cntr;
   reg 			Vs;
   reg 			Hs;
 
   wire 		H_cntr_maxed = (H_cntr==383);//The Hsync freq is 12MHZ/383=31.33kHz
   wire 		V_cntr_maxed = (V_cntr==522);//The Vsync is 31.33MHz/522=60Hz

   
   always@(posedge clk)
     begin	
	if (H_cntr_maxed) H_cntr<=0;
	else H_cntr<=H_cntr+1;
     end
   
   always@(posedge clk)
     if(H_cntr_maxed)
       begin
	  if(V_cntr_maxed)V_cntr<=0;
	  else V_cntr<=V_cntr+1;
       end

   assign H_sync = (H_cntr>77);//There is a 6.35µs blanking for H sync
   assign V_sync = (V_cntr>45);//There is a 1.43ns blanking for V sync
   assign VGA_enable = (((H_cntr>84)&(H_cntr<384))&((V_cntr>45)&(V_cntr<522)));
   assign H_pos = (H_cntr-85)*((H_cntr>84)&(H_cntr<384));
   assign V_pos = ((V_cntr-46)>>1)*((V_cntr>45)&(V_cntr<522));//The vertical resolution is divided by 2 to have square(ish) pixels

endmodule // VGA
