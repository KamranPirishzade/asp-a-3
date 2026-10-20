require_relative "library_item"

class DVD < LibraryItem
  attr_reader :duration

  def initialize(title, director, year, genre, duration: nil)
    super(title, director, year, genre)
    @duration = duration
  end

  def director
    author
  end

  def display_info
    super
    puts "  Duration: #{duration} min" if duration
  end

  private
  def creator_label
    "Director"
  end
end