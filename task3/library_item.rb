class LibraryItem
  attr_reader :title, :author, :year, :genre

  def initialize(title, author, year, genre)
    raise NotImplementedError, "LibraryItem is abstract" if instance_of?(LibraryItem)
    raise ArgumentError, "title cannot be empty" if title.to_s.strip.empty?
    raise ArgumentError, "year must be a positive integer" unless year.is_a?(Integer) && year.positive?

    @title = title
    @author = author
    @year = year
    @genre = genre
  end

  def display_info
    puts "#{self.class.name}: #{title}"
    puts "  #{creator_label}: #{author}"
    puts "  Year: #{year}"
    puts "  Genre: #{genre}"
  end

  private
  def creator_label
    "Author"
  end
end
