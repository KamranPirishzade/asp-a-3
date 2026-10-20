require_relative "lib/book"
require_relative "lib/dvd"
require_relative "lib/cd"
require_relative "lib/library"

book = Book.new("Clean Code", "Robert Martin", 2008, "Programming", pages: 464)
dvd = DVD.new("Inception", "Christopher Nolan", 2010, "Science Fiction", duration: 148)
cd = CD.new("A Day at the Races", "Queen", 1976, "Rock", tracks: 10)

puts book.is_a?(LibraryItem)
puts dvd.director
puts cd.artist

begin
  book.title = "New title"
rescue NoMethodError => e
  puts e.message
end

begin
  LibraryItem.new("Item", "Someone", 2000, "Other")
rescue NotImplementedError => e
  puts e.message
end

begin
  Book.new("Book", "Someone", -5, "Other")
rescue ArgumentError => e
  puts e.message
end

class Magazine < LibraryItem
  attr_reader :issue

  def initialize(title, publisher, year, genre, issue:)
    super(title, publisher, year, genre)
    @issue = issue
  end

  def display_info
    super
    puts "  Issue: #{issue}"
  end

  private

  def creator_label
    "Publisher"
  end
end

library = Library.new
library.add_item(book)
library.add_item(dvd)
library.add_item(cd)
library.add_item(Magazine.new("Tech Monthly", "Tech Press", 2024, "Technology", issue: 7))
puts
library.display_all_items

puts library.remove_item("inception").title
p library.remove_item("Unknown")

class Poster
  def display_info
    puts "Poster"
  end
end

begin
  library.add_item(Poster.new)
rescue ArgumentError => e
  puts e.message
end