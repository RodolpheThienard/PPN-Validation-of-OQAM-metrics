# x87 instructions checks

This test suit tests verifies that MAQAO sees the x87 float instructions,
that are less efficient than SSE or AVX.

The test suits is a collections of functions that uses one x87 instruction
with inline assembly code.

For each binary CQA is called and its output is piped to grep, that will
let us check if the string x87 is present.

To run the test use:

```
$ ./run_tests.sh
```
