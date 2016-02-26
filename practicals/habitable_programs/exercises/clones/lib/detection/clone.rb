module Detection
  class Clone
    include Comparable

    def initialize(original, other, fragment)
      @original, @other, @fragment = original, other, fragment
    end

    def size
      @fragment.size
    end

    def to_s
      "#{@other.file}:#{location(@other)} matches #{@original.file}:#{location(@original)}:\n" + @fragment.join
    end

    def <=>(other)
      size <=> other.size
    end

    private

    def location(source)
      start = starting_line_in(source)+1
      finish = start + @fragment.size-1
      "#{start}...#{finish}"
    end

    def starting_line_in(source)
      source.fragments(@fragment.size).find_index { |f| f == @fragment }
    end
  end
end
