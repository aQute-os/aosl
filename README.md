# AOSL - aQute Object System Library for OpenSCAD

An OpenSCAD library that provides an object-oriented programming interface to the popular BOSL2 (Belfry OpenSCAD Library 2). AOSL leverages OpenSCAD's recently added object support to create a more intuitive and maintainable API for 3D modeling.

## Overview

AOSL wraps BOSL2 functionality with an object-oriented layer, making it easier to:
- Create and manipulate complex 3D objects with a fluent interface
- Chain operations in a readable manner
- Encapsulate state and behavior
- Build reusable components with clear interfaces

## Features

- **Object-Oriented Wrappers**: Clean OO interface to BOSL2 primitives and operations
- **Fluent API**: Chain operations for readable code
- **State Management**: Objects maintain their own state and transformations
- **BOSL2 Integration**: Full access to BOSL2's extensive functionality
- **Type Safety**: Use OpenSCAD's object system for better type checking

## Installation

1. Install [OpenSCAD](https://openscad.org/) (version with object support required)
2. Install [BOSL2](https://github.com/BelfrySCAD/BOSL2)
3. Clone this repository or download `aosl.scad`
4. Include AOSL in your OpenSCAD files:

```openscad
include <BOSL2/std.scad>
include <aosl.scad>
```

## Quick Start

### Traditional BOSL2 Approach:
```openscad
include <BOSL2/std.scad>

difference() {
    cuboid([20, 20, 20]);
    move([0, 0, 5]) cylinder(h=25, d=10);
}
```

### AOSL Object-Oriented Approach:
```openscad
include <BOSL2/std.scad>
include <aosl.scad>

obj = Cuboid([20, 20, 20])
    .subtract(Cylinder(h=25, d=10).move([0, 0, 5]));
obj.render();
```

## Core Classes

### Shape Objects

#### Cuboid
Creates a cuboid/box object.
```openscad
cube_obj = Cuboid([10, 20, 30]);
cube_obj = Cuboid([10, 10, 10], rounding=2);
```

#### Cylinder
Creates a cylinder object.
```openscad
cyl_obj = Cylinder(h=30, d=10);
cyl_obj = Cylinder(h=30, r=5, center=true);
```

#### Sphere
Creates a sphere object.
```openscad
sphere_obj = Sphere(r=10);
sphere_obj = Sphere(d=20);
```

### Transformation Methods

All shape objects support these transformation methods:

- `.move(v)` - Translate the object
- `.rot(a)` - Rotate the object
- `.scale(s)` - Scale the object
- `.mirror(v)` - Mirror the object
- `.color(c)` - Color the object

### Boolean Operations

- `.union(obj)` - Union with another object
- `.subtract(obj)` - Subtract another object
- `.intersect(obj)` - Intersect with another object

### Rendering

- `.render()` - Render the object to OpenSCAD geometry

## Examples

### Example 1: Basic Box with Hole
```openscad
include <BOSL2/std.scad>
include <aosl.scad>

box = Cuboid([30, 30, 10])
    .subtract(Cylinder(h=15, d=8))
    .color("blue");
box.render();
```

### Example 2: Compound Object
```openscad
include <BOSL2/std.scad>
include <aosl.scad>

base = Cuboid([50, 50, 5]);
post = Cylinder(h=30, d=8).move([0, 0, 5]);
top = Sphere(r=6).move([0, 0, 35]);

assembly = base.union(post).union(top).color("green");
assembly.render();
```

### Example 3: Array of Objects
```openscad
include <BOSL2/std.scad>
include <aosl.scad>

obj = Cuboid([10, 10, 10], rounding=2);
for (i = [0:4]) {
    obj.move([i * 15, 0, 0]).render();
}
```

## Documentation

### Object Structure

Each AOSL object contains:
- `type`: The object type ("cuboid", "cylinder", "sphere", etc.)
- `params`: Parameters for the shape
- `transforms`: List of transformations to apply
- `children`: Child objects for boolean operations
- `op`: Operation type ("union", "subtract", "intersect")

### Creating Custom Objects

You can extend AOSL by creating custom object constructors:

```openscad
function MyCustomShape(size) = 
    object(
        type = "custom",
        params = [["size", size]],
        transforms = [],
        children = [],
        op = "none"
    );
```

## Requirements

- OpenSCAD 2024.11 or later (with object support)
- BOSL2 library

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

Licensed under the Apache License, Version 2.0. See LICENSE file for details.

## Credits

- Built on top of [BOSL2](https://github.com/BelfrySCAD/BOSL2) by Revar Desmera
- Inspired by the OpenSCAD community's need for better abstraction layers

## See Also

- [BOSL2 Documentation](https://github.com/BelfrySCAD/BOSL2/wiki)
- [OpenSCAD Manual](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual)
- [OpenSCAD Objects Feature](https://openscad.org/)