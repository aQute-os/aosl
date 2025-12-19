//////////////////////////////////////////////////////////////////////
// Example: Real-World Objects
// Demonstrates creating practical objects with AOSL
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../aosl.scad>

// Example 1: Washer
echo("Example 1: Washer");
translate([0, 0, 0]) {
    washer = Cylinder(h=3, d=20)
        .subtract(Cylinder(h=5, d=8))
        .color("silver");
    render(washer);
}

// Example 2: Bushing
echo("Example 2: Bushing");
translate([30, 0, 0]) {
    bushing = Cylinder(h=25, d=15)
        .subtract(Cylinder(h=30, d=8))
        .color("brass");
    render(bushing);
}

// Example 3: T-joint connector
echo("Example 3: T-Joint Connector");
translate([60, 0, 0]) {
    tjoint = Cylinder(h=40, d=12)
        .union(Cylinder(h=12, d=30).rot([90, 0, 0]))
        .subtract(Cylinder(h=50, d=6))
        .subtract(Cylinder(h=35, d=6).rot([90, 0, 0]))
        .color("gray");
    render(tjoint);
}

// Example 4: Knob
echo("Example 4: Knob");
translate([100, 0, 0]) {
    knob = Cylinder(h=15, d1=25, d2=20)
        .union(Cylinder(h=10, d=8).move([0, 0, 15]))
        .union(Sphere(r=5).move([0, 0, 25]))
        .subtract(Cylinder(h=30, d=4).move([0, 0, -5]))
        .color("blue");
    render(knob);
}

// Example 5: Spacer with flange
echo("Example 5: Spacer with Flange");
translate([0, 50, 0]) {
    spacer = Cylinder(h=20, d=10)
        .union(Cylinder(h=3, d=20))
        .union(Cylinder(h=3, d=20).move([0, 0, 17]))
        .subtract(Cylinder(h=25, d=6))
        .color("white");
    render(spacer);
}

// Example 6: Simple box with lid features
echo("Example 6: Box with Snap Features");
translate([40, 50, 0]) {
    box_bottom = Cuboid([40, 30, 20])
        .subtract(Cuboid([36, 26, 18]).move([0, 0, 2]))
        // Add corner posts for lid
        .union(Cylinder(h=18, d=4).move([16, 11, 2]))
        .union(Cylinder(h=18, d=4).move([-16, 11, 2]))
        .union(Cylinder(h=18, d=4).move([16, -11, 2]))
        .union(Cylinder(h=18, d=4).move([-16, -11, 2]))
        .color("green");
    render(box_bottom);
}

// Example 7: Gear-like object (simplified)
echo("Example 7: Simplified Gear");
translate([90, 50, 0]) {
    // Create base cylinder
    gear_base = Cylinder(h=8, d=30);
    
    // Add center hole
    gear = gear_base
        .subtract(Cylinder(h=10, d=10))
        // Add a few teeth (simplified)
        .subtract(Cuboid([35, 3, 10]).move([0, 14, 0]))
        .subtract(Cuboid([35, 3, 10]).move([0, -14, 0]))
        .subtract(Cuboid([3, 35, 10]).move([14, 0, 0]))
        .subtract(Cuboid([3, 35, 10]).move([-14, 0, 0]))
        .color("darkgray");
    render(gear);
}
