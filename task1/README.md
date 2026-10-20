# Task 1 - Static, stack and heap arrays

## Goal

The goal is to compare how fast it is to get a large array using static, stack and heap memory when a function is called many times.

## How it works

`memory.c` has three functions:

- `static_array` uses a static array, so the same memory is reused every call.
- `stack_array` creates a local array on the stack.
- `heap_array` uses `malloc` and `free` every call.

Only getting the memory is measured. Only the first and last elements are written, because filling the whole array would hide the difference between the three methods.

The arrays are `volatile` so the compiler does not remove them during optimization.

The number of calls is given by the user. `SIZE` is set at compile time (default 1,000,000 ints = 3.8 MB), because the size of a static array must be known when the program is compiled. It can be changed with `-DSIZE=...`.

## Results

macOS, Apple M5, Apple clang, `-O2`, 10,000,000 calls:

| | 3.8 MB array | 4 KB array |
|---|---|---|
| static | 0.9 ns | 1.0 ns |
| stack | 0.8 ns | 0.7 ns |
| heap | 46.0 ns | 15.0 ns |

## Explanation

Static and stack memory were almost the same speed, around 1 ns per call. Static memory already exists, and stack allocation is very cheap because it mainly changes the stack pointer. The array size made no difference for static and stack, because the cost does not depend on how much memory is reserved.

Heap memory was much slower because `malloc` and `free` have to manage memory every time the function is called.

The larger heap array was slower than the smaller one, because macOS handles large blocks in a different, slower way. I also saw that with more calls, the average heap time became lower (82 ns with 100,000 calls, 46 ns with 10,000,000 calls), probably because the first allocations are more expensive and later memory can be reused.

The heap is slower, but it is still useful when the size is only known at run time, when the data must live after the function returns, or when the array is too large for the stack.

## Critique

- Static and stack are both almost free here. Around 1 ns is very small, so most of that time may just be the function call and loop. Because of this, I cannot really say which one is faster.
- The heap test is probably an easy case for `malloc`. The program always allocates the same size and frees it immediately, so the allocator can reuse memory. In a real program with different sizes, the heap can be slower.
- I only write to the first and last element. A real program would usually use more of the array, so this test does not include the full cost of touching all memory pages. This matters more for the heap: static and stack pages stay loaded after the first call, but new heap memory may not.
- Static memory also has disadvantages. The same array is shared between calls, so it is not safe with recursion or threads, and it stays in memory for the whole program.
- The result is only from my machine, from one run, and static is always measured first. Different compilers can also change the result. On Linux, gcc may check every 4 KB page for a large stack array, so stack allocation can be slower there.

## How to run

```bash
gcc -O2 -Wall -Wextra memory.c -o memory
./memory

gcc -O2 -DSIZE=1000 memory.c -o memory_small
./memory_small
```