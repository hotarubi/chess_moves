require File.expand_path("../movable", __FILE__)

class Move
  include Movable

  MAX_MOVES = 6.freeze
  VERTICAL_RANGE = ('a'..'h').freeze
  HORIZONTAL_RANGE = (1..8).freeze
  ORIENTATIONS = [ [0, 1] ].freeze

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
    return @path.map(&:join).join('-') if reached?
    return nil if maxed?
    next_moves.map {|next_move|
      self.class.new(@path + [ next_move ], @target).to_target
    }.compact.flatten.sort_by(&:length)
  end

  protected
  def next_moves
    self.class::ORIENTATIONS.map { |v, h|
      [move_vertically(@current[0], v), move_horizontal(@current[1], h)]
    }.select { |move|
      square_valid?(move) && ! @path.include?(move)
    }
  end

  def square_valid?(square)
    self.class::VERTICAL_RANGE.cover?(square[0]) &&
      self.class::HORIZONTAL_RANGE.cover?(square[1])
  end

  def maxed?
    @path.size >= MAX_MOVES
  end
end
