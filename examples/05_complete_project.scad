//////////////////////////////////////////////////////////////////////
// Example: Complete Project - Mechanical Part
// Demonstrates a complete mechanical design workflow with AOSL
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../aosl.scad>

// Parameters
mounting_plate_size = [60, 60, 6];
mounting_hole_diameter = 5;
mounting_hole_spacing = 45;
center_hole_diameter = 25;
post_height = 30;
post_diameter = 12;
top_cap_diameter = 18;
top_cap_height = 8;

// Part 1: Mounting Plate
echo("Creating mounting plate...");
mounting_plate = Cuboid(mounting_plate_size, rounding=2)
    // Center hole for shaft
    .subtract(Cylinder(h=10, d=center_hole_diameter))
    // Mounting holes in corners
    .subtract(Cylinder(h=10, d=mounting_hole_diameter)
        .move([mounting_hole_spacing/2, mounting_hole_spacing/2, 0]))
    .subtract(Cylinder(h=10, d=mounting_hole_diameter)
        .move([-mounting_hole_spacing/2, mounting_hole_spacing/2, 0]))
    .subtract(Cylinder(h=10, d=mounting_hole_diameter)
        .move([mounting_hole_spacing/2, -mounting_hole_spacing/2, 0]))
    .subtract(Cylinder(h=10, d=mounting_hole_diameter)
        .move([-mounting_hole_spacing/2, -mounting_hole_spacing/2, 0]))
    .color("lightgray");

// Part 2: Vertical Post
echo("Creating vertical post...");
vertical_post = Cylinder(h=post_height, d=post_diameter)
    .move([0, 0, mounting_plate_size[2]/2])
    .color("darkgray");

// Part 3: Top Cap
echo("Creating top cap...");
top_cap = Cylinder(h=top_cap_height, d1=top_cap_diameter, d2=top_cap_diameter-4)
    .subtract(Cylinder(h=12, d=6))  // Through hole for adjustment
    .move([0, 0, mounting_plate_size[2]/2 + post_height])
    .color("silver");

// Part 4: Assembly
echo("Assembling parts...");
complete_assembly = mounting_plate
    .union(vertical_post)
    .union(top_cap);

// Render the complete assembly
render(complete_assembly);

// Optional: Render individual parts (comment out assembly above, uncomment below)
/*
// Exploded view
translate([0, 0, 0]) render(mounting_plate);
translate([0, 0, 15]) render(vertical_post);
translate([0, 0, 45]) render(top_cap);
*/

// Print information
echo("=== Assembly Information ===");
echo(str("Mounting Plate: ", mounting_plate_size[0], "x", mounting_plate_size[1], "x", mounting_plate_size[2], "mm"));
echo(str("Post Height: ", post_height, "mm"));
echo(str("Post Diameter: ", post_diameter, "mm"));
echo(str("Total Height: ", mounting_plate_size[2] + post_height + top_cap_height, "mm"));
echo(str("Mounting Holes: ", mounting_hole_diameter, "mm diameter"));
echo(str("Mounting Hole Spacing: ", mounting_hole_spacing, "mm"));
