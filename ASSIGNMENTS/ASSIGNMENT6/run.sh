#!/bin/bash

# This script compiles the P6 compiler, then for each test case in 'input/',
# it compares the output of running the .RA file with kgi.jar against the output
# of compiling it with P6 and running the resulting .s file with SPIM.

echo "--- Starting Build and Test Process ---"

# 1. Create output directories if they don't exist
mkdir -p out
mkdir -p output

# 2. Compile the P6 compiler with Java 8 compatibility
echo "Compiling the P6 compiler..."
find . -name "*.java" | xargs javac -d out -source 8 -target 8

# 3. Check if P6 compilation was successful
if [ $? -ne 0 ]; then
    echo "P6 compiler compilation failed. Aborting."
    exit 1
fi

echo "P6 compiler compilation successful."

# Check if any .RA files exist before starting the loop
if ! ls input/*.RA 1> /dev/null 2>&1; then
    echo "No .RA files found in the 'input' directory. Exiting."
    exit 0
fi

echo "--- Running Test Cases ---"

# Counter and lists for failed tests
diff_count=0
timeout_secs=10
failed_tests=()

# 4. Loop through every .RA file in the 'input' directory
for infile in input/*.RA
do
    base_name=$(basename "$infile")
    test_name="${base_name%.RA}"

    echo "--- Processing test case: $test_name ---"

    mips_file="output/${test_name}.s"
    ref_output="output/${test_name}.ref.txt"
    my_output="output/${test_name}.my.txt"

    # --- STEP A: Generate Reference Output ---
    echo "  1. Generating reference output from $base_name..."
    java -jar kgi.jar < "$infile" > "$ref_output" 2>&1

    # --- STEP B: Generate Your Output ---
    echo "  2. Compiling with P6 to create $mips_file..."
    java -cp out P6 < "$infile" > "$mips_file"

    # --- STEP B2: Run with SPIM (with timeout for infinite loops) ---
    echo "  3. Running $mips_file with SPIM (timeout = ${timeout_secs}s)..."
    timeout "$timeout_secs" spim -file "$mips_file" 2>&1 | tail -n +2 > "$my_output"
    exit_status=$?

    if [ $exit_status -eq 124 ]; then
        echo "  ⚠️  TIMEOUT: $test_name took too long — possible infinite loop."
        echo "  ❌ FAILURE: Marking $test_name as failed due to infinite loop."
        ((diff_count++))
        failed_tests+=("$test_name (infinite loop)")
        continue
    fi

    # --- STEP C: Compare Outputs ---
    echo "  4. Comparing outputs..."
    if diff -wB "$ref_output" "$my_output" > /dev/null; then
        echo "  ✅ SUCCESS: Outputs for $test_name match."
    else
        echo "  ❌ FAILURE: Outputs for $test_name DO NOT MATCH."
        ((diff_count++))
        failed_tests+=("$test_name")
        echo "        Run this command to see the difference:"
        echo "        diff -y --suppress-common-lines \"$ref_output\" \"$my_output\""
    fi
done

echo "--- All test cases processed. ---"

# Final summary
if [ $diff_count -eq 0 ]; then
    echo "🎉 All tests passed successfully!"
    rm output/*.ref.txt output/*.my.txt
else
    echo "🔥 $diff_count test(s) failed."
    echo "🔍 Failed tests:"
    for t in "${failed_tests[@]}"; do
        echo "   - $t"
    done
    exit 1
fi
