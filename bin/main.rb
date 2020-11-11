#!/usr/bin/env ruby
require_relative '../lib/player.rb'
require_relative '../lib/board.rb'
require_relative '../lib/game.rb'

game = Game.new
game.display_instruction
abort if game.player_answer == 'q'

loop do
  name1, name2 = game.players_name
  game_board = Board.new
  player1 = Player.new(name1, '●')
  player2 = Player.new(name2, '■')

  game.display_name_symbol(player1, player2)
  game.display_board(game_board.board)
  current_player = player1

  loop do
    print "#{current_player.symbol} #{current_player.name}: "
    print 'Which position do you want to take?: '
    position = gets.chomp.to_i
    position = game.validated_position(position, game_board.board)
    game_board.update_board(current_player, position, player1, player2)

    break if game.game_over?(game_board, current_player)

    game.display_board(game_board.board)
    current_player = player1.switched_player(current_player, player2)
  end
  break if game.player_answer == 'q'
end
