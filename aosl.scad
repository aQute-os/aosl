//////////////////////////////////////////////////////////////////////
// LibFile: aosl.scad
//   aQute Object System Library for OpenSCAD
//   An object-oriented wrapper for BOSL2 functionality
//
// FileSummary: Object-oriented interface to BOSL2
// Requires: OpenSCAD 2024.11+ (with object support), BOSL2
// License: Apache 2.0
//////////////////////////////////////////////////////////////////////

// Core object constructor
// Creates a base object structure for AOSL
function _aosl_object(type, params=[], transforms=[], children=[], op="none", color_val=undef) =
    object(
        type = type,
        params = params,
        transforms = transforms,
        children = children,
        op = op,
        color_val = color_val
    );

// Helper function to add a transformation to an object
function _add_transform(obj, transform_type, transform_params) =
    object(
        type = obj.type,
        params = obj.params,
        transforms = concat(obj.transforms, [[transform_type, transform_params]]),
        children = obj.children,
        op = obj.op,
        color_val = obj.color_val
    );

// Helper function to add a child object
function _add_child(obj, child, operation) =
    object(
        type = obj.type,
        params = obj.params,
        transforms = obj.transforms,
        children = concat(obj.children, [[child, operation]]),
        op = obj.op,
        color_val = obj.color_val
    );

//////////////////////////////////////////////////////////////////////
// Section: Shape Constructors
//////////////////////////////////////////////////////////////////////

// Function: Cuboid()
// Usage:
//   obj = Cuboid(size, [rounding], [edges], [center]);
// Description:
//   Creates a cuboid/box object
// Arguments:
//   size = The size of the cuboid as [x,y,z] or a single number for a cube
//   rounding = Optional rounding radius for edges
//   edges = Optional edges to round (BOSL2 edge spec)
//   center = If true, center the cuboid. Default: true
function Cuboid(size, rounding=0, edges=EDGES_ALL, center=true) =
    _aosl_object(
        type = "cuboid",
        params = [
            ["size", size],
            ["rounding", rounding],
            ["edges", edges],
            ["center", center]
        ]
    );

// Function: Cylinder()
// Usage:
//   obj = Cylinder(h, [r], [d], [r1], [r2], [d1], [d2], [center]);
// Description:
//   Creates a cylinder object
// Arguments:
//   h = Height of the cylinder
//   r = Radius of the cylinder
//   d = Diameter of the cylinder
//   r1 = Bottom radius (for cones)
//   r2 = Top radius (for cones)
//   d1 = Bottom diameter (for cones)
//   d2 = Top diameter (for cones)
//   center = If true, center the cylinder. Default: false
function Cylinder(h, r=undef, d=undef, r1=undef, r2=undef, d1=undef, d2=undef, center=false) =
    _aosl_object(
        type = "cylinder",
        params = [
            ["h", h],
            ["r", r],
            ["d", d],
            ["r1", r1],
            ["r2", r2],
            ["d1", d1],
            ["d2", d2],
            ["center", center]
        ]
    );

// Function: Sphere()
// Usage:
//   obj = Sphere([r], [d]);
// Description:
//   Creates a sphere object
// Arguments:
//   r = Radius of the sphere
//   d = Diameter of the sphere
function Sphere(r=undef, d=undef) =
    _aosl_object(
        type = "sphere",
        params = [
            ["r", r],
            ["d", d]
        ]
    );

//////////////////////////////////////////////////////////////////////
// Section: Transformation Methods
//////////////////////////////////////////////////////////////////////

// Function: move()
// Usage:
//   obj2 = obj.move(v);
// Description:
//   Translates/moves an object
// Arguments:
//   v = Translation vector [x,y,z]
function move(obj, v) = _add_transform(obj, "move", v);

// Function: rot()
// Usage:
//   obj2 = obj.rot(a);
// Description:
//   Rotates an object
// Arguments:
//   a = Rotation, can be a scalar (z rotation) or [x,y,z] vector
function rot(obj, a) = _add_transform(obj, "rot", a);

// Function: scale()
// Usage:
//   obj2 = obj.scale(s);
// Description:
//   Scales an object
// Arguments:
//   s = Scale factor, can be scalar or [x,y,z] vector
function scale(obj, s) = _add_transform(obj, "scale", s);

// Function: mirror()
// Usage:
//   obj2 = obj.mirror(v);
// Description:
//   Mirrors an object across a plane
// Arguments:
//   v = Normal vector of the mirror plane
function mirror(obj, v) = _add_transform(obj, "mirror", v);

// Function: color()
// Usage:
//   obj2 = obj.color(c);
// Description:
//   Sets the color of an object
// Arguments:
//   c = Color specification (name string or [r,g,b] or [r,g,b,a])
function color(obj, c) =
    object(
        type = obj.type,
        params = obj.params,
        transforms = obj.transforms,
        children = obj.children,
        op = obj.op,
        color_val = c
    );

//////////////////////////////////////////////////////////////////////
// Section: Boolean Operations
//////////////////////////////////////////////////////////////////////

// Function: union()
// Usage:
//   obj2 = obj.union(other);
// Description:
//   Unions this object with another object
// Arguments:
//   other = The object to union with
function union(obj, other) = _add_child(obj, other, "union");

// Function: subtract()
// Usage:
//   obj2 = obj.subtract(other);
// Description:
//   Subtracts another object from this object
// Arguments:
//   other = The object to subtract
function subtract(obj, other) = _add_child(obj, other, "subtract");

// Function: intersect()
// Usage:
//   obj2 = obj.intersect(other);
// Description:
//   Intersects this object with another object
// Arguments:
//   other = The object to intersect with
function intersect(obj, other) = _add_child(obj, other, "intersect");

//////////////////////////////////////////////////////////////////////
// Section: Rendering
//////////////////////////////////////////////////////////////////////

// Module: _render_shape()
// Usage:
//   _render_shape(obj);
// Description:
//   Internal module to render a single shape based on type
module _render_shape(obj) {
    if (obj.type == "cuboid") {
        // Extract parameters
        size = [for (p = obj.params) if (p[0] == "size") p[1]][0];
        rounding = [for (p = obj.params) if (p[0] == "rounding") p[1]][0];
        edges = [for (p = obj.params) if (p[0] == "edges") p[1]][0];
        center = [for (p = obj.params) if (p[0] == "center") p[1]][0];
        
        if (rounding > 0) {
            cuboid(size, rounding=rounding, edges=edges, anchor=center ? CENTER : BOTTOM);
        } else {
            cuboid(size, anchor=center ? CENTER : BOTTOM);
        }
    }
    else if (obj.type == "cylinder") {
        // Extract parameters
        h = [for (p = obj.params) if (p[0] == "h") p[1]][0];
        r = [for (p = obj.params) if (p[0] == "r") p[1]][0];
        d = [for (p = obj.params) if (p[0] == "d") p[1]][0];
        r1 = [for (p = obj.params) if (p[0] == "r1") p[1]][0];
        r2 = [for (p = obj.params) if (p[0] == "r2") p[1]][0];
        d1 = [for (p = obj.params) if (p[0] == "d1") p[1]][0];
        d2 = [for (p = obj.params) if (p[0] == "d2") p[1]][0];
        center = [for (p = obj.params) if (p[0] == "center") p[1]][0];
        
        if (r1 != undef || r2 != undef || d1 != undef || d2 != undef) {
            cyl(h=h, r1=r1, r2=r2, d1=d1, d2=d2, anchor=center ? CENTER : BOTTOM);
        } else if (r != undef) {
            cyl(h=h, r=r, anchor=center ? CENTER : BOTTOM);
        } else if (d != undef) {
            cyl(h=h, d=d, anchor=center ? CENTER : BOTTOM);
        } else {
            cyl(h=h, anchor=center ? CENTER : BOTTOM);
        }
    }
    else if (obj.type == "sphere") {
        // Extract parameters
        r = [for (p = obj.params) if (p[0] == "r") p[1]][0];
        d = [for (p = obj.params) if (p[0] == "d") p[1]][0];
        
        if (r != undef) {
            spheroid(r=r);
        } else if (d != undef) {
            spheroid(d=d);
        } else {
            spheroid();
        }
    }
}

// Module: _apply_transforms()
// Usage:
//   _apply_transforms(transforms) { ... }
// Description:
//   Internal module to apply a list of transformations
module _apply_transforms(transforms) {
    if (len(transforms) == 0) {
        children();
    } else {
        t = transforms[0];
        t_type = t[0];
        t_params = t[1];
        remaining = [for (i = [1:len(transforms)-1]) transforms[i]];
        
        if (t_type == "move") {
            translate(t_params) _apply_transforms(remaining) children();
        } else if (t_type == "rot") {
            rotate(t_params) _apply_transforms(remaining) children();
        } else if (t_type == "scale") {
            scale(t_params) _apply_transforms(remaining) children();
        } else if (t_type == "mirror") {
            mirror(t_params) _apply_transforms(remaining) children();
        } else {
            _apply_transforms(remaining) children();
        }
    }
}

// Module: _render_children()
// Usage:
//   _render_children(children_list);
// Description:
//   Internal module to render child objects with boolean operations
module _render_children(children_list) {
    for (i = [0:len(children_list)-1]) {
        child_obj = children_list[i][0];
        child_op = children_list[i][1];
        
        if (child_op == "subtract") {
            render(child_obj);
        } else if (child_op == "intersect") {
            render(child_obj);
        } else if (child_op == "union") {
            render(child_obj);
        }
    }
}

// Module: render()
// Usage:
//   obj.render();
// Description:
//   Renders an AOSL object to OpenSCAD geometry
module render(obj) {
    // Apply color if specified
    if (obj.color_val != undef) {
        color(obj.color_val) _render_with_children(obj);
    } else {
        _render_with_children(obj);
    }
}

// Internal module to handle rendering with children
module _render_with_children(obj) {
    // Check if we have children (boolean operations)
    if (len(obj.children) > 0) {
        // Separate children by operation type
        subtract_children = [for (c = obj.children) if (c[1] == "subtract") c[0]];
        intersect_children = [for (c = obj.children) if (c[1] == "intersect") c[0]];
        union_children = [for (c = obj.children) if (c[1] == "union") c[0]];
        
        // Apply boolean operations
        difference() {
            intersection() {
                union() {
                    // Render main object
                    _apply_transforms(obj.transforms) {
                        _render_shape(obj);
                    }
                    
                    // Render union children
                    for (child = union_children) {
                        render(child);
                    }
                }
                
                // Render intersect children (if any)
                if (len(intersect_children) > 0) {
                    for (child = intersect_children) {
                        render(child);
                    }
                } else {
                    // If no intersect children, create a large bounding box
                    cube([10000, 10000, 10000], center=true);
                }
            }
            
            // Render subtract children
            for (child = subtract_children) {
                render(child);
            }
        }
    } else {
        // No children, just render the object with transforms
        _apply_transforms(obj.transforms) {
            _render_shape(obj);
        }
    }
}

//////////////////////////////////////////////////////////////////////
// Section: Utility Functions
//////////////////////////////////////////////////////////////////////

// Function: get_type()
// Usage:
//   type = obj.get_type();
// Description:
//   Returns the type of an AOSL object
function get_type(obj) = obj.type;

// Function: get_params()
// Usage:
//   params = obj.get_params();
// Description:
//   Returns the parameters of an AOSL object
function get_params(obj) = obj.params;

// Function: get_transforms()
// Usage:
//   transforms = obj.get_transforms();
// Description:
//   Returns the transformations of an AOSL object
function get_transforms(obj) = obj.transforms;
