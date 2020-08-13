require_relative '../lib/board.rb'
require_relative '../lib/user.rb'

describe Board do
  let(:board) { Board.new }
  let(:winner_row) { [4, 5, 6] }
  let(:winner_col) { [2, 5, 8] }
  let(:winner_diag) { [1, 5, 9] }
  let(:winner_op_diag) { [3, 5, 7] }
  let(:display_board) { ['1|2|3', '4|5|6', '7|8|9'] }

  describe '#initialize?' do
    it 'returns a new board as array 3x3 of accending numbers 1 to 9 as strings' do
      expect(board.b).to eql([%w[1 2 3], %w[4 5 6], %w[7 8 9]])
    end
    it 'returns the moves counter to 9' do
      expect(board.counter).to eql(9)
    end
    it 'returns an array of valid symbols' do
      expect(board.symbols).to eql(%w[X O])
    end

    describe 'turn?' do
      it 'returns true on empty loc and false on used ones' do
        expect(board.turn('X', 4)).to eql(true)
        expect(board.turn('X', 4)).not_to eql(true)
        expect(board.turn('O', 4)).not_to eql(true)
        expect(board.turn('O', 5)).to eql(true)
      end

      it 'returns false for location out of range' do
        expect(board.turn('X', 44)).not_to eql(true)
      end

      it 'returns false for invalid location' do
        expect(board.turn('X', 'a')).not_to eql(true)
      end

      it 'returns false  when move is has no location' do
        expect(board.turn('O', '')).not_to eql(true)
      end

      it 'user indicator alternates and counter decrements only on valid moves' do
        expect(board.counter).to eql(9)
        expect(board.current).to eql(0)
      end
      it 'return X symbol and counter 0 after for game winner_row_X do' do
        winner_row.each { |i| board.turn('X', i) }
        expect(board.counter).to eql(0)
        expect(board.symb).to eql('X')
      end

      it 'return O symbol and counter 0 after for game winner_column_O do' do
        winner_col.each { |i| board.turn('O', i) }
        expect(board.counter).to eql(0)
        expect(board.symb).to eql('O')
      end

      it 'return X symbol and counter 0 after for game winner_diag_X do' do
        winner_diag.each { |i| board.turn('X', i) }
        expect(board.counter).to eql(0)
        expect(board.symb).to eql('X')
      end

      it 'return O symbol and counter 0 after for game winner_oposite_diag_O' do
        winner_op_diag.each { |i| board.turn('O', i) }
        expect(board.counter).to eql(0)
        expect(board.symb).to eql('O')
      end

      it 'Checks if the board is played correctly' do
        expect(board.display).to eql(display_board)
      end
      it 'Checks if a row X-O-X indeed changes the board and if it doesnt return a winner' do
        board.turn('X', 1)
        board.turn('O', 2)
        board.turn('X', 3)
        expect(board.display).not_to eql(display_board)
        expect(board.counter).not_to eql(0)
      end
    end
  end
end
