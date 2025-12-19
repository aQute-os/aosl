# API Reference

## Core Object System

### Object Structure

All AOSL objects follow this internal structure:

```openscad
object(
    type = "shape_type",        // Type identifier (cuboid, cylinder, sphere, etc.)
    params = [...],             // Shape parameters
    transforms = [...],         // List of transformations
    children = [...],           // Child objects for boolean operations
    op = "operation",           // Operation type
    color_val = "color"         // Optional color
)
```

## Shape Constructors

### Cuboid(size, [rounding], [edges], [center])

Creates a cuboid (box) object.

**Parameters:**
- `size`: Size as `[x, y, z]` vector or single number for cube
- `rounding`: (optional) Radius for edge rounding (default: 0)
- `edges`: (optional) Which edges to round, uses BOSL2 edge specification (default: EDGES_ALL)
- `center`: (optional) Center the shape (default: true)

**Returns:** AOSL object

**Examples:**
```openscad
// Simple cube
cube = Cuboid(10);

// Rectangular box
box = Cuboid([20, 30, 10]);

// Rounded box
rounded = Cuboid([20, 20, 10], rounding=3);
```

---

### Cylinder(h, [r], [d], [r1], [r2], [d1], [d2], [center])

Creates a cylinder or cone object.

**Parameters:**
- `h`: Height of the cylinder
- `r`: Radius (use r OR d, not both)
- `d`: Diameter (use r OR d, not both)
- `r1`: Bottom radius for cones
- `r2`: Top radius for cones
- `d1`: Bottom diameter for cones
- `d2`: Top diameter for cones
- `center`: (optional) Center the shape (default: false)

**Returns:** AOSL object

**Examples:**
```openscad
// Simple cylinder
cyl = Cylinder(h=30, d=10);

// Cylinder with radius
cyl = Cylinder(h=30, r=5);

// Cone
cone = Cylinder(h=30, d1=20, d2=5);
```

---

### Sphere([r], [d])

Creates a sphere object.

**Parameters:**
- `r`: Radius (use r OR d, not both)
- `d`: Diameter (use r OR d, not both)

**Returns:** AOSL object

**Examples:**
```openscad
// Sphere with radius
sphere = Sphere(r=10);

// Sphere with diameter
sphere = Sphere(d=20);
```

## Transformation Methods

All transformation methods can be called as functions or using method notation.

### move(obj, v)

Translates/moves an object.

**Parameters:**
- `obj`: The object to transform
- `v`: Translation vector `[x, y, z]`

**Returns:** Transformed AOSL object

**Examples:**
```openscad
// Function notation
moved = move(box, [10, 0, 5]);

// Method notation (fluent)
moved = box.move([10, 0, 5]);
```

---

### rot(obj, a)

Rotates an object.

**Parameters:**
- `obj`: The object to transform
- `a`: Rotation angle(s) - scalar for Z-axis rotation, or `[x, y, z]` vector

**Returns:** Transformed AOSL object

**Examples:**
```openscad
// Rotate around Z axis
rotated = box.rot(45);

// Rotate around all axes
rotated = box.rot([45, 30, 60]);
```

---

### scale(obj, s)

Scales an object.

**Parameters:**
- `obj`: The object to transform
- `s`: Scale factor(s) - scalar for uniform scaling, or `[x, y, z]` vector

**Returns:** Transformed AOSL object

**Examples:**
```openscad
// Uniform scaling
scaled = box.scale(2);

// Non-uniform scaling
scaled = box.scale([1, 1, 2]);
```

---

### mirror(obj, v)

Mirrors an object across a plane.

**Parameters:**
- `obj`: The object to transform
- `v`: Normal vector of mirror plane `[x, y, z]`

**Returns:** Transformed AOSL object

**Examples:**
```openscad
// Mirror across YZ plane (x=0)
mirrored = box.mirror([1, 0, 0]);

// Mirror across XY plane (z=0)
mirrored = box.mirror([0, 0, 1]);
```

---

### color(obj, c)

Sets the color of an object.

**Parameters:**
- `obj`: The object to color
- `c`: Color specification (color name string like "red", or RGB(A) vector)

**Returns:** Colored AOSL object

**Examples:**
```openscad
// Named color
colored = box.color("blue");

// RGB color
colored = box.color([1, 0, 0]);

// RGBA color with transparency
colored = box.color([1, 0, 0, 0.5]);
```

## Boolean Operations

### union(obj, other)

Unions this object with another object.

**Parameters:**
- `obj`: The base object
- `other`: The object to union with

**Returns:** AOSL object with union operation

**Examples:**
```openscad
// Combine two shapes
combined = box.union(cylinder);

// Multiple unions
combined = box.union(cyl1).union(cyl2);
```

---

### subtract(obj, other)

Subtracts another object from this object (difference operation).

**Parameters:**
- `obj`: The base object
- `other`: The object to subtract

**Returns:** AOSL object with subtraction operation

**Examples:**
```openscad
// Create a hole
box_with_hole = box.subtract(cylinder);

// Multiple subtractions
box_with_holes = box.subtract(hole1).subtract(hole2);
```

---

### intersect(obj, other)

Intersects this object with another object.

**Parameters:**
- `obj`: The base object
- `other`: The object to intersect with

**Returns:** AOSL object with intersection operation

**Examples:**
```openscad
// Intersection
result = box.intersect(sphere);
```

## Rendering

### render(obj)

Renders an AOSL object to OpenSCAD geometry. This module converts the abstract AOSL object into actual 3D geometry.

**Parameters:**
- `obj`: The AOSL object to render

**Returns:** Nothing (module - produces geometry)

**Examples:**
```openscad
// Create and render
box = Cuboid([20, 20, 20]);
render(box);

// Complex object
obj = Cuboid([20, 20, 20])
    .subtract(Cylinder(h=25, d=10))
    .color("blue");
render(obj);
```

## Utility Functions

### get_type(obj)

Returns the type of an AOSL object.

**Parameters:**
- `obj`: The AOSL object

**Returns:** String type identifier

**Examples:**
```openscad
box = Cuboid([10, 10, 10]);
type = get_type(box);  // Returns "cuboid"
```

---

### get_params(obj)

Returns the parameters of an AOSL object.

**Parameters:**
- `obj`: The AOSL object

**Returns:** List of parameter pairs

**Examples:**
```openscad
box = Cuboid([10, 10, 10]);
params = get_params(box);
```

---

### get_transforms(obj)

Returns the transformations applied to an AOSL object.

**Parameters:**
- `obj`: The AOSL object

**Returns:** List of transformations

**Examples:**
```openscad
box = Cuboid([10, 10, 10]).move([5, 0, 0]).rot(45);
transforms = get_transforms(box);  // Returns list of transforms
```

## Fluent Interface

AOSL supports method chaining (fluent interface) for readable code:

```openscad
result = Cuboid([30, 30, 10])
    .move([0, 0, 5])
    .rot([0, 0, 45])
    .subtract(Cylinder(h=20, d=8))
    .color("blue");

render(result);
```

This is equivalent to:

```openscad
temp1 = Cuboid([30, 30, 10]);
temp2 = move(temp1, [0, 0, 5]);
temp3 = rot(temp2, [0, 0, 45]);
temp4 = subtract(temp3, Cylinder(h=20, d=8));
result = color(temp4, "blue");
render(result);
```

## Best Practices

1. **Use Method Chaining**: Take advantage of the fluent interface for readable code
   ```openscad
   obj = Cuboid([20, 20, 20])
       .subtract(Cylinder(h=25, d=10))
       .color("blue");
   ```

2. **Build Complex Objects Step by Step**: Break down complex objects into simpler components
   ```openscad
   base = Cuboid([50, 50, 5]);
   post = Cylinder(h=30, d=8).move([0, 0, 5]);
   top = Sphere(r=6).move([0, 0, 35]);
   
   assembly = base.union(post).union(top);
   ```

3. **Apply Transformations to Children**: Transform objects before using them in boolean operations
   ```openscad
   hole = Cylinder(h=20, d=8).move([10, 0, 0]);
   box = Cuboid([30, 30, 10]).subtract(hole);
   ```

4. **Use Named Variables**: Give meaningful names to objects for clarity
   ```openscad
   mounting_plate = Cuboid([50, 50, 5]);
   center_hole = Cylinder(h=10, d=30);
   mounting_hole = Cylinder(h=10, d=5);
   
   plate = mounting_plate
       .subtract(center_hole)
       .subtract(mounting_hole.move([15, 15, 0]))
       .subtract(mounting_hole.move([-15, 15, 0]));
   ```
