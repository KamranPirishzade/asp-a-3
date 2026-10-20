require_relative "library_item"

class Book < LibraryItem
  attr_reader :pages

  def initialize(title, author, year, genre, pages: nil)
    super(title, author, year, genre)
    @pages = pages
  end

  def display_info
    super
    puts "  Pages: #{pages}" if pages
  end
end