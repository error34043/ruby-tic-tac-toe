require './main.rb'

describe Board do
  array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  subject(:board) { described_class.new(array) }

  describe "#victory?" do
    context 'when there are three X in line on the board' do
      before do
        board.instance_variable_set(:@box1, 'O')
        board.instance_variable_set(:@box2, 'O')
        board.instance_variable_set(:@box3, 'O')
      end

      it 'returns true' do
        expect(board.victory?).to eql(true)
      end
    end

    context 'when there are three X out of line on the board' do
      before do
        board.instance_variable_set(:@box1, 'O')
        board.instance_variable_set(:@box3, 'O')
        board.instance_variable_set(:@box9, 'O')
      end

      it 'returns false' do
        expect(board.victory?).to eql(false)
      end
    end
  end
end

describe Player do
  name = 'Test'
  token = 'W'
  array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  subject(:player) { described_class.new(name, token) }

  describe "#get_input" do
    context 'when move is possible' do
      before do
        choice = '3'
        allow(player).to receive(:gets) { choice }
      end

      it 'returns the move' do
        expect(player.get_input(array)).to eql(3)
      end
    end

    context 'when move is not possible' do
      before do
        array[3] = 'O'
        allow(player).to receive(:gets) do
          @counter ||= 0
          response = if @counter > 1
                       '4'
                     else
                       '3'
                     end
          @counter += 1
          response
        end
      end

      it 'loops until move is possible' do
        expect(player.get_input(array)).to eql(false)
        expect(player.get_input(array)).to eql(4)
      end
    end
  end
end

describe GamePlay do
  subject(:gameplay) { described_class.new }

  describe "#replay_choice" do
    context 'when yes || y' do
      before do
        allow(GamePlay).to receive(:gets) { 'yes' }
      end

      it 'returns true' do
        expect(GamePlay.replay_choice).to eql(true)
      end
    end

    context 'when input is no || n' do
      before do
        allow(GamePlay).to receive(:gets) { 'n' }
      end

      it 'returns false' do
        expect(GamePlay.replay_choice).to eql(false)
      end
    end

    context 'when input is invalid' do
      before do
        allow(GamePlay).to receive(:gets) do
          @counter ||= 0
          response = if @counter > 0
                       'y'
                     else
                       'pedcde'
                     end
          @counter += 1
          response
        end
      end

      it 'loops until input is valid' do
        expect(GamePlay.replay_choice).to eql('invalid')
        expect(GamePlay.replay_choice).to eql(true)
      end
    end
  end
end