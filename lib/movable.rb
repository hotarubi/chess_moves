module Movable
  protected
  def move_horizontal(h_num, step)
    h_num + step
  end

  def move_vertically(v_char, step)
    (v_char.ord + step).chr
  end

  def reached?
    @current == @target
  end
end
