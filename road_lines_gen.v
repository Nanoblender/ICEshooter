module road_line_gen(
		  input [8:0] sprite_number,
		  input [8:0] Y,
		  input [8:0] H_pos,
		  input [8:0] V_pos,
		  output      state
		  );

   reg 			      sprite[0:3][0:15][0:15];
  
   
   initial begin
      $readmemb("sprites16", sprite);
   end
   
   assign state = (H_pos>63) & (H_pos<224) &(H_pos>>4) & sprite[sprite_number][(V_pos-Y)&4'b1111][H_pos&4'b1111];

   
   
   endmodule // sprite_gen

		  
