/*
 * (C) 2017 by Pascal Bauermeister.
 * License: Creative Commons Attribution-NonCommercial-ShareAlike 2.5.
 */

$fn=90;

Z_SHRINK_FACTOR = 1;
//Z_SHRINK_FACTOR = 3;

TABS = [
    // top plate
    [1, 2, 3, 3, 2, 4, 4, 3, 1, 1],

    // middle plate
    [1, 2, 3, 3, 3, 3, 3, 2, 3, 3],

    // bottom plate
    [1, 2, 3, 4, 2, 4, 1, 2, 1, 2],
];

F = 0.5;
F = 1;

PLAY = 0.4;
TOLERANCE = 0.17;

SCREW_DIAMETER = 3;
SCREW_MAX_LENGTH = 10;
SCREW_DISTANCE_TO_BORDER = 4;
SCREW_PROTRUSION = 2;

ROTATION_STEP = 15; // degree
ENCODER_RADIUS = 20 - PLAY/2;
ENCODER_HEIGHT = 80 *F;
ENCODER_THICKNESS = 1.5 - PLAY/2;

ENCODER_ROTATION = -ROTATION_STEP * 10 * abs(sin($t*360));
//ENCODER_ROTATION = -ROTATION_STEP * 0;

TAB_VSIZE = 4 *F;
TAB_HSIZE = 3.5;
TAB_SPACING = 4.5 *F;

CROWN_RADIUS = 28;
CROWN_THICKNESS = 0.5;

BODY_RADIUS = 25.2;
BODY_THICKNESS = 1;
BODY_WINDOW_MARGIN = 2;
BODY_BASE = 2;
BODY_GUIDE = 2; // <== TODO: Snapping ring
BODY_HEIGHT = ENCODER_HEIGHT + BODY_BASE;

BOTTOM_RADIUS = CROWN_RADIUS;
BOTTOM_THICKNESS = 4;
BOTTOM_WHEELS_THICKNESS = 3;
BOTTOM_SERVO_WHEELS_MAX_RADIUS = 15;
BOTTOM_PLATE_THICKNESS = BOTTOM_THICKNESS - BOTTOM_WHEELS_THICKNESS;
BOTTOM_SERVO_SNAP_THICKNESS = 2;

SERVO1_HEIGHT = 26;
SERVO1_BODY_HEIGHT = 20;
SERVO1_BODY_WIDTH = 28.5;
SERVO1_BODY_THICKNESS = 8.4;
SERVO1_AXIS_SHIFT = 8 - SERVO1_BODY_WIDTH/2;
SERVO1_AXIS_RADIUS = 1.95;
SERVO1_CLEARANCE = 6.5;
SERVO1_BOTTOM_BODY_HEIGHT = 15;
SERVO1_BOTTOM_BODY_WIDTH = 19.8;
SERVO1_BOTTOM_CLEARANCE_HEIGHT = 21;
SERVO1_BOTTOM_HOLE_Z = 25;

SERVO2_HEIGHT = 30;
SERVO2_BODY_HEIGHT = 22.5;
SERVO2_BODY_WIDTH = 32.8 + TOLERANCE*2;
SERVO2_BODY_THICKNESS = 12.6 + TOLERANCE*2;
SERVO2_AXIS_SHIFT = SERVO2_BODY_WIDTH/2 -10;
SERVO2_AXIS_RADIUS = 2.5;
SERVO2_CLEARANCE = 12.5;
SERVO2_DISPLACEMENT = -7+1;
SERVO2_BOTTOM_BODY_HEIGHT = 15.5;
SERVO2_BOTTOM_BODY_WIDTH = 23.2;
SERVO2_BOTTOM_CLEARANCE_HEIGHT = 5;
SERVO2_BOTTOM_HOLE_Z = 15;

SERVO2_VERTICAL_OFFSET = -BOTTOM_WHEELS_THICKNESS;

ENCODER_DISPLACEMENT = BODY_RADIUS-ENCODER_RADIUS-BODY_THICKNESS -PLAY/2;

SERVO_HOLDER_HEIGHT = BODY_HEIGHT - SERVO1_CLEARANCE;
SERVO_HOLDER_THICKNESS = 2;
SERVO_HOLDER_CLEARANCE_X = 25;
SERVO_HOLDER_CLEARANCE_Y = 10;
SERVO_HOLDER_CAVITY_X = 4;
SERVO_HOLDER_CAVITY_Y = BODY_RADIUS - ENCODER_DISPLACEMENT -PLAY * 0;


SUPPORT_THICKNESS = 1.5;

TRANSMISSION_RADIUS_INNER = 1.5;
TRANSMISSION_RADIUS_OUTER = 4;
TRANSMISSION_RADIAL_SHIFT = 2;
TRANSMISSION_WHEEL_OVERLAP = 4;
TRANSMISSION_WHEEL_RADIUS = 3;
TRANSMISSION_AXIAL_HOLE_RADIUS = 0.5;

RIB_RADIUS = 2;
RIB_RADIAL_SHIFT = 1;

ATOM = 0.01;


