import Display
import Game

defmodule Runner do
  def run do
    display_instructions()

    Game.new()
    |> determine_game_type()
    |> turn()
  end

  def turn(game), do: turn(game, get_available_moves(game))
  def turn(_game, []), do: display_draw()

  def turn(game, _available_moves) do
    display_board(game)

    game =
      determine_move_type(game)
      |> check_for_win()

    if win?(game) == true do
      display_win(game)
    else
      game = change_player(game)
      turn(game, get_available_moves(game))
    end
  end
end
