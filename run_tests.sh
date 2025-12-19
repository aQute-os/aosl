#!/bin/bash
######################################################################
# Test Runner for AOSL
# Runs all test files through OpenSCAD to verify functionality
######################################################################

echo "================================"
echo "AOSL Test Runner"
echo "================================"
echo ""

# Check if OpenSCAD is installed
if ! command -v openscad &> /dev/null; then
    echo "ERROR: OpenSCAD not found. Please install OpenSCAD to run tests."
    echo "Visit: https://openscad.org/"
    exit 1
fi

# Check OpenSCAD version
echo "OpenSCAD version:"
openscad --version
echo ""

# Directory containing tests
TEST_DIR="tests"
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Run each test file
for test_file in "$TEST_DIR"/test_*.scad; do
    if [ -f "$test_file" ]; then
        TOTAL_TESTS=$((TOTAL_TESTS + 1))
        echo "Running: $test_file"
        
        # Run OpenSCAD with the test file (export to null to just execute)
        if openscad -o /dev/null "$test_file" 2>&1 | tee /tmp/openscad_output.txt; then
            # Check for assertion failures or errors in output
            if grep -q "ERROR\|TRACE\|WARNING.*Assertion" /tmp/openscad_output.txt; then
                echo "  ✗ FAILED"
                FAILED_TESTS=$((FAILED_TESTS + 1))
            else
                echo "  ✓ PASSED"
                PASSED_TESTS=$((PASSED_TESTS + 1))
            fi
        else
            echo "  ✗ FAILED (OpenSCAD error)"
            FAILED_TESTS=$((FAILED_TESTS + 1))
        fi
        echo ""
    fi
done

# Print summary
echo "================================"
echo "Test Summary"
echo "================================"
echo "Total Tests:  $TOTAL_TESTS"
echo "Passed:       $PASSED_TESTS"
echo "Failed:       $FAILED_TESTS"
echo ""

if [ $FAILED_TESTS -eq 0 ]; then
    echo "All tests passed! ✓"
    exit 0
else
    echo "Some tests failed! ✗"
    exit 1
fi
