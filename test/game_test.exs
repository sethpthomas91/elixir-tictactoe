defmodule GameStatetest do
  use ExUnit.Case

  test "test game_state with false as win state returns false" do
    game_state = %{
      :available_moves => [1, 2, 3, 4, 5, 6, 7, 8, 9],
      :win? => false
    }

    assert game_state.win? == false
  end

  test "new_game_state creates a game_state with all available moves" do
    assert GameState.new_game_state().available_moves == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "new_game_state creates a game_state with no moves for player one" do
    assert GameState.new_game_state().player_1_moves == []
  end

  test "new_game_state creates a game_state with no moves for player two" do
    assert GameState.new_game_state().player_2_moves == []
  end

  test "test new game state default marker for player 1 should be X" do
    assert GameState.new_game_state().player_1_mark == "X"
  end

  test "test new game state default marker for player 2 should be O" do
    assert GameState.new_game_state().player_2_mark == "O"
  end

  test "test set_player_1_mark should change the mark for player 1" do
    old_game_state = %{
      :player_1_mark => "X"
    }

    new_game_state = GameState.set_player_1_mark("Y", old_game_state)
    assert new_game_state.player_1_mark == "Y"
  end

  test "test set_player_2_mark should change the mark for player 1" do
    old_game_state = %{
      :player_2_mark => "O"
    }

    new_game_state = GameState.set_player_2_mark("2", old_game_state)
    assert new_game_state.player_2_mark == "2"
  end

  test "test that a non winning combination returns false" do
    player_moves = []
    assert GameState.check_for_win_combos(player_moves) == false
  end

  test "test that a winning combination on the top row returns true" do
    player_moves = [1, 2, 3]
    assert GameState.check_for_win_combos(player_moves) == true
  end

  test "test that a winning combination on the mid row returns true" do
    player_moves = [4, 5, 6]
    assert GameState.check_for_win_combos(player_moves) == true
  end

  test "test that a winning combination on the bottom row returns true" do
    player_moves = [7, 8, 9]
    assert GameState.check_for_win_combos(player_moves) == true
  end

  test "test that an empty game_state passed into a check for win function still has a false for win?" do
    old_game_state = %{
      :available_moves => [1, 2, 3, 4, 5, 6, 7, 8, 9],
      :player_1_moves => [],
      :player_2_moves => [],
      :win? => false
    }

    new_game_state = GameState.check_for_win(old_game_state)
    assert new_game_state.win? == false
  end

  test "test that a top row winning game_state for player_1 passed into a check for win function has a true for win?" do
    old_game_state = %{
      :player_1_moves => [3, 2, 1],
      :player_2_moves => [],
      :win? => false
    }

    new_game_state = GameState.check_for_win(old_game_state)
    assert new_game_state.win? == true
  end

  test "test that a diagonal winning game_state for player_1 passed into a check for win function has a true for win?" do
    old_game_state = %{
      :player_1_moves => [1, 9, 5],
      :win? => false
    }

    new_game_state = GameState.check_for_win(old_game_state)
    assert new_game_state.win? == true
  end

  test "test that a non winning game_state for player_1 passed into a check for win function has a false for win?" do
    old_game_state = %{
      :player_1_moves => [1, 3, 7],
      :win? => false
    }

    new_game_state = GameState.check_for_win(old_game_state)
    assert new_game_state.win? == false
  end

  test "a move for player 1 should update the game_state" do
    old_game_state = %{
      :available_moves => [1, 2, 3, 4, 5, 6, 7, 8, 9],
      :player_1_moves => [],
      :player_2_moves => [],
      :player_1_mark => "X",
      :player_2_mark => "O",
      :win? => false,
      :current_player => 1
    }

    expected_state = %{
      :available_moves => [2, 3, 4, 5, 6, 7, 8, 9],
      :player_1_moves => [1],
      :player_2_moves => [],
      :player_1_mark => "X",
      :player_2_mark => "O",
      :win? => false,
      :current_player => 2
    }

    assert GameState.update_player_move(1, old_game_state) == expected_state
  end

  test "a move for player 2 should update the game_state" do
    old_game_state = %{
      :available_moves => [2, 3, 4, 5, 6, 7, 8, 9],
      :player_1_moves => [1],
      :player_2_moves => [],
      :player_1_mark => "X",
      :player_2_mark => "O",
      :win? => false,
      :current_player => 2
    }

    expected_state = %{
      :available_moves => [2, 4, 5, 6, 7, 8, 9],
      :player_1_moves => [1],
      :player_2_moves => [3],
      :player_1_mark => "X",
      :player_2_mark => "O",
      :win? => false,
      :current_player => 1
    }

    assert GameState.update_player_move(3, old_game_state) == expected_state
  end
end
