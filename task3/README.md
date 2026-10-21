# Task 3 - Library catalog in Ruby

## Goal

The goal is to build a small library catalog in Ruby and show the main OOP ideas: classes, inheritance, encapsulation and polymorphism.

## Structure

```text
task3/
  main.rb
  demo.rb
  lib/
    library_item.rb
    book.rb
    dvd.rb
    cd.rb
    library.rb
```

The classes are inside `lib/`, and the other files are used to test and demonstrate them.

## Design

**`LibraryItem`.** This is the base class for all items. It stores the common information like title, author, year and genre. It also checks some invalid input, for example an empty title or wrong year. I do not allow this class to be created directly because it is only meant to be used as a parent class.

**`Book`, `DVD`, `CD`.** These classes inherit from `LibraryItem`. They only add the parts that are different. For example, a Book can have pages, a DVD can have duration, and a CD can have tracks. Their `display_info` methods use `super` and then print their own extra information.

**`Library`.** This class keeps all items in one private array. It has methods to add, remove and display items.

**Why genre is in the base class.** The task text gives genre as an example of a Book property, but the test examples give a genre for Book, DVD and CD, so I treated genre as common data. If I added it separately in every child class, I would repeat the same code.

**Optional properties.** `pages`, `duration` and `tracks` are optional, so the program still works with the values given in the task.

## Results

Running `ruby main.rb` gives:

```text
Book: Concepts of Programming Languages
  Author: Robert Sebesta
  Year: 2015
  Genre: Programming
DVD: Inception
  Director: Christopher Nolan
  Year: 2010
  Genre: Science Fiction
CD: A Day at the Races
  Artist: Queen
  Year: 1976
  Genre: Rock
```

`display_all_items` then prints the same items through the `Library` class.

In `demo.rb` I also checked the OOP ideas separately:

| Output                            | What it shows                                          |
| --------------------------------- | ------------------------------------------------------ |
| `true`                            | a Book is also a LibraryItem                           |
| `Christopher Nolan`, `Queen`      | DVD and CD have their own methods                      |
| `undefined method 'title='`       | the title cannot be changed directly                   |
| `LibraryItem is abstract`         | the base class cannot be created directly              |
| `year must be a positive integer` | invalid input is rejected                              |
| Book, DVD, CD, Magazine details   | polymorphism                                           |
| `Inception`, `nil`                | removing an item works, and missing items return `nil` |
| `only library items can be added` | other object types are rejected                        |

### Polymorphism

`display_item` only calls:

```ruby
item.display_info
```

It does not check whether the object is a Book, DVD or CD. Ruby chooses the correct method from the real object.

To test this, I created a new `Magazine` class in `demo.rb`. I did not change the `Library` class, but it could still display the Magazine correctly. This helped me understand polymorphism better because the same method call works with different object types.

## Using Ruby

From this task, Ruby felt very simple to work with. The syntax is short and easy to read, for example:

```ruby
attr_reader :title
item.is_a?(LibraryItem)
raise ... unless ...
```

In the output, the details are indented with two spaces, so the type and title work like a header and the data is shown under it.

Compared to C# in Task 2:

- **No `virtual` or `override`.** Ruby uses dynamic binding by default. If a child class defines the same method, Ruby automatically uses the child's version.
- **Errors happen at run time.** Ruby does not check types in the same way as C#, so some mistakes only appear when that line is executed.
- **The ideas are similar.** `attr_reader` is similar to a read-only property, and `super` is similar to `base`.
- **No `abstract` keyword.** I had to stop `LibraryItem` from being created by adding a check myself.

## Critique

- **`is_a?` is a little strict.** I only allow objects that are `LibraryItem` objects. Ruby normally allows more flexible code, so another object with `display_info` would still be rejected.

- **Encapsulation in Ruby is not completely strict.** Normal code cannot directly change some values, but Ruby still gives ways to reach them, for example `instance_variable_set` or `send` for private methods.

- **The field name `author` is not perfect for every type.** For DVDs it stores the director, and for CDs it stores the artist. A name like `creator` would make more sense, but I kept `author` because the task uses it.

- **`display_info` prints directly.** This is enough for the task, but returning a string could make testing easier.

- **Items do not have unique IDs.** If two items have the same title, `remove_item` removes the first one it finds.

## How to run

From the `task3` folder:

```bash
ruby main.rb
ruby demo.rb
```

Ruby 3 or newer is required.
