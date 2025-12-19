//////////////////////////////////////////////////////////////////////
// Example: Transformations
// Demonstrates transformation operations on objects
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../aosl.scad>

// Example 1: Move transformation
echo("Example 1: Move Transformation");
translate([0, 0, 0]) {
    obj1 = Cuboid([15, 15, 15]).move([0, 0, 10]);
    render(obj1);
}

// Example 2: Rotation transformation
echo("Example 2: Rotation Transformation");
translate([30, 0, 0]) {
    obj2 = Cuboid([20, 10, 5]).rot([0, 0, 45]);
    render(obj2);
}

// Example 3: Scale transformation
echo("Example 3: Scale Transformation");
translate([60, 0, 0]) {
    obj3 = Cuboid([10, 10, 10]).scale([1, 1, 2]);
    render(obj3);
}

// Example 4: Chained transformations
echo("Example 4: Chained Transformations");
translate([90, 0, 0]) {
    obj4 = Cylinder(h=20, d=10)
        .move([0, 0, 5])
        .rot([0, 45, 0]);
    render(obj4);
}

// Example 5: Color
echo("Example 5: Colored Object");
translate([120, 0, 0]) {
    obj5 = Sphere(r=8).color("red");
    render(obj5);
}

// Example 6: Complex transformation chain
echo("Example 6: Complex Transformation Chain");
translate([150, 0, 0]) {
    obj6 = Cuboid([10, 10, 10], rounding=2)
        .move([0, 0, 5])
        .rot([45, 0, 45])
        .scale([1.2, 1.2, 1])
        .color("blue");
    render(obj6);
}
