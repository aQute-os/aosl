//////////////////////////////////////////////////////////////////////
// Example: Basic Shapes
// Demonstrates creating basic 3D shapes with AOSL
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../aosl.scad>

// Example 1: Simple cuboid
echo("Example 1: Simple Cuboid");
translate([0, 0, 0]) {
    cube1 = Cuboid([20, 20, 20]);
    render(cube1);
}

// Example 2: Rounded cuboid
echo("Example 2: Rounded Cuboid");
translate([30, 0, 0]) {
    cube2 = Cuboid([20, 20, 20], rounding=3);
    render(cube2);
}

// Example 3: Cylinder
echo("Example 3: Cylinder");
translate([60, 0, 0]) {
    cyl1 = Cylinder(h=25, d=15);
    render(cyl1);
}

// Example 4: Sphere
echo("Example 4: Sphere");
translate([90, 0, 0]) {
    sphere1 = Sphere(r=10);
    render(sphere1);
}

// Example 5: Cone (cylinder with different top/bottom diameters)
echo("Example 5: Cone");
translate([120, 0, 0]) {
    cone1 = Cylinder(h=25, d1=20, d2=5);
    render(cone1);
}
