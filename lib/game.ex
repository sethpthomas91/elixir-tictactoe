defmodule Game do
  @new_game %{
    :available_moves => [1, 2, 3, 4, 5, 6, 7, 8, 9],
    :win? => false,
    :player_1_moves => [],
    :player_2_moves => [],
    :player_1_mark => "X",
    :player_2_mark => "O",
    :current_player => 1,
    :player_1_type => :human,
    :player_2_type => :human,
    :board => %{
      1 => "1",
      2 => "2",
      3 => "3",
      4 => "4",
      5 => "5",
      6 => "6",
      7 => "7",
      8 => "8",
      9 => "9"
    }
  }

  def new, do: @new_game

  def win?(game), do: game[:win?]

  def assign_player_1_mark(marker, game), do: %{game | player_1_mark: marker}

  def assign_player_2_mark(marker, game), do: %{game | player_2_mark: marker}

  def assign_game_win(win?, game), do: %{game | win?: win?}

  def check_for_win(game) do
    win? =
      game[determine_move_list(game)]
      |> check_for_win_combos()

    assign_game_win(win?, game)
  end

  def check_for_win_combos(moves) do
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
          num in moves
        end)
      end)

    win_list =
      Enum.map(win_combo_list, fn combo ->
        Enum.all?(combo)
      end)

    Enum.any?(win_list)
  end

  def change_player(game) when game.current_player == 1, do: %{game | current_player: 2}
  def change_player(game), do: %{game | current_player: 1}

  def determine_move_list(game) when game.current_player == 1, do: :player_1_moves
  def determine_move_list(_game), do: :player_2_moves

  def handle_move(move, game) do
    player_move_list = determine_move_list(game)
    game = update_available_moves(move, game)
    game = update_player_move_list(game, player_move_list, move)
    place_marker(move, game)
  end

  def update_available_moves(move, game) do
    %{game | available_moves: List.delete(game.available_moves, move)}
  end

  def update_player_move_list(game, player_move_list, move) do
    Map.replace(game, player_move_list, [move | game[player_move_list]])
  end

  def get_current_player(game), do: game[:current_player]

  def get_available_moves(game), do: game[:available_moves]

  def remove_move_from_available_moves(move, game), do: List.delete(get_available_moves(game), move)

  def get_random_move(game), do: Enum.random(get_available_moves(game))

  def assign_player_2_type(type, game), do: %{game | player_2_type: type}

  def get_current_player_type(game) when game.current_player == 1, do: game.player_1_type
  def get_current_player_type(game), do: game.player_2_type

  def determine_move_type(game) do
    case get_current_player_type(game) do
      :human -> handle_move(Display.get_user_move(game), game)
      :random -> handle_random_move(game)
    end
  end

  def handle_random_move(game) do
    move = get_random_move(game)
    player_move_list = determine_move_list(game)
    game = update_available_moves(move, game)
    game = update_player_move_list(game, player_move_list, move)
    place_marker(move, game)
  end

  def place_marker(move, game) do
    update_board(Map.replace(game.board, move, get_marker(game)), game)
  end

  def get_marker(game) when game.current_player == 1, do: game.player_1_mark
  def get_marker(game), do: game.player_2_mark

  def update_board(board, game), do: %{game | board: board}
end
