module top(
	   input  clk,
	   input  rx, 
	   input  swR,
	   input  swL,
	   input  swF,
	  
	   output tx,
	   output pR,
	   output pG,
	   output pB,
	   output pHs,
	   output pVs,
	   
	   output LED1,
	   output LED2,
	   output LED3,
	   output LED4,
	   output LED5,
	   output LED6,
	   output LED7,
	   output LED8	   
	   );

   reg  	  R;
   reg [8:0]      bX=0;
   reg [8:0]   	  bY=0;
   reg [8:0]      X=45;
   reg [8:0]   	  Y=200;
   reg [25:0] 	  T_cntr;
   reg 		  swLp;
   reg 		  swRp;
   reg 		  swFp;
   wire 	  Vs;
   wire 	  Hs;
   wire 	  VGA_en;
   wire [8:0] 	  V_pos;
   wire [8:0] 	  H_pos;
   
   VGA VGA_out(
	       .clk(clk),
	       .V_sync(Vs),
	       .H_sync(Hs),
	       .V_pos(V_pos),
	       .H_pos(H_pos),
	       .VGA_enable(VGA_en)
	       );
   


  
   wire 	  T_cntr_maxed = (T_cntr==100000);
   

   wire 	  Ship=((V_pos==Y)&(H_pos==X+2))|((V_pos==Y+1)&(H_pos==X+2))|((V_pos==Y+2)&((H_pos==X+1)|(H_pos==X+2)|(H_pos==X+3)))|((V_pos==Y+3)&((H_pos==X)|(H_pos==X+1)|(H_pos==X+2)|(H_pos==X+3)|(H_pos==X+4)))|((V_pos==Y+4)&((H_pos==X)|(H_pos==X+1)|(H_pos==X+3)|(H_pos==X+4)));
   
   
   wire 	  Wdraw=((H_pos==bX)&(V_pos==bY));
   
   always@(posedge clk)
     begin
	swLp<=swL;
	swRp<=swR;
	if((swLp))
	  begin
	     if(~swL)X<=X-1;
	  end
	if((swRp))
	  begin
	     if(~swR)X<=X+1;
	  end
     end


   always@(posedge clk)
     begin
	swFp<=swF;
	if((swFp))
	  begin
	     if(~swF)
	       begin
		  bX<=X+2;
		  bY<=Y;
	       end
	     else if(T_cntr_maxed & ~(bY==476))
	       begin
		  if(bY==0)bY<=476;
		  else bY<=bY-1;
	       end
	  end
     end
   
   always@(posedge clk)
     begin
	if(T_cntr_maxed)T_cntr<=0;
	else T_cntr<=T_cntr+1;
     end
   
   
   assign pR=VGA_en&((H_pos==0)|(H_pos==298)|Wdraw);
   assign pG=VGA_en&((V_pos==0)|(V_pos==475)|Wdraw|Ship);
   assign pB=VGA_en&(Wdraw);
   assign pHs=Hs;
   assign pVs=Vs;
   
   assign tx=0;
   assign LED1=0;
   assign LED2=0;
   assign LED3=0;
   assign LED4=0;
   assign LED5=0;
   assign LED6=0;
   assign LED7=0;
   assign LED8=0;


endmodule // top


   
