# Quick Start Guide

This guide will help you get started with AOSL in 5 minutes.

## Step 1: Installation

Make sure you have:
1. OpenSCAD 2024.11 or later installed
2. BOSL2 library installed in your OpenSCAD library path

Download or clone AOSL:
```bash
git clone https://github.com/aQute-os/aosl.git
```

## Step 2: Your First AOSL Program

Create a file called `my_first_aosl.scad`:

```openscad
include <BOSL2/std.scad>
include <aosl.scad>

// Create a simple box
box = Cuboid([20, 20, 20]);
render(box);
```

Open this file in OpenSCAD and press F5 to preview, or F6 to render.

## Step 3: Adding a Hole

Modify your code to subtract a cylinder:

```openscad
include <BOSL2/std.scad>
include <aosl.scad>

// Create a box with a hole
box = Cuboid([20, 20, 20])
    .subtract(Cylinder(h=25, d=8));
render(box);
```

## Step 4: Adding Transformations

Move and rotate objects:

```openscad
include <BOSL2/std.scad>
include <aosl.scad>

// Create a box with an offset hole
box = Cuboid([30, 30, 10])
    .subtract(Cylinder(h=15, d=8).move([5, 5, 0]));
render(box);
```

## Step 5: Multiple Operations

Chain multiple operations together:

```openscad
include <BOSL2/std.scad>
include <aosl.scad>

// Create a more complex object
result = Cuboid([40, 40, 10], rounding=2)
    .subtract(Cylinder(h=15, d=20))  // Center hole
    .subtract(Cylinder(h=15, d=4).move([12, 12, 0]))  // Corner hole 1
    .subtract(Cylinder(h=15, d=4).move([-12, 12, 0]))  // Corner hole 2
    .subtract(Cylinder(h=15, d=4).move([12, -12, 0]))  // Corner hole 3
    .subtract(Cylinder(h=15, d=4).move([-12, -12, 0]))  // Corner hole 4
    .color("blue");

render(result);
```

## Step 6: Building Complex Objects

Combine multiple shapes:

```openscad
include <BOSL2/std.scad>
include <aosl.scad>

// Build a simple assembly
base = Cuboid([50, 50, 5]);
post = Cylinder(h=30, d=10).move([0, 0, 5]);
cap = Sphere(r=8).move([0, 0, 35]);

assembly = base.union(post).union(cap).color("green");
render(assembly);
```

## Common Patterns

### Pattern 1: Mounting Plate
```openscad
plate = Cuboid([60, 40, 5])
    .subtract(Cylinder(h=10, d=5).move([25, 15, 0]))
    .subtract(Cylinder(h=10, d=5).move([-25, 15, 0]))
    .subtract(Cylinder(h=10, d=5).move([25, -15, 0]))
    .subtract(Cylinder(h=10, d=5).move([-25, -15, 0]));
```

### Pattern 2: Bushing
```openscad
bushing = Cylinder(h=20, d=20)
    .subtract(Cylinder(h=25, d=12))
    .color("brass");
```

### Pattern 3: Bracket
```openscad
bracket = Cuboid([40, 10, 30])
    .subtract(Cylinder(h=15, d=8).rot([90, 0, 0]).move([0, 0, 15]))
    .subtract(Cylinder(h=15, d=6).move([15, 0, 8]))
    .subtract(Cylinder(h=15, d=6).move([-15, 0, 8]));
```

## Available Shapes

- `Cuboid(size, rounding, edges, center)` - Box/cube
- `Cylinder(h, r, d, r1, r2, d1, d2, center)` - Cylinder/cone
- `Sphere(r, d)` - Sphere

## Available Transformations

- `.move([x, y, z])` - Translate
- `.rot([x, y, z])` or `.rot(angle)` - Rotate
- `.scale([x, y, z])` or `.scale(factor)` - Scale
- `.mirror([x, y, z])` - Mirror
- `.color("name")` or `.color([r,g,b])` - Color

## Available Operations

- `.union(obj)` - Add another object
- `.subtract(obj)` - Remove another object
- `.intersect(obj)` - Intersection with another object

## Next Steps

1. Explore the `examples/` directory for more complex examples
2. Read the full `API.md` for detailed documentation
3. Check out `CONTRIBUTING.md` if you want to contribute
4. Run `./run_tests.sh` to see all tests pass

## Tips

1. **Always call `render()`**: Your object won't appear until you call `render(obj)`
2. **Chain operations**: Use the fluent interface for readable code
3. **Transform before boolean**: Apply transformations to objects before using them in boolean operations
4. **Use variables**: Break complex objects into named parts for clarity

## Getting Help

- Check the `examples/` directory for working code
- Read the `API.md` for detailed API reference
- Open an issue on GitHub for bugs or questions

Happy modeling with AOSL!
