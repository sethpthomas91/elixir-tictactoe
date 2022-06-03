import Display
import GameState
import StartMenu

defmodule Runner do
  def run do
    IO.write("\e[H\e[J\n")
    display_instructions()
    :timer.sleep(2000)

    new_game_state()
    |>determine_game_type()
    |>turn()
  end

  def turn(game_state) do
    turn(game_state, game_state.available_moves)
  end

  def turn(game_state, []) do
    display_board(game_state)
    IO.puts("Game Draw")
  end

  def turn(game_state, _available_moves) do
    display_board(game_state)
    game_state = determine_move_type(game_state)
    game_state = check_for_win(game_state)

    if win?(game_state) == true do
      display_board(game_state)
      case get_current_player(game_state) do
        1 -> display_win(game_state.player_1_mark)
        2 -> display_win(game_state.player_2_mark)
      end
    else
      game_state = change_player(game_state)
      turn(game_state, game_state.available_moves)
    end
  end
end
