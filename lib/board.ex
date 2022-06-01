defmodule GameState do
  def new_game_state do
    %{
      :available_moves => [1, 2, 3, 4, 5, 6, 7, 8, 9],
      :win? => false,
      :player_1_moves => [],
      :player_2_moves => [],
      :player_1_mark => "X",
      :player_2_mark => "O"
    }
  end

  def won?(game_state) do
    game_state[:won?]
  end

  def set_player_1_mark(new_marker, game_status) do
    %{game_status | player_1_mark: new_marker}
  end

  def set_player_2_mark(new_marker, game_status) do
    %{game_status | player_2_mark: new_marker}
  end

  def check_for_win(game_state) do
    win_status = game_state.player_1_moves
    |> check_for_win_combos()
    %{game_state | win?: win_status}
  end

  def check_for_win_combos(moves_list) do
    win_combos = [
      [1,2,3],
      [4,5,6],
      [7,8,9]
    ]
    win_combo_list = Enum.map(win_combos, fn combo ->
      Enum.map(combo, fn num ->
        num in moves_list
      end)
    end)
    win_list = Enum.map(win_combo_list, fn combo ->
      Enum.all?(combo)
    end)
    Enum.any?(win_list)

  end
end
