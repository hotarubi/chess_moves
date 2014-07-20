require File.expand_path("../../../lib/move", __FILE__)

describe Move do
  let(:move) { Move.new(path, target) }
  subject { move }

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
    subject { move.to_target }

    context 'when to a target in line' do
      let(:path) { [ ['a', 1] ] }
      let(:target) { ['a', 4] }
      let(:paths) do
        %w{ a1-a2-a3-a4 }
      end

      it { is_expected.to match_array(paths) }
    end

    context 'when to a target too far to reach' do
      let(:path) { [ ['a', 1] ] }
      let(:target) { ['a', 8] }

      it { is_expected.to be_empty }
    end

    context 'when to a target not in line' do
      let(:path) { [ ['a', 1] ] }
      let(:target) { ['b', 1] }

      it { is_expected.to be_empty }
    end
  end
end
