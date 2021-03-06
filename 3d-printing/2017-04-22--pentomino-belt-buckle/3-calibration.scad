/*
PENTOMINO BLOCKS GENERATOR
==========================

(C) 2017 by Pascal Bauermeister.
License: Creative Commons Attribution-NonCommercial-ShareAlike 2.5.

(This is a part of the project "Pentomino Belt Buckle", focused on the
Pentomino pieces. It can however be used standalone. The other parts, not in this
file, include: frame, belt clip.)

This OpenSCAD script generates Pentomino blocks, with tabs and cavities to
allow them to hold together.
*/

// GENERAL
//H_SCALE_FACTOR = 1.58 / 1.63;  // ROBOX highway orange filament
//H_SCALE_FACTOR = 1.54 / 1.63;  // ROBOX polar white filament
H_SCALE_FACTOR = 1.57 / 1.63;  // ROBOX cornfield blue filament

include <common.scad>

///////////////////////////////////////////////////////////////////////////////
// Map defining the Pentomino shapes
_ = 0; // no block
GRID = [
    [_, _, _, _, _, _, _, _],
    [_, 1, 1, 1, _, 1, 1, _],
    [_, 1, _, 1, _, 1, _, _],
    [_, _, _, _, _, 1, _, _],
    [_, 1, 1, 1, _, 1, _, _],
    [_, _, 1, 1, _, _, _, _],
    [_, _, _, _, _, _, _, _],
];

make_all();

// End