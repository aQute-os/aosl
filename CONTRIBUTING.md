# Contributing to AOSL

Thank you for your interest in contributing to AOSL (aQute Object System Library)! This document provides guidelines for contributing to the project.

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with:
- A clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Your OpenSCAD version
- Example code that demonstrates the issue

### Suggesting Enhancements

Enhancement suggestions are welcome! Please create an issue describing:
- The enhancement and its benefits
- Example use cases
- Proposed API (if applicable)

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Update documentation as needed
7. Commit your changes with clear messages
8. Push to your fork
9. Create a pull request

## Development Setup

### Prerequisites

- OpenSCAD 2024.11 or later (with object support)
- BOSL2 library
- Git

### Getting Started

```bash
# Clone the repository
git clone https://github.com/aQute-os/aosl.git
cd aosl

# Run tests
./run_tests.sh
```

## Code Style

### OpenSCAD Conventions

- Use 4 spaces for indentation (not tabs)
- Use snake_case for internal functions/modules (prefixed with `_`)
- Use PascalCase for public constructor functions
- Use lowercase for transformation and operation methods
- Add comprehensive documentation comments

### Documentation Comments

Follow this format for functions and modules:

```openscad
// Function: FunctionName()
// Usage:
//   result = FunctionName(param1, param2);
// Description:
//   Brief description of what the function does
// Arguments:
//   param1 = Description of parameter 1
//   param2 = Description of parameter 2
// Returns: What the function returns
// Examples:
//   example_code();
function FunctionName(param1, param2) = ...
```

## Testing

### Running Tests

```bash
./run_tests.sh
```

### Writing Tests

Test files should:
- Be placed in the `tests/` directory
- Start with `test_` prefix
- Use `assert()` for validation
- Use `echo()` to report progress
- Test both positive and negative cases

Example test:

```openscad
include <BOSL2/std.scad>
include <../aosl.scad>

echo("Test: Object Creation");
obj = Cuboid([10, 10, 10]);
assert(obj.type == "cuboid", "Type should be cuboid");
echo("✓ Test passed");
```

## Adding New Features

### Adding a New Shape

1. Create a constructor function in `aosl.scad`:
```openscad
function NewShape(params) =
    _aosl_object(
        type = "newshape",
        params = [["param1", param1], ...]
    );
```

2. Add rendering logic to `_render_shape()` module
3. Add documentation to API.md
4. Create tests in `tests/test_new_shape.scad`
5. Add examples in `examples/`

### Adding a New Transformation

1. Create transformation function:
```openscad
function new_transform(obj, params) = 
    _add_transform(obj, "new_transform", params);
```

2. Add application logic to `_apply_transforms()` module
3. Add documentation to API.md
4. Create tests

### Adding a New Boolean Operation

1. Create operation function:
```openscad
function new_operation(obj, other) = 
    _add_child(obj, other, "new_operation");
```

2. Add handling logic to `_render_with_children()` module
3. Add documentation to API.md
4. Create tests

## Documentation

### What to Document

- All public functions and modules
- Parameters and return values
- Usage examples
- Edge cases and limitations

### Where to Document

- **Inline comments**: In the code files
- **API.md**: Comprehensive API reference
- **README.md**: Overview and quick start
- **Examples**: Working code in `examples/` directory

## Commit Messages

Write clear commit messages:

```
Add sphere primitive support

- Implement Sphere() constructor
- Add sphere rendering logic
- Add tests for sphere creation
- Update API documentation
```

Format:
- First line: Short summary (50 chars or less)
- Blank line
- Detailed description if needed
- List of changes (bullet points)

## Review Process

1. Automated tests must pass
2. Code review by maintainers
3. Documentation review
4. Merge when approved

## Questions?

Open an issue or start a discussion on GitHub.

## License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0.
