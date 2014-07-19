class KnightMove
  VERTICAL_RANGE = ('a'..'h').freeze
  HORIZONTAL_RANGE = (1..8).freeze

  class OutOfChessboard < StandardError
    def initialize(square)
      super "(#{square.join}) is out of chessboard!"
    end
  end

  class InvalidTarget < StandardError
    def initialize(square)
      super "(#{square.join}) is a invalid target!"
    end
  end

  def initialize(path, target)
    @target = target
    @path = path
    @current = @path.last
    [@target, @current].each do |square|
      raise OutOfChessboard.new(square) unless square_valid?(square)
    end
    raise InvalidTarget.new(target) if @path.first == @target
  end

  def to_target
  end

  protected
  def square_valid?(square)
    VERTICAL_RANGE.cover?(square[0]) &&
      HORIZONTAL_RANGE.cover?(square[1])
  end
end
