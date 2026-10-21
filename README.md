# CSCI 6221 Advanced Software Paradigms - Assignment 3

Kamran Pirishzada

Each task has its own folder with the code and a `README.md` report.

## Tasks

| Task                      | Topic                         | Language |
| ------------------------- | ----------------------------- | -------- |
| [Task 1](task1/README.md) | Static, stack and heap arrays | C        |
| [Task 2](task2/README.md) | Static and dynamic binding    | C#       |
| [Task 3](task3/README.md) | Library catalog with OOP      | Ruby     |

## How to run

From the repository root:

**Task 1** (gcc or clang)

```bash
cd task1
gcc -O2 -Wall -Wextra memory.c -o memory
./memory
```

**Task 2** (I used [onlinegdb.com](https://www.onlinegdb.com); with .NET 10 or newer it also runs locally)

```bash
cd task2
dotnet run Binding.cs
```

**Task 3** (Ruby 3 or newer)

```bash
cd task3
ruby main.rb
ruby demo.rb
```

More details are in the README of each task.

## Structure

```text
task1/
  README.md
  memory.c
task2/
  README.md
  Binding.cs
task3/
  README.md
  main.rb
  demo.rb
  lib/
```
