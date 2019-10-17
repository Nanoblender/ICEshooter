module lives_display(
		     input 	 clk,
		     input [1:0] lives,
		     input [8:0] X,
		     input [8:0] Y,
		     input [8:0] H_pos,
		     input [8:0] V_pos,
		     output 	 lives_s
		     );

   wire 			 heart1,heart2,heart0;
   
   
   sprite_gen dig0(
		   .sprite_table(2),
		   .sprite_number(31*(lives>0)),
		   .X(X),
		   .Y(Y),
		   .H_pos(H_pos),
		   .V_pos(V_pos),
		   .state(heart0)
		   );
   
   sprite_gen dig1(
		   .sprite_table(2),
		   .sprite_number(31*(lives>1)),
		   .X(X+6),
		   .Y(Y),
		   .H_pos(H_pos),
		   .V_pos(V_pos),
		   .state(heart1)
		   );
   sprite_gen dig2(
		   .sprite_table(2),
		   .sprite_number(31*(lives>2)),
		   .X(X+12),
		   .Y(Y),
		   .H_pos(H_pos),
		   .V_pos(V_pos),
		   .state(heart2)
		   );


   assign lives_s=heart0|heart1|heart2;
   
   
endmodule // six_digit_display
