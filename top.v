

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
   reg [8:0]      X=150;
   reg [8:0]   	  Y=200;
   reg [8:0]      Xe=150;
   reg [8:0]   	  Ye=85;
   reg [25:0] 	  T_cntr;
   reg 		  swLp;
   reg 		  swRp;
   reg 		  swFp;
   reg 		  sprite[0:1][0:7][0:7];
   reg 		  numbers[0:9][0:4][0:2];
   reg 		  chartable[0:39][0:4][0:4];
   reg [5:0] 	  k;
   

   
   wire 	  Vs;
   wire 	  Hs;
   wire 	  VGA_en;
   wire [8:0] 	  V_pos;
   wire [8:0] 	  H_pos;


   initial begin
      $readmemb("sprites", sprite);
      $readmemb("numbers", numbers);
      $readmemb("char5x5", chartable);
   end
   
   VGA VGA_out(
	       .clk(clk),
	       .V_sync(Vs),
	       .H_sync(Hs),
	       .V_pos(V_pos),
	       .H_pos(H_pos),
	       .VGA_enable(VGA_en)
	       );
   


  
   wire 	  T_cntr_maxed = (T_cntr==40000);


   
   wire 	  testchar_s=(H_pos-200>0)&(H_pos-200<6)&(V_pos-10>0)&(V_pos-10<6) & chartable[k][V_pos-11][H_pos-200-1];
   
   wire 	  number6_s=(H_pos-250>0)&(H_pos-250<4)&(V_pos-10>-0)&(V_pos-10<6) & numbers[1][V_pos-11][H_pos-250-1];
   wire 	  number5_s=(H_pos-250-4>0)&(H_pos-250-4<4)&(V_pos-10>-0)&(V_pos-10<6) & numbers[7][V_pos-11][H_pos-250-4-1];
   wire 	  number4_s=(H_pos-250-8>0)&(H_pos-250-8<4)&(V_pos-10>-0)&(V_pos-10<6) & numbers[7][V_pos-11][H_pos-250-8-1];
   wire 	  number3_s=(H_pos-250-12>0)&(H_pos-250-12<4)&(V_pos-10>-0)&(V_pos-10<6) & numbers[0][V_pos-11][H_pos-250-12-1];
   wire 	  number2_s=(H_pos-250-16>0)&(H_pos-250-16<4)&(V_pos-10>-0)&(V_pos-10<6) & numbers[1][V_pos-11][H_pos-250-16-1];
   wire 	  number1_s=(H_pos-250-20>0)&(H_pos-250-20<4)&(V_pos-10>-0)&(V_pos-10<6) & numbers[3][V_pos-11][H_pos-250-20-1];
   wire 	  score_s=number1_s|number2_s|number3_s|number4_s|number5_s|number6_s;
   


   
   wire 	  border=(H_pos==0)|(H_pos==298)|(V_pos==0)|(V_pos==237);
   wire 	  bullet_s=(((H_pos==bX)|(H_pos==bX+1))&((V_pos==bY)|(V_pos==bY+1)));
   wire 	  player_s=(H_pos-X>0)&(H_pos-X<9)&(V_pos-Y>-0)&(V_pos-Y<9)&sprite[0][V_pos-Y-1][H_pos-X-1];
   wire 	  ennemy1_s=(H_pos-Xe>0)&(H_pos-Xe<9)&(V_pos-Ye>-0)&(V_pos-Ye<9)&sprite[1][V_pos-Ye-1][H_pos-Xe-1];
   
   

   
   always@(posedge clk)
     begin
	swLp<=swL;
	swRp<=swR;
	if(T_cntr_maxed)
	  begin
	     if(~swL & ~(X==0))X<=X-1;
	     if(~swR & ~(X==290))X<=X+1;
	  end
	else X<=X;
     end


   always@(posedge clk)
     begin
	swFp<=swF;
	if(T_cntr_maxed & ~(bY==476))
	  begin
	     if(bY==0)bY<=476;
	     else bY<=bY-1;
	  end	
	else if((swFp))
	  begin
	     if(~swF)k<=k+1;
	     
	     if(~swF & (bY==476))
	       begin
		  bX<=X+3;
		  bY<=Y;
	       end
	  end
     end
   
   always@(posedge clk)
     begin
	if(T_cntr_maxed)T_cntr<=0;
	else T_cntr<=T_cntr+1;
     end
   
   
   assign pR=VGA_en&(border|bullet_s|player_s|score_s);
   assign pG=VGA_en&(border|bullet_s|player_s|testchar_s);
   assign pB=VGA_en&(border|ennemy1_s|bullet_s|player_s);
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


   
