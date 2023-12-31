/*
 * Minze Case
 * Copyright (c) 2022 Lone Dynamics Corporation. All rights reserved.
 *
 * required hardware:
 *  - 4 x M3 x 25mm countersunk bolts
 *  - 4 x M3 nuts
 *
 */

$fn = 100;

board_width = 42;
board_thickness = 1.5;
board_length = 68;
board_height = 1.6;
board_spacing = 2;

wall = 1.5;

top_height = 15;
bottom_height = 10;

translate([wall,wall,0]) mdm_board();

translate([0,0,15])
	mdm_case_top();

translate([0,0,-15])
	mdm_case_bottom();

module mdm_board() {
	
	difference() {
		color([0,0.5,0])
			roundedcube(board_width,board_length,board_thickness,5);
		translate([5, 5, -1]) cylinder(d=3.2, h=10);
		translate([5, 68-5, -1]) cylinder(d=3.2, h=10);
		translate([42-5, 5, -1]) cylinder(d=3.2, h=10);
		translate([42-5, 68-5, -1]) cylinder(d=3.2, h=10);
	}	
	
}

module mdm_case_top() {

	// supports
	translate([wall, wall, 0]) {
		translate([40.5,53.7-(9.5/2)-1,0]) cube([1,1,14.9]);
		translate([40.5,53.7-(9.5/2)-8.45,0]) cube([1,1,14.9]);
	}
	
	difference() {
				
		color([0.5,0.5,0.5])
			roundedcube(board_width+(wall*2),board_length+(wall*2),top_height,5);

		// cutouts
			
		translate([2,9.5,-2])
			roundedcube(board_width-1.25,board_length-16,14.5,5);

		translate([9.5,2,-2])
			roundedcube(board_width-16,board_length,10.25,5);			
	
		translate([wall, wall, 0]) {

			// vents
			translate([42/2-(15/2),50,0]) rotate([0,0,-10]) cube([15,1,20]);
			translate([42/2-(15/2),45,0]) rotate([0,0,-10]) cube([15,1,20]);
			translate([42/2-(15/2),40,0]) rotate([0,0,-10]) cube([15,1,20]);			
	
			// USBC
			translate([30,53.7-(9.5/2),0]) cube([30,9.5,3.5]);

			// VGA
			translate([30,25-(31/2),-1]) cube([30,31,12.5+1]);
			
			// USBA
			translate([21-(15/2),-5,0]) cube([15,10,7.2+1]);
	
			// SD
			translate([-10,19.5-(15/2),-2]) cube([15,15,2+2]);
			
			// PMODA
			translate([-10,47.15-(16/2),0]) cube([25,16,5.1]);
			
			// bolt holes
			translate([5, 5, -21]) cylinder(d=3.5, h=40);
			translate([5, 68-5, -21]) cylinder(d=3.5, h=40);
			translate([42-5, 5, -20]) cylinder(d=3.5, h=40);
			translate([42-5, 68-5, -21]) cylinder(d=3.5, h=40);

			// flush mount bolt holes
			translate([5, 5, top_height-1.5]) cylinder(d=5.25, h=4);
			translate([5, 68-5, top_height-1.5]) cylinder(d=5.25, h=4);
			translate([42-5, 5, top_height-1.5]) cylinder(d=5.25, h=4);
			translate([42-5, 68-5, top_height-1.5]) cylinder(d=5.25, h=4);

			// minze text
			rotate(270)
				translate([-22.5,19,top_height-0.5])
					linear_extrude(1)
						text("M I N Z E", size=4, halign="center",
							font="Ubuntu:style=Bold");

		}
		
	}	
}

module mdm_case_bottom() {
	
	difference() {
		color([0.5,0.5,0.5])
			roundedcube(board_width+(wall*2),board_length+(wall*2),bottom_height,5);
		
		// cutouts
		translate([3,10,1.5])
			roundedcube(board_width-3,board_length-17,10,5);
				
		translate([10.5,2.5,1.5])
			roundedcube(board_width-17.5,board_length-2,10,5);

		translate([wall, wall, 0]) {
			
		// board cutout
		translate([0,0,bottom_height-board_height])
			roundedcube(board_width+0.2,board_length+0.2,board_height+1,2.5);

		translate([wall, wall, 0]) {

			// USBC
			translate([30.5,43,5]) cube([10.20,15,10.5+1]);

		}

		// bolt holes
		translate([5, 5, -11]) cylinder(d=3.2, h=25);
		translate([5, 68-5, -11]) cylinder(d=3.2, h=25);
		translate([42-5, 5, -11]) cylinder(d=3.2, h=25);
		translate([42-5, 68-5, -11]) cylinder(d=3.2, h=25);

		// nut holes
		translate([5, 5, -1]) cylinder(d=7, h=4, $fn=6);
		translate([5, 68-5, -1]) cylinder(d=7, h=4, $fn=6);
		translate([42-5, 5, -1]) cylinder(d=7, h=4, $fn=6);
		translate([42-5, 68-5, -1]) cylinder(d=7, h=4, $fn=6);

		}
		
	}	
}

// https://gist.github.com/tinkerology/ae257c5340a33ee2f149ff3ae97d9826
module roundedcube(xx, yy, height, radius)
{
    translate([0,0,height/2])
    hull()
    {
        translate([radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,yy-radius,0])
        cylinder(height,radius,radius,true);

        translate([radius,yy-radius,0])
        cylinder(height,radius,radius,true);
    }
}
