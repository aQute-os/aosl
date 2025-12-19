//////////////////////////////////////////////////////////////////////
// Example: Boolean Operations
// Demonstrates union, subtraction, and intersection
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../aosl.scad>

// Example 1: Simple subtraction - Box with hole
echo("Example 1: Box with Hole");
translate([0, 0, 0]) {
    box_with_hole = Cuboid([25, 25, 10])
        .subtract(Cylinder(h=15, d=8));
    render(box_with_hole);
}

// Example 2: Union - Base with post
echo("Example 2: Union - Base with Post");
translate([40, 0, 0]) {
    base = Cuboid([30, 30, 5]);
    post = Cylinder(h=20, d=8).move([0, 0, 5]);
    combined = base.union(post);
    render(combined);
}

// Example 3: Intersection
echo("Example 3: Intersection");
translate([80, 0, 0]) {
    intersected = Cuboid([20, 20, 20])
        .intersect(Sphere(r=12));
    render(intersected);
}

// Example 4: Multiple subtractions
echo("Example 4: Multiple Subtractions");
translate([120, 0, 0]) {
    multi_hole = Cuboid([30, 30, 10])
        .subtract(Cylinder(h=15, d=6).move([-8, 0, 0]))
        .subtract(Cylinder(h=15, d=6).move([8, 0, 0]))
        .subtract(Cylinder(h=15, d=6).move([0, -8, 0]))
        .subtract(Cylinder(h=15, d=6).move([0, 8, 0]));
    render(multi_hole);
}

// Example 5: Complex boolean - Building
echo("Example 5: Complex Boolean - Simple Building");
translate([0, 50, 0]) {
    // Base
    building = Cuboid([40, 30, 20])
        // Door
        .subtract(Cuboid([8, 2, 12]).move([0, -14, -4]))
        // Windows
        .subtract(Cuboid([6, 2, 6]).move([-10, -14, 2]))
        .subtract(Cuboid([6, 2, 6]).move([10, -14, 2]))
        // Roof (union with rotated box)
        .union(Cuboid([42, 32, 2]).move([0, 0, 10]).rot([45, 0, 0]))
        .color("lightblue");
    render(building);
}

// Example 6: Bracket - Practical example
echo("Example 6: Bracket");
translate([60, 50, 0]) {
    bracket = Cuboid([30, 30, 5])
        // Main hole
        .subtract(Cylinder(h=10, d=20))
        // Mounting holes
        .subtract(Cylinder(h=10, d=4).move([10, 10, 0]))
        .subtract(Cylinder(h=10, d=4).move([-10, 10, 0]))
        .subtract(Cylinder(h=10, d=4).move([10, -10, 0]))
        .subtract(Cylinder(h=10, d=4).move([-10, -10, 0]))
        .color("orange");
    render(bracket);
}
