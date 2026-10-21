# Task 2 - Static and dynamic binding in C#

## Goal

Show the difference between static and dynamic binding in C#, using the `virtual`, `new` and `override` keywords.

## How to run

I ran the program on [onlinegdb.com](https://www.onlinegdb.com): choose C#, paste the code from `Binding.cs` and click Run.

It should also run with .NET 10 or newer, from the `task2` folder:

```bash
dotnet run Binding.cs
```

## Idea

When a method is called, the program must decide which version to run: the parent's or the child's.

- **Static binding** - decided at compile time, by the **type of the variable**.
- **Dynamic binding** - decided at run time, by the **real type of the object**.

| Keyword    | Where  | Meaning                                                               |
| ---------- | ------ | --------------------------------------------------------------------- |
| `virtual`  | parent | the method can be replaced, so check the real object at run time      |
| `override` | child  | replaces the parent's virtual method (dynamic binding)                |
| `new`      | child  | hides the parent's method; the variable type decides (static binding) |

## How it works

`Binding.cs` has three classes:

- `Animal` - `Describe()` is a normal method, `Speak()` is `virtual`.
- `Dog` - hides `Describe()` with `new` and overrides `Speak()` with `override`.
- `Cat` - hides the virtual `Speak()` with `new` instead of overriding it.

The user enters a name and a type (`dog`, `cat` or `animal`). The object is stored in an `Animal` variable, so the compiler does not know its real type, it is chosen at run time. Then both methods are called twice: through the `Animal` variable and through a variable of the object's own type.

## Results

```text
Name: Alabash
Animal type (dog, cat, animal): dog

Real object type: Dog

Through an Animal variable:
Describe(): Alabash is an animal
Speak(): Alabash barks

Through a variable of its own type (Dog):
Describe(): Alabash is a dog
Speak(): Alabash barks
```

```text
Name: Mia
Animal type (dog, cat, animal): cat

Real object type: Cat

Through an Animal variable:
Describe(): Mia is an animal
Speak(): Mia makes a sound

Through a variable of its own type (Cat):
Describe(): Mia is an animal
Speak(): Mia meows
```

With `animal`, both views print the `Animal` versions ("is an animal", "makes a sound").

## Explanation

**Dog, `Speak()` with `override`:** "barks" in both views. `Speak` is virtual, so the program checks the real object at run time, finds a Dog and runs its version. This is dynamic binding and the base of polymorphism.

**Dog, `Describe()` with `new`:** "is an animal" through the `Animal` variable, "is a dog" through the `Dog` variable. `Describe` is not virtual, so only the variable type is used, at compile time. This is static binding.

**Cat, `Speak()` with `new`:** "makes a sound" through the `Animal` variable, "meows" only through the `Cat` variable. `Speak` is virtual, but Cat uses `new` instead of `override`, so its version is hidden and the parent's version runs. So `virtual` alone is not enough, the child must also use `override`.

In short: with `override` the real object decides, with `new` the variable type decides.

## Critique

- **`new` can be confusing.** The same object can give different results depending on the variable type, like in the Cat example. Because of this, using `new` by mistake instead of `override` can easily cause bugs.

- **C# makes you choose which methods can be overridden.** A method is dynamic only if the parent marks it as `virtual`. I think this gives more control, because the parent class decides which methods child classes are allowed to replace.

- **Dynamic binding can have a small extra cost.** The method is chosen at run time, so it may need a little more work than a normal method call. In practice, modern compilers can optimize many cases, so this difference is usually small.

- **My "own type" view uses manual type checks.** I use checks like `as Dog` and `as Cat` to call the child versions. If I add more classes, this becomes longer, which is why using `override` and polymorphism is usually cleaner.

