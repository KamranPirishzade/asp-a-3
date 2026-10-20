require_relative "library_item"

class CD < LibraryItem
  attr_reader :tracks

  def initialize(title, artist, year, genre, tracks: nil)
    super(title, artist, year, genre)
    @tracks = tracks
  end

  def artist
    author
  end

  def display_info
    super
    puts "  Tracks: #{tracks}" if tracks
  end

  private
  def creator_label
    "Artist"
  end
end