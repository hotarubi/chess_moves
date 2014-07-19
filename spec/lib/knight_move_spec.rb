require File.expand_path("../../../lib/knight_move", __FILE__)

describe KnightMove do
  let(:knight_move) { KnightMove.new(path, target) }
  subject { knight_move }

  def reverse_for(paths)
    paths.map {|p| p.split('-').reverse!.join('-') }
  end

  context "when start equals target" do
    let(:path) { [ ['a', 1] ] }
    let(:target) { ['a', 1] }
    it "should raise InvalidTarget error" do
      expect{ subject.to_target }.to raise_error(KnightMove::InvalidTarget, "(a1) is a invalid target!")
    end
  end

  context "when start out of board" do
    let(:path) { [ ['a', 1] ] }
    let(:target) { ['a', 10] }
    it "should raise OutOfChessboard error" do
      expect{ subject.to_target }.to raise_error(KnightMove::OutOfChessboard, "(a10) is out of chessboard!")
    end
  end

  context "when target out of board" do
    let(:path) { [ ['t', 7] ] }
    let(:target) { ['a', 1] }
    it "should raise OutOfChessboard error" do
      expect{ subject.to_target }.to raise_error(KnightMove::OutOfChessboard, "(t7) is out of chessboard!")
    end
  end

  context "when inputs are valid" do
    subject { knight_move.to_target }

    context 'when to a close target' do
      let(:path) { [ ['a', 1] ] }
      let(:target) { ['c', 1] }
      let(:paths) do
        %w{ a1-b3-c1 a1-c2-d4-b3-c1 a1-b3-d4-e2-c1
          a1-c2-d4-e2-c1 a1-b3-c5-d3-c1 a1-c2-e1-d3-c1
          a1-c2-b4-d3-c1 a1-c2-b4-a2-c1}
      end

      it { is_expected.to match_array(paths) }
    end

    context 'when to a further target' do
      let(:path) { [ ['a', 1] ] }
      let(:target) { ['d', 4] }
      let(:paths) do
        %w{ a1-b3-d4 a1-c2-d4 a1-c2-e3-f5-d4 a1-c2-a3-b5-d4
          a1-c2-b4-c6-d4 a1-c2-e1-f3-d4 a1-b3-d2-f3-d4
          a1-b3-c1-e2-d4 a1-b3-a5-c6-d4 a1-b3-c5-e6-d4}
      end

      it { is_expected.to match_array(paths) }
    end

    context 'when to a very far target' do
      let(:path) { [ ['a', 1] ] }
      let(:target) { ['h', 2] }
      let(:paths) do
        %w{ a1-b3-d4-f3-h2 a1-b3-d2-f3-h2 a1-b3-d2-f1-h2
          a1-c2-d4-f3-h2 a1-c2-e3-f1-h2 a1-c2-e3-g4-h2
          a1-c2-e1-f3-h2}
      end

      it { is_expected.to match_array(paths) }
    end

    context 'when from center to corner' do
      let(:path) { [ ['e', 5] ] }
      let(:target) { ['h', 8] }
      let(:paths) do
        %w{ e5-f7-h8 e5-g6-h8 e5-d7-f8-g6-h8 e5-f3-g5-f7-h8
          e5-g4-h6-f7-h8 e5-f3-h4-g6-h8 e5-d3-f4-g6-h8
          e5-c6-d8-f7-h8 e5-c6-e7-g6-h8 e5-c4-d6-f7-h8}
      end

      it { is_expected.to match_array(paths) }
    end

    context 'when to a target too far' do
      let(:path) { [ ['a', 1] ] }
      let(:target) { ['h', 8] }

      it { is_expected.to be_empty }
    end

    context 'when compare forward and backward' do
      let(:path) { [ ['b', 6] ] }
      let(:target) { ['h', 7] }
      let(:backward) { KnightMove.new([target], path.first).to_target }

      it { is_expected.to match_array(reverse_for(backward)) }
    end
  end
end
