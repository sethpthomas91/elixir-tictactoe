defmodule GameState do
  def new_game_state do
    %{
      :available_moves => [1, 2, 3, 4, 5, 6, 7, 8, 9],
      :win? => false,
      :player_1_moves => [],
      :player_2_moves => [],
      :player_1_mark => "X",
      :player_2_mark => "O",
      :player_1_type => :human,
      :player_2_type => :human,
      :current_player => 1
    }
  end

  def win?(game_state) do
    game_state[:win?]
  end

  def set_player_1_mark(new_marker, game_state) do
    %{game_state | player_1_mark: new_marker}
  end

  def set_player_2_mark(new_marker, game_state) do
    %{game_state | player_2_mark: new_marker}
  end

  def set_game_state_win(win_status, game_state) do
    %{game_state | win?: win_status}
  end

  def check_for_win(game_state) do
    move_list = determine_move_list(game_state)

    win_status =
      game_state[move_list]
      |> check_for_win_combos()

    set_game_state_win(win_status, game_state)
  end

  def check_for_win_combos(moves_list) do
    win_combos = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7]
    ]

    win_combo_list =
      Enum.map(win_combos, fn combo ->
        Enum.map(combo, fn num ->
          num in moves_list
        end)
      end)

    win_list =
      Enum.map(win_combo_list, fn combo ->
        Enum.all?(combo)
      end)

    Enum.any?(win_list)
  end

  def change_player(game_state) do
    %{game_state | current_player: if(get_current_player(game_state) == 1, do: 2, else: 1)}
  end

  def determine_move_list(game_state) do
    case get_current_player(game_state) do
      1 -> :player_1_moves
      2 -> :player_2_moves
    end
  end

  def handle_random_move(game_state) do
    move = get_random_move(game_state)
    player_move_list = determine_move_list(game_state)
    game_state = set_available_moves(move, game_state)
    update_player_move_list(game_state, player_move_list, move)
  end

  def handle_move(move, game_state) do
    player_move_list = determine_move_list(game_state)
    game_state = set_available_moves(move, game_state)
    update_player_move_list(game_state, player_move_list, move)
  end

  def set_available_moves(move, game_state) do
    %{game_state | available_moves: remove_move_from_available_moves(move, game_state)}
  end

  def get_available_moves(game_state) do
    game_state[:available_moves]
  end

  def update_player_move_list(game_state, player_move_list, move) do
    Map.replace(game_state, player_move_list, [move | game_state[player_move_list]])
  end

  def get_current_player(game_state) do
    game_state[:current_player]
  end

  def remove_move_from_available_moves(move, game_state) do
    List.delete(get_available_moves(game_state), move)
  end

  def get_random_move(game_state) do
    Enum.random(get_available_moves(game_state))
  end

  def set_player_2_type(type, game_state) do
    %{game_state | player_2_type: type}
  end

  def get_current_player_type(game_state) do
    case get_current_player(game_state) do
      1 -> game_state[:player_1_type]
      2 -> game_state[:player_2_type]
    end
  end

  def determine_move_type(game_state) do
    case get_current_player_type(game_state) do
      :human -> handle_move(get_user_move(game_state), game_state)
      :random -> handle_random_move(game_state)
    end
  end

  def get_user_move(game_state) do
    move = String.to_integer(String.trim(IO.gets("Please enter a move: ")))
    if (move in get_available_moves(game_state)) do
      move
    else
      IO.puts("Please enter a move that has not been entered.")
      get_user_move(game_state)
    end
  end
end
