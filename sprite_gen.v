module sprite_gen(
		  input [0:2] sprite_table,
		  input [0:8] sprite_number,
		  input [8:0] X,
		  input [8:0] Y,
		  input [8:0] H_pos,
		  input [8:0] V_pos,
		  output      state
		  );

   reg 			      sprite[0:3][0:15][0:15];
   reg 			      numbers[0:9][0:4][0:2];
   reg 			      chartable[0:39][0:4][0:4];
   wire 		      show_this_sprite[0:2];
   
   
   initial begin
      $readmemb("sprites16", sprite);
      $readmemb("numbers", numbers);
      $readmemb("char5x5", chartable);
   end
   
   assign show_this_sprite[0] = (H_pos-X<16) & (V_pos-Y<16) & sprite[sprite_number][V_pos-Y][H_pos-X];
   assign show_this_sprite[1] = (H_pos-X<3) & (V_pos-Y<5) & numbers[sprite_number][V_pos-Y][H_pos-X];
   assign show_this_sprite[2] = (H_pos-X<5) & (V_pos-Y<5) & chartable[sprite_number][V_pos-Y][H_pos-X];
   assign state=show_this_sprite[sprite_table];
   
   
   endmodule // sprite_gen

		  
