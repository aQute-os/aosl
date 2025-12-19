//////////////////////////////////////////////////////////////////////
// Test: Boolean Operations
// Tests that boolean operations work correctly
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../aosl.scad>

// Test 1: Subtraction
echo("Test 1: Testing subtraction");
obj1 = Cuboid([20, 20, 20]);
cyl1 = Cylinder(h=25, d=10);
obj1_sub = subtract(obj1, cyl1);
assert(len(obj1_sub.children) == 1, "Object should have 1 child");
assert(obj1_sub.children[0][1] == "subtract", "Operation should be 'subtract'");
echo("✓ Test 1 passed");

// Test 2: Union
echo("Test 2: Testing union");
obj2 = Cuboid([20, 20, 20]);
cyl2 = Cylinder(h=25, d=10);
obj2_union = union(obj2, cyl2);
assert(len(obj2_union.children) == 1, "Object should have 1 child");
assert(obj2_union.children[0][1] == "union", "Operation should be 'union'");
echo("✓ Test 2 passed");

// Test 3: Intersection
echo("Test 3: Testing intersection");
obj3 = Cuboid([20, 20, 20]);
sphere3 = Sphere(r=12);
obj3_intersect = intersect(obj3, sphere3);
assert(len(obj3_intersect.children) == 1, "Object should have 1 child");
assert(obj3_intersect.children[0][1] == "intersect", "Operation should be 'intersect'");
echo("✓ Test 3 passed");

// Test 4: Multiple subtractions
echo("Test 4: Testing multiple subtractions");
obj4 = Cuboid([30, 30, 10]);
cyl4a = Cylinder(h=15, d=6);
cyl4b = Cylinder(h=15, d=6);
obj4_multi = subtract(subtract(obj4, cyl4a), cyl4b);
assert(len(obj4_multi.children) == 2, "Object should have 2 children");
assert(obj4_multi.children[0][1] == "subtract", "First operation should be 'subtract'");
assert(obj4_multi.children[1][1] == "subtract", "Second operation should be 'subtract'");
echo("✓ Test 4 passed");

// Test 5: Mixed boolean operations
echo("Test 5: Testing mixed boolean operations");
obj5 = Cuboid([20, 20, 20]);
add_obj = Cylinder(h=10, d=8);
sub_obj = Sphere(r=5);
obj5_mixed = subtract(union(obj5, add_obj), sub_obj);
assert(len(obj5_mixed.children) == 2, "Object should have 2 children");
assert(obj5_mixed.children[0][1] == "union", "First operation should be 'union'");
assert(obj5_mixed.children[1][1] == "subtract", "Second operation should be 'subtract'");
echo("✓ Test 5 passed");

// Test 6: Fluent boolean interface
echo("Test 6: Testing fluent boolean interface");
obj6 = Cuboid([25, 25, 10]);
hole1 = Cylinder(h=15, d=8);
hole2 = Cylinder(h=15, d=6);
obj6_fluent = obj6.subtract(hole1).subtract(hole2);
assert(len(obj6_fluent.children) == 2, "Object should have 2 children");
echo("✓ Test 6 passed");

// Test 7: Boolean with transformations
echo("Test 7: Testing boolean with transformations");
obj7 = Cuboid([20, 20, 20]);
moved_hole = Cylinder(h=25, d=10).move([0, 0, 5]);
obj7_bool_trans = obj7.subtract(moved_hole);
assert(len(obj7_bool_trans.children) == 1, "Object should have 1 child");
assert(len(obj7_bool_trans.children[0][0].transforms) == 1, "Child should have 1 transform");
echo("✓ Test 7 passed");

echo("=== All boolean operation tests passed ===");
