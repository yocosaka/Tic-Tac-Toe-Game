# spec/tic_tac_toe_spec.rb

require_relative '../lib/player.rb'
require_relative '../lib/board.rb'
require_relative '../lib/game.rb'

describe Player do
  let(:player1) { Player.new('Choco', '●') }
  let(:player2) { Player.new('Minto', '■') }
  let(:current_player) { player1 }

  describe '#initialize' do
    it 'initializes a player' do
      expect(player1.name).to eql('Choco')
    end
  end

  describe '#switched_player' do
    it 'returns opponent player' do
      expect(player1.switched_player(current_player, player2)).to eql(player2)
    end
  end
end

describe Board do
  let(:game_board) { Board.new }
  let(:player1) { Player.new('Choco', '●') }
  let(:player2) { Player.new('Minto', '■') }
  let(:current_player) { player1 }

  describe '#initialize' do
    it 'initializes a board' do
      expect(game_board.board).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end
  end

  describe '#draw?' do
    it 'returns true if the game is in tie' do
      game_board.board = %w[■ ● ■ ● ■ ● ● ■ ●]
      expect(game_board.draw?).to eql(true)
    end
  end

  describe '#win?' do
    it 'returns true if either player wins' do
      game_board.board = [1, 2, 3, '●', '●', '●', '7', '8', '9']
      expect(game_board.win?).to eql(true)
    end
  end

  describe '#update_board' do
    it 'updates game_board based on the position current player chooses' do
      expect(game_board.update_board(current_player, 3, player1, player2)).to eql('●')
    end
  end
end

describe Game do
  let(:game) { Game.new }
  let(:game_board) { Board.new }
  let(:player1) { Player.new('Choco', '●') }
  let(:player2) { Player.new('Minto', '■') }
  let(:current_player) { player1 }

  describe '#validated_name' do
    it 'returns uppercased name' do
      expect(game.validated_name('mint')).to eql('MINT')
    end
  end

  describe '#validated_position' do
    it 'returns position that player chooses' do
      expect(game.validated_position(5, game_board.board)).to eql(5)
    end
  end

  describe '#game_over?' do
    it 'returns false if the game is not in tie or neither player wins' do
      expect(game.game_over?(game_board, current_player)).to eql(false)
    end
  end
end
