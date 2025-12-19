//////////////////////////////////////////////////////////////////////
// Test: Basic Object Creation
// Tests that objects can be created with proper structure
//////////////////////////////////////////////////////////////////////

include <BOSL2/std.scad>
include <../aosl.scad>

// Test 1: Create a basic cuboid object
echo("Test 1: Creating Cuboid object");
cube1 = Cuboid([10, 10, 10]);
echo("Cuboid type:", cube1.type);
assert(cube1.type == "cuboid", "Cuboid type should be 'cuboid'");
echo("✓ Test 1 passed");

// Test 2: Create a cylinder object
echo("Test 2: Creating Cylinder object");
cyl1 = Cylinder(h=20, d=10);
echo("Cylinder type:", cyl1.type);
assert(cyl1.type == "cylinder", "Cylinder type should be 'cylinder'");
echo("✓ Test 2 passed");

// Test 3: Create a sphere object
echo("Test 3: Creating Sphere object");
sphere1 = Sphere(r=5);
echo("Sphere type:", sphere1.type);
assert(sphere1.type == "sphere", "Sphere type should be 'sphere'");
echo("✓ Test 3 passed");

// Test 4: Cuboid with rounding
echo("Test 4: Creating rounded Cuboid");
cube2 = Cuboid([10, 10, 10], rounding=2);
echo("Rounded cuboid type:", cube2.type);
assert(cube2.type == "cuboid", "Rounded cuboid type should be 'cuboid'");
echo("✓ Test 4 passed");

// Test 5: Verify object structure
echo("Test 5: Verifying object structure");
test_obj = Cuboid([5, 5, 5]);
assert(test_obj.type != undef, "Object should have a type");
assert(test_obj.params != undef, "Object should have params");
assert(test_obj.transforms != undef, "Object should have transforms");
assert(test_obj.children != undef, "Object should have children");
assert(len(test_obj.transforms) == 0, "New object should have no transforms");
assert(len(test_obj.children) == 0, "New object should have no children");
echo("✓ Test 5 passed");

echo("=== All basic object creation tests passed ===");
