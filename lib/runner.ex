import Display
import GameData
import StartMenu

defmodule Runner do
  def run do
    IO.write("\e[H\e[J\n")
    display_instructions()
    :timer.sleep(2000)

    game_data = GameData.new
    turn(game_data)
  end

  def turn(game_data) do
    turn(game_data, get_available_moves(game_data))
  end

  def turn(_game_data, []) do
    IO.puts("Game Draw")
  end

  def turn(game_data, _available_moves) do
    display_board(game_data)
    game_data = handle_move(get_user_input(), game_data)
    game_data = check_for_win(game_data)

    if win?(game_data) == true do
      case get_current_player(game_data) do
        1 -> display_win(game_data.player_1_mark)
        2 -> display_win(game_data.player_2_mark)
      end
    else
      game_data = change_player(game_data)
      turn(game_data, get_available_moves(game_data))
    end
  end
end
