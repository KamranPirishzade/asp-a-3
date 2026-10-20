require_relative "lib/book"
require_relative "lib/dvd"
require_relative "lib/cd"
require_relative "lib/library"

book = Book.new("Concepts of Programming Languages", "Robert Sebesta", 2015, "Programming")
dvd = DVD.new("Inception", "Christopher Nolan", 2010, "Science Fiction")
cd = CD.new("A Day at the Races", "Queen", 1976, "Rock")

book.display_info
dvd.display_info
cd.display_info
puts

library = Library.new
library.add_item(book)
library.add_item(dvd)
library.add_item(cd)

library.display_all_items