# Changelog

All notable changes to AOSL will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Initial Release - 2025-12-19

#### Added
- Core object system using OpenSCAD's new object feature
- Object-oriented wrappers for BOSL2 primitives
  - `Cuboid()` - Box/cube with optional rounding
  - `Cylinder()` - Cylinder/cone shapes
  - `Sphere()` - Sphere shapes
- Transformation methods with fluent interface
  - `move()` - Translation
  - `rot()` - Rotation
  - `scale()` - Scaling
  - `mirror()` - Mirroring
  - `color()` - Color assignment
- Boolean operations
  - `union()` - Union/addition
  - `subtract()` - Difference/subtraction
  - `intersect()` - Intersection
- Rendering system
  - `render()` module to convert AOSL objects to OpenSCAD geometry
  - Support for nested transformations
  - Support for complex boolean operation trees
- Utility functions
  - `get_type()` - Get object type
  - `get_params()` - Get object parameters
  - `get_transforms()` - Get object transformations
- Documentation
  - Comprehensive README with quick start
  - Complete API reference (API.md)
  - Quick start guide (QUICKSTART.md)
  - Contributing guidelines (CONTRIBUTING.md)
- Examples
  - Basic shapes demonstration
  - Transformations examples
  - Boolean operations examples
  - Real-world objects examples
  - Complete project example
- Tests
  - Basic object creation tests
  - Transformation tests
  - Boolean operation tests
  - Test runner script (run_tests.sh)

#### Technical Details
- Requires OpenSCAD 2024.11 or later (with object support)
- Requires BOSL2 library
- Licensed under Apache License 2.0

[Unreleased]: https://github.com/aQute-os/aosl/compare/...HEAD
