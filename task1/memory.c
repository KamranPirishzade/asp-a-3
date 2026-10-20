#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#ifndef SIZE
#define SIZE 1000000
#endif

static void static_array(void) {
    static volatile int arr[SIZE];
    arr[0] = 1;
    arr[SIZE - 1] = arr[0];
}

static void stack_array(void) {
    volatile int arr[SIZE];
    arr[0] = 1;
    arr[SIZE - 1] = arr[0];
}

static void heap_array(void) {
    volatile int *arr = malloc(SIZE * sizeof(int));
    if (arr == NULL) {
        fprintf(stderr, "malloc failed\n");
        exit(1);
    }

    arr[0] = 1;
    arr[SIZE - 1] = arr[0];
    free((void *)arr);
}

static double measure_ms(void (*function)(void), long calls) {
    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);
    for (long i = 0; i < calls; i++) {
        function();
    }
    clock_gettime(CLOCK_MONOTONIC, &end);
    return (end.tv_sec - start.tv_sec) * 1e3 + (end.tv_nsec - start.tv_nsec) / 1e6;
}

int main(void) {
    long calls;
    printf("Number of calls: ");
    if (scanf("%ld", &calls) != 1 || calls <= 0) {
        fprintf(stderr, "Please enter a positive integer\n");
        return 1;
    }

    printf("Array: %d ints (%.1f MB), %ld calls\n\n",
           SIZE, SIZE * sizeof(int) / (1024.0 * 1024.0), calls);

    const char *names[] = {"static", "stack", "heap"};
    void (*functions[])(void) = {static_array, stack_array, heap_array};

    for (int i = 0; i < 3; i++) {
        double ms = measure_ms(functions[i], calls);
        printf("%-7s %10.3f ms  (%.1f ns per call)\n", names[i], ms, ms * 1e6 / calls);
    }
    return 0;
}