// 4 x 5.85
// 3.95 x 6.5

TOLERANCE = 0.15;

CAVITY_LENGTH = 65   + TOLERANCE*2;
CAVITY_WIDTH  = 39.5 + TOLERANCE*2;
CAVITY_HEIGHT = 3.1  + TOLERANCE;

FRAME_THICKNESS_HORIZ = 2.4;
FRAME_THICKNESS_VERT = 1.6;

FRAME_LENGTH = CAVITY_LENGTH + FRAME_THICKNESS_HORIZ*2;
FRAME_WIDTH  = CAVITY_WIDTH  + FRAME_THICKNESS_HORIZ*2;
FRAME_HEIGHT = CAVITY_HEIGHT + FRAME_THICKNESS_VERT;

WINDOW_BORDER = 1.5;
MU = 0.001;

module Frame() {
    difference() {
        cube([FRAME_LENGTH, FRAME_WIDTH, FRAME_HEIGHT]);

        translate([FRAME_THICKNESS_HORIZ, FRAME_THICKNESS_HORIZ, -MU])
        cube([CAVITY_LENGTH, CAVITY_WIDTH, CAVITY_HEIGHT +MU]);

        translate([FRAME_THICKNESS_HORIZ+WINDOW_BORDER, FRAME_THICKNESS_HORIZ+WINDOW_BORDER, CAVITY_HEIGHT -MU])
        cube([CAVITY_LENGTH-WINDOW_BORDER*2, CAVITY_WIDTH-WINDOW_BORDER*2, FRAME_THICKNESS_VERT +MU*2]);
    }
}

translate([0, 0, FRAME_HEIGHT])
rotate([0, 180, 0])
Frame();