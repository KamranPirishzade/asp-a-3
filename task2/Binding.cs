using System;

class Animal
{
    public string Name { get; }

    public Animal(string name)
    {
        Name = name;
    }

    public string Describe() => $"{Name} is an animal";

    public virtual string Speak() => $"{Name} makes a sound";
}

class Dog : Animal
{
    public Dog(string name) : base(name) { }

    public new string Describe() => $"{Name} is a dog";

    public override string Speak() => $"{Name} barks";
}

class Cat : Animal
{
    public Cat(string name) : base(name) { }

    public new string Speak() => $"{Name} meows";
}

class Program
{
    static void Main()
    {
        Console.Write("Name: ");
        string name = Console.ReadLine()?.Trim();
        if (string.IsNullOrEmpty(name))
        {
            Console.WriteLine("Name cannot be empty.");
            return;
        }

        Console.Write("Animal type (dog, cat, animal): ");
        string type = Console.ReadLine()?.Trim().ToLower();

        Animal animal;
        switch (type)
        {
            case "dog": animal = new Dog(name); break;
            case "cat": animal = new Cat(name); break;
            case "animal": animal = new Animal(name); break;
            default:
                Console.WriteLine("Unknown type.");
                return;
        }

        Console.WriteLine($"\nReal object type: {animal.GetType().Name}");

        Console.WriteLine("\nThrough an Animal variable:");
        Console.WriteLine($"Describe(): {animal.Describe()}");
        Console.WriteLine($"Speak(): {animal.Speak()}");
        
        Console.WriteLine($"\nThrough a variable of its own type ({animal.GetType().Name}):");
        
        Dog dog = animal as Dog;
        Cat cat = animal as Cat;
        if (dog != null)
        {
            Console.WriteLine($"Describe(): {dog.Describe()}");
            Console.WriteLine($"Speak(): {dog.Speak()}");
        }
        else if (cat != null)
        {
            Console.WriteLine($"Describe(): {cat.Describe()}");
            Console.WriteLine($"Speak(): {cat.Speak()}");
        }
        else
        {
            Console.WriteLine($"Describe(): {animal.Describe()}");
            Console.WriteLine($"Speak(): {animal.Speak()}");
        }
    }
}