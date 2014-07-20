require File.expand_path("../move", __FILE__)

class KnightMove < Move
  ORIENTATIONS = [1, 2, -1, -2].permutation(2).to_a.
    select{|a,b| a.abs != b.abs }.freeze
end
