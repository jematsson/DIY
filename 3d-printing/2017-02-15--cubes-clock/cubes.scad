// ============================================================================
// NOTES:
// Library file. To be imported via the use <> statement.
// You can render it for test, but do not export to STL.
//
// ============================================================================

include <definitions.scad>
include <lib/wheel-lib.scad>

BLOCKS_R1 = PLATE2_BOX_INNER_HOLE_DIAMETER/2;
BLOCKS_R2 = BLOCKS_R1 + WALL_THICKNESS;
BLOCKS_R3 = BLOCKS_R2 + PLAY;
BLOCKS_R4 = (BLOCKS_R3+BLOCKS_WIDTH/2)/2;

CUBE_SNAP_BALLS_POS_R = BLOCKS_R4 + CUBE_SNAP_BALLS_RADIUS*CUBE_SNAP_BALLS_K + PLAY;

function get_cube_snap_ball_pos_radius() = CUBE_SNAP_BALLS_POS_R;

show_texts = false;

echo("Cylinder =", block_cylinder);
echo("Block 1 =", BLOCK1_HEIGHT);
echo("Block 2 =", BLOCK2_HEIGHT);
echo("Block 3 =", BLOCK3_HEIGHT);
echo("Total =", BLOCK1_HEIGHT+BLOCK2_HEIGHT+BLOCK3_HEIGHT);

echo(BLOCK1_HEIGHT+BLOCK2_HEIGHT+BLOCK3_HEIGHT);

module make_block_segments(height, segments) {

    offset = DIGIT_SEGMENT_WIDTH/2 + 0.5;
    bottom = height - offset;
    mid = height / 2;
    top = offset;
    left = -BLOCKS_WIDTH/2 + offset;
    right = BLOCKS_WIDTH/2 - offset;

    mleft = -BLOCKS_WIDTH/2 + offset + DIGIT_SEGMENT_WIDTH*2;
    mright = BLOCKS_WIDTH/2 - offset - DIGIT_SEGMENT_WIDTH*2;

    y = BLOCKS_WIDTH/2;
    
    r = 1;
    for (i=[0:3]) rotate([0, 0, 90*i]) {
        seg = segments[i];

        if (show_texts)
            %translate([0, y, mid])
            text(str(seg));
         
        if (seg=="a" || seg=="c" || seg=="d" ||
            seg=="e" || seg=="g") // top-left
            translate([left, y, top])
            sphere(r, true);
        if (seg=="a" || seg=="b" || seg=="c" || seg=="d" ||
            seg=="e" || seg=="f" || seg=="h") // top-right
            translate([right, y, top])
            sphere(r, true);
        if (seg=="a" || seg=="b" || seg=="c" ||
            seg=="e" || seg=="f" || seg=="g" || seg=="h") // bottom-right
            translate([right, y, bottom])
            sphere(r, true);
        if (seg=="a" || seg=="b" || seg=="d" ||
            seg=="e" || seg=="g" || seg=="h") // bottom-left
            translate([left, y, bottom])
            sphere(r, true);

        if (seg=="j") // mid-left
            translate([left, y, mid])
            sphere(r, true);
        if (seg=="i" || seg=="j") // mid-right
            translate([right, y, mid])
            sphere(r, true);

        if (seg=="k") // mid-left
            translate([mleft, y, mid])
            sphere(r, true);
        if (seg=="k") // mid-left
            translate([mright, y, mid])
            sphere(r, true);
        
    }
}

module make_block_body(height, segments) {
    difference() {
        // outer shape
        translate([-BLOCKS_WIDTH/2, -BLOCKS_WIDTH/2, 0])
        cube([BLOCKS_WIDTH, BLOCKS_WIDTH, height]);
        
        // segment gluing marks
        make_block_segments(height, segments);
    }
}

module make_block_features(height, is_closed, has_full_crown, has_guide, has_marks, segments) {
    difference() {
        union() {
            difference() {
                // outer shape
                make_block_body(height, segments);
                
                // central chamber
                translate([0, 0, -ATOM])
                scale([1, 1, height+ATOM*2])
                cylinder(r=BLOCKS_R1, true);

                if(has_guide) {
                    // remove cone to create bottom chamfer
                    translate([0, 0, BLOCKS_R3/2 + CUBE_CROWN_HEIGHT -ATOM])
                    cylinder(h=BLOCKS_R3+ATOM*2, r1=BLOCKS_R3, r2=0, center=true); 

                    // remove cylinder to create radial play, below chamfer
                    translate([0, 0, (CUBE_CROWN_HEIGHT)/2-ATOM])
                    cylinder(h=CUBE_CROWN_HEIGHT+ATOM*2, r=BLOCKS_R3, center=true);
                }
            }

            // crown
            translate([0, 0, height])
            barrel(BLOCKS_R2, BLOCKS_R1, has_full_crown ? CUBE_CROWN_HEIGHT : CUBE_CROWN_SHORT_HEIGHT);

            // ring to reduce friction
            translate([0, 0, height])
            barrel(BLOCKS_R4+CUBE_SNAP_BALLS_RADIUS*CUBE_SNAP_BALLS_K, BLOCKS_R2, BLOCKS_JOIN);
            
            // snap balls
            for (i=[0:3])
                rotate([0, 0, 30 + 90*i])
                translate([0, get_cube_snap_ball_pos_radius(), height+PLAY/2])
                scale([CUBE_SNAP_BALLS_K, CUBE_SNAP_BALLS_K, 1]) {
                    sphere(CUBE_SNAP_BALLS_RADIUS, true);

                    translate([0, 0, -BLOCKS_JOIN])
                    cylinder(h=BLOCKS_JOIN, r=CUBE_SNAP_BALLS_RADIUS);
                }
            
            if (is_closed) {
                // top closing plate
                translate([-BLOCKS_WIDTH/2, -BLOCKS_WIDTH/2, 0])
                cube([BLOCKS_WIDTH, BLOCKS_WIDTH, WALL_THICKNESS]);
            }
        }

        // lever cavity
        lever_cavity_thickness = CUBE_LEVER_THICKNESS+PLAY;
        lever_r1 = BLOCKS_WIDTH/2*sqrt(2);
        lever_r2 = BLOCKS_R1;
        lever_length = (lever_r1*3 + lever_r2)/4;
        r = 2;
        rotate([0, 0, 45])
        if (0)
            // rounded
            translate([0, -lever_cavity_thickness/2 +r, r + WALL_THICKNESS])
            minkowski() {
                cube([lever_length-r*2, lever_cavity_thickness-r*2, height-CUBE_CROWN_HEIGHT]);
                sphere(r=r);
        }
        else
            // not rounded
            translate([0, -lever_cavity_thickness/2, WALL_THICKNESS])
            cube([lever_length, lever_cavity_thickness, height-CUBE_CROWN_HEIGHT]);
                
        
        // snap mark
        if (has_marks) {
            make_block_snap_marks();
        }
    }
}

module make_block_snap_marks() {
    r = CUBE_SNAP_BALLS_RADIUS + PLAY/2; // <== ADJUST
    r = CUBE_SNAP_BALLS_RADIUS + PLAY/2.5; // <== ADJUST
    r = CUBE_SNAP_BALLS_RADIUS + PLAY/2.3; // <== ADJUST
    for (i=[0:3])
        rotate([0, 0, 30 + 90*i])
        translate([0, CUBE_SNAP_BALLS_POS_R, 0])
        scale([CUBE_SNAP_BALLS_K, CUBE_SNAP_BALLS_K, CUBE_SNAP_BALLS_K])
        sphere(r, true);
}

module make_block(height, is_closed, has_crown, has_guide, has_marks, segments, draft) {
    if (draft)
        make_block_body(height, segments);
    else
        make_block_features(height, is_closed, has_crown, has_guide, has_marks, segments, draft);
}

module bottom_block(draft=false) {
    segs_low = ["e", "f", "g", "h"];
    make_block(BLOCK1_HEIGHT, false, false, true, true, segs_low, draft);
}

module mid_block(draft=false) {
    segs_mid = ["i", "j", "k", 0];
    make_block(BLOCK2_HEIGHT , false, true, true, true, segs_mid, draft);
}

module top_block(draft=false) {
    segs_top = ["a", "b", "c", "d"];
    make_block(BLOCK3_HEIGHT, true, true, false, false, segs_top, draft);
}

if (0) {
    // test block
    intersection() {
        make_block(5 , false, true, true, true, [0, 0, 0, 0]);
        if (0)
            cube([BLOCKS_WIDTH, BLOCKS_WIDTH, BLOCKS_WIDTH]);
    }
}
else if (0) {
    space = 7;
    shift = BLOCKS_WIDTH/2 + space;
    
    translate([-shift, -shift, 0])
    bottom_block();

    // mid block
    translate([shift, -shift, 0])
    mid_block();
    
    // top block
    translate([shift, shift, 0])
    top_block();
}
else {
    flip(BLOCK1_HEIGHT + CUBE_CROWN_HEIGHT)
    bottom_block(draft=true);
    
    z1 = BLOCK1_HEIGHT + CUBE_CROWN_HEIGHT + TOLERANCE;
    translate([0, 0, z1])

    flip(BLOCK2_HEIGHT_STACKABLE)
    mid_block(draft=true);

    z2 = z1 + BLOCK2_HEIGHT_STACKABLE + TOLERANCE;
    translate([0, 0, z2])
    flip(BLOCK3_HEIGHT_STACKABLE)
    top_block(draft=true);
}