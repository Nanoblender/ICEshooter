module game(
	    input 	  clk,
	    input 	  colision,
	    input 	  bullet_hit,
	    input 	  swF_re,
	    input 	  spawned,
	    input 	  avoided,
	    output [4:0]  level,
	    output [1:0]  lives,
	    output [19:0] score,
	    output [1:0]  scene
	    );

   reg [3:0] 		  state=0;
   reg [1:0] 		  lives_reg=3;
   reg [19:0] 		  score_reg=0;
   reg [1:0] 		  scene_reg=0;
   reg [4:0] 		  level_reg=1;
   
   
   parameter START=0,INIT=1,SPAWN=2,PLAYING=3,COLISION=4,ENNEMY_HIT=5,LEVEL_UP=6,SCORE_UP=7,LOST=8;

   //FSM operation

   always@(posedge clk)
     begin
	case(state)
	  START:
	    begin
	       scene_reg<=0;
	       if(swF_re)state<=INIT;
	    end // case: START
	  INIT:
	    begin
	       scene_reg<=0;
	       lives_reg<=3;
	       score_reg<=0;
	       level_reg<=1;
	       state<=SPAWN;
	    end
	  SPAWN:
	    begin
	       scene_reg<=0;
	       if(spawned)state<=PLAYING;
	    end
	  PLAYING:
	    begin
	       scene_reg<=1;
	       if(colision)state<=COLISION;
	       else if(bullet_hit)state<=ENNEMY_HIT;
	       else if(lives_reg==0)state<=LOST;
	       else if(avoided)state<=SCORE_UP;
	       //else if(score_reg>level)state<=LEVEL_UP;		   
	    end
	  COLISION:
	    begin
	       scene_reg<=1;
	       lives_reg<=lives_reg-1;
	       if(lives_reg==0)state<=LOST;
	       else state<=PLAYING;
	    end
	  ENNEMY_HIT:
	    begin
	       scene_reg<=1;
	       score_reg<=score_reg+2;
	       state<=PLAYING;
	    end
	  LEVEL_UP:
	    begin
	       scene_reg<=1;
	       level_reg<=level_reg+1;
	       state<=PLAYING;
	    end
	  SCORE_UP:
	    begin
	       scene_reg<=1;
	       score_reg<=score_reg+1;
	       state<=PLAYING; 
	    end
	  LOST:
	    begin
	       scene_reg<=2;
	       if(swF_re)state<=START;
	    end
	  default:
	    begin
	       state<=START;
	    end
	endcase

     end
   //FSM state change

   assign lives=lives_reg;
   assign score=score_reg;
   assign scene=scene_reg;
   assign level=level_reg;



endmodule // game
