import Display
import GameState
import StartMenu

defmodule Runner do
  def run do
    display_instructions()
    :timer.sleep(2000)

    game_state = new_game_state()
    turn(game_state)
  end

  def turn(game_state) do
    turn(game_state, game_state.available_moves)
  end

  def turn(_game_state, []) do
    IO.puts("draw")
  end

  def turn(game_state, _available_moves) do
    display_board(game_state)
    game_state = update_player_move(get_user_input(), game_state)
    
    turn(game_state, game_state.available_moves)
  end
end
