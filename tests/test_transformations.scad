//////////////////////////////////////////////////////////////////////
// Test: Transformations
// Tests that transformation methods work correctly
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../aosl.scad>

// Test 1: Move transformation
echo("Test 1: Testing move transformation");
obj1 = Cuboid([10, 10, 10]);
obj1_moved = move(obj1, [5, 5, 5]);
assert(len(obj1_moved.transforms) == 1, "Object should have 1 transform");
assert(obj1_moved.transforms[0][0] == "move", "Transform type should be 'move'");
echo("✓ Test 1 passed");

// Test 2: Rotation transformation
echo("Test 2: Testing rotation transformation");
obj2 = Cylinder(h=20, d=10);
obj2_rotated = rot(obj2, [0, 0, 45]);
assert(len(obj2_rotated.transforms) == 1, "Object should have 1 transform");
assert(obj2_rotated.transforms[0][0] == "rot", "Transform type should be 'rot'");
echo("✓ Test 2 passed");

// Test 3: Scale transformation
echo("Test 3: Testing scale transformation");
obj3 = Sphere(r=5);
obj3_scaled = scale(obj3, [2, 2, 2]);
assert(len(obj3_scaled.transforms) == 1, "Object should have 1 transform");
assert(obj3_scaled.transforms[0][0] == "scale", "Transform type should be 'scale'");
echo("✓ Test 3 passed");

// Test 4: Mirror transformation
echo("Test 4: Testing mirror transformation");
obj4 = Cuboid([10, 10, 10]);
obj4_mirrored = mirror(obj4, [1, 0, 0]);
assert(len(obj4_mirrored.transforms) == 1, "Object should have 1 transform");
assert(obj4_mirrored.transforms[0][0] == "mirror", "Transform type should be 'mirror'");
echo("✓ Test 4 passed");

// Test 5: Chained transformations
echo("Test 5: Testing chained transformations");
obj5 = Cuboid([10, 10, 10]);
obj5_chain = move(rot(scale(obj5, [1, 1, 2]), [0, 0, 45]), [10, 10, 0]);
assert(len(obj5_chain.transforms) == 3, "Object should have 3 transforms");
assert(obj5_chain.transforms[0][0] == "scale", "First transform should be 'scale'");
assert(obj5_chain.transforms[1][0] == "rot", "Second transform should be 'rot'");
assert(obj5_chain.transforms[2][0] == "move", "Third transform should be 'move'");
echo("✓ Test 5 passed");

// Test 6: Color setting
echo("Test 6: Testing color");
obj6 = Cuboid([10, 10, 10]);
obj6_colored = color(obj6, "red");
assert(obj6_colored.color_val == "red", "Color should be 'red'");
assert(len(obj6_colored.transforms) == 0, "Color should not add a transform");
echo("✓ Test 6 passed");

// Test 7: Fluent interface (method chaining syntax)
echo("Test 7: Testing fluent interface");
obj7 = Cuboid([10, 10, 10]);
obj7_fluent = obj7.move([5, 0, 0]).rot([0, 0, 45]).scale([1, 1, 2]);
assert(len(obj7_fluent.transforms) == 3, "Fluent chain should have 3 transforms");
echo("✓ Test 7 passed");

echo("=== All transformation tests passed ===");
