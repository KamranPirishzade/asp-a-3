require_relative "library_item"

class Library
  def initialize
    @items = []
  end

  def add_item(item)
    raise ArgumentError, "only library items can be added" unless item.is_a?(LibraryItem)

    @items << item
  end

  def remove_item(title)
    item = @items.find { |i| i.title.casecmp?(title) }
    @items.delete(item) if item
  end

  def display_item(item)
    item.display_info
  end

  def display_all_items
    if @items.empty?
      puts "The library is empty."
      return
    end

    @items.each do |item|
      display_item(item)
      puts
    end
  end
end