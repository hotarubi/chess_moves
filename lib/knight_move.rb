class KnightMove
  MAX_MOVES = 6.freeze
  VERTICAL_RANGE = ('a'..'h').freeze
  HORIZONTAL_RANGE = (1..8).freeze
  ORIENTATIONS = [1, 2, -1, -2].permutation(2).to_a.select{|a,b| a.abs != b.abs }.freeze

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

  def next_moves
    ORIENTATIONS.map { |v, h|
      [move_vertically(@current[0], v), move_horizontal(@current[1], h)]
    }.select { |move|
      square_valid?(move) && ! @path.include?(move)
    }
  end

  protected
  def square_valid?(square)
    VERTICAL_RANGE.cover?(square[0]) &&
      HORIZONTAL_RANGE.cover?(square[1])
  end

  def maxed?
    @path.size >= MAX_MOVES
  end

  def move_horizontal(h_num, step)
    h_num + step
  end

  def move_vertically(v_char, step)
    (v_char.ord + step).chr
  end
end
