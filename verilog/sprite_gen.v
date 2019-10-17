module sprite_gen(
		  input [1:0] sprite_table,
		  input [8:0] sprite_number,
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
   wire [8:0] 		      X_diff=H_pos-X;
   wire [8:0] 		      Y_diff=V_pos-Y;
   
   initial begin
      $readmemb("ROM/sprites16", sprite);
      $readmemb("ROM/numbers", numbers);
      $readmemb("ROM/char5x5", chartable);
   end
   
   assign show_this_sprite[0] = (X_diff<16) & (Y_diff<16) & sprite[sprite_number[1:0]][Y_diff[3:0]][X_diff[3:0]];
   assign show_this_sprite[1] = (X_diff<3) & (Y_diff<5) & numbers[sprite_number[3:0]][Y_diff[2:0]][X_diff[1:0]];
   assign show_this_sprite[2] = (X_diff<5) & (Y_diff<5) & chartable[sprite_number[5:0]][Y_diff[2:0]][X_diff[2:0]];
   assign state=show_this_sprite[sprite_table];
   
   
   endmodule // sprite_gen

		  
