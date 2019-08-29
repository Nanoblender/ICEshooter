

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

   
   reg [25:0] 	  T_cntr;
   reg 		  chartable[0:39][0:4][0:4];
   reg [4:0] 	  road_Y;
   reg [7:0] 	  speed_cntr;
   reg [7:0] 	  speed=3;
   reg 		  Vs_p;
   reg 		  clk_en_60Hz;
   reg 		  T_cntr_maxed_re;
   reg [8:0] 	  player_X;
   reg [8:0] 	  player_Y=215;
   reg 		  player_s;
   reg 		  e1_s;
   wire [8:0] 	  e1_X;
   wire [8:0] 	  e1_Y;
   reg [6:0] 	  k;
   reg [8:0] 	  score_X=260;
   reg [8:0] 	  score_Y=10;
   reg 		  bullet_s=0;
   
   
   wire 	  Vs;
   wire 	  Hs;
   wire 	  VGA_en;
   wire [8:0] 	  V_pos;
   wire [8:0] 	  H_pos;
   wire 	  road1_s;
   wire 	  road2_s;  
   wire 	  roadl_s;  
   wire 	  six_dig;
   wire 	  swF_re;
   wire [1:0] 	  lives;
   wire [19:0] 	  score;
   wire [1:0] 	  scene;
   wire [4:0] 	  level;
   wire 	  avoided;
   

   VGA VGA_out(
 	       .clk(clk),
 	       .V_sync(Vs),
  	       .H_sync(Hs),
 	       .V_pos(V_pos),
	       .H_pos(H_pos),
	       .VGA_enable(VGA_en)
	       );
   
   r_edge_detector re_clk_60Hz(
			       .clk(clk),
			       .sig(Vs),
			       .detected(clk_en_60Hz)
			       );
   r_edge_detector re_T_cntr(
			     .clk(clk),
			     .sig(T_cntr_maxed),
			     .detected(T_cntr_maxed_re)
			     );
   
   r_edge_detector re_swF_cntr(
			     .clk(clk),
			     .sig(!swF),
			     .detected(swF_re)
			     );


   six_digit_display score_display(
				   .clk(clk),
				   .sauce(score),
				   .X(score_X),
				   .Y(score_Y),
				   .H_pos(H_pos),
				   .V_pos(V_pos),
				   .six_digit_number(six_dig)
				   );

   
   sprite_gen player_spr(
			 .sprite_table(0),
			 .sprite_number(1),
			 .X(player_X),
			 .Y(player_Y),
			 .H_pos(H_pos),
			 .V_pos(V_pos),
			 .state(player_s)
			 );


   sprite_gen ennemy1_spr(
			  .sprite_table(0),
			  .sprite_number(0),
			  .X(e1_X),
			  .Y(e1_Y),
			  .H_pos(H_pos),
			  .V_pos(V_pos),
			  .state(e1_s)
			  );


   road_gen rd1_spr(
		    .sprite_number(2),
		    .X(48),
		    .Y(road_Y),
		    .H_pos(H_pos),
		    .V_pos(V_pos),
		    .mirror(0),
		    .state(road1_s)
		    );

   
   road_gen rd2_spr(
		    .sprite_number(2),
		    .X(224),
		    .Y(road_Y),
		    .H_pos(H_pos),
		    .V_pos(V_pos),
		    .mirror(1),
		    .state(road2_s)
		    );
   

   road_line_gen rdl_spr(
		    .sprite_number(3),
		    .Y(road_Y),
		    .H_pos(H_pos),
		    .V_pos(V_pos),
		    .state(roadl_s)
		    );
   
  player plyr(
	      .clk(clk),
	      .clk_en(T_cntr_maxed_re),
	      .swL(swL),
	      .swR(swR),
	      .scene(scene),
	      .pos(player_X)
	      );

   ennemy enm1(
	       .clk(clk),
	       .clk_en(T_cntr_maxed_re),
	       .colision(player_s & e1_s),
	       .scene(scene),
	       .X(e1_X),
	       .Y(e1_Y),
	       .avoided(avoided)
	       );
   
   
   game mainFSM(
		.clk(clk),
		.colision(player_s & e1_s),
		.bullet_hit(bullet_s & e1_s),
		.swF_re(swF_re),
		.spawned(1),
		.avoided(avoided),
		.level(level),
		.lives(lives),
		.score(score),
		.scene(scene)
		);
   





		
   wire 	  T_cntr_maxed = (T_cntr==70000);
   wire 	  speed_cntr_maxed=(speed_cntr==speed);   
   
   wire 	  border=(H_pos==0)|(H_pos==298)|(V_pos==0)|(V_pos==237);

	   
   reg [19:0] 	  hit_cntr=0;
   
   
   always@(posedge clk)
     begin
	if(T_cntr_maxed_re)
	  begin
	     if(speed_cntr_maxed)
	       begin
		  speed_cntr<=0;
		  road_Y<=road_Y+1;
	       end
	     else speed_cntr<=speed_cntr+1;
	  end
     end

   
   
   always@(posedge clk)
     begin
	if(avoided)hit_cntr<=hit_cntr+1;
	
	if(T_cntr_maxed)T_cntr<=0;
	else T_cntr<=T_cntr+1;
     end

   assign pR=VGA_en&(border|player_s|road1_s|road2_s|six_dig);
   assign pG=VGA_en&(border|player_s|(roadl_s&~e1_s&(scene==1))|six_dig);
   assign pB=VGA_en&(border|player_s|e1_s|six_dig);
   assign pHs=Hs;
   assign pVs=Vs;
   
   assign tx=0;
   assign LED1=(player_s&e1_s);
   assign LED2=swL;
   assign LED3=0;
   assign LED4=swR;
   assign LED5=0;
   assign LED6=swF;
   assign LED7=0;
   assign LED8=0;


endmodule // top


   
