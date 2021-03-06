defmodule Gametest do
  use ExUnit.Case

  test "test game with false as win state returns false" do
    game = %{
      :available_moves => [1, 2, 3, 4, 5, 6, 7, 8, 9],
      :win? => false
    }

    assert game.win? == false
  end

  test "new creates a game with all available moves" do
    assert Game.new().available_moves == [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  test "new creates a game with no moves for player one" do
    assert Game.new().player_1_moves == []
  end

  test "new creates a game with no moves for player two" do
    assert Game.new().player_2_moves == []
  end

  test "test new game state default marker for player 1 should be X" do
    assert Game.new().player_1_mark == "X"
  end

  test "test new game state default marker for player 2 should be O" do
    assert Game.new().player_2_mark == "O"
  end

  test "test assign_player_1_mark should change the mark for player 1" do
    old_game_state = %{
      :player_1_mark => "X"
    }

    new_game_state = Game.assign_player_1_mark("Y", old_game_state)
    assert new_game_state.player_1_mark == "Y"
  end

  test "test assign_player_2_mark should change the mark for player 1" do
    old_game_state = %{
      :player_2_mark => "O"
    }

    new_game_state = Game.assign_player_2_mark("2", old_game_state)
    assert new_game_state.player_2_mark == "2"
  end

  test "test that a non winning combination returns false" do
    player_moves = []
    assert Game.check_for_win_combos(player_moves) == false
  end

  test "test that a winning combination on the top row returns true" do
    player_moves = [1, 2, 3]
    assert Game.check_for_win_combos(player_moves) == true
  end

  test "test that a winning combination on the mid row returns true" do
    player_moves = [4, 5, 6]
    assert Game.check_for_win_combos(player_moves) == true
  end

  test "test that a winning combination on the bottom row returns true" do
    player_moves = [7, 8, 9]
    assert Game.check_for_win_combos(player_moves) == true
  end

  test "test that an empty game_state passed into a check for win function still has a false for win?" do
    old_game_state = %{
      :available_moves => [1, 2, 3, 4, 5, 6, 7, 8, 9],
      :player_1_moves => [],
      :player_2_moves => [],
      :win? => false,
      :current_player => 1
    }

    new_game_state = Game.check_for_win(old_game_state)
    assert new_game_state.win? == false
  end

  test "test that a top row winning game_state for player_1 passed into a check for win function has a true for win?" do
    old_game_state = %{
      :player_1_moves => [3, 2, 1],
      :player_2_moves => [],
      :win? => false,
      :current_player => 1
    }

    new_game_state = Game.check_for_win(old_game_state)
    assert new_game_state.win? == true
  end

  test "test that a diagonal winning game_state for player_1 passed into a check for win function has a true for win?" do
    old_game_state = %{
      :player_1_moves => [1, 9, 5],
      :win? => false,
      :current_player => 1
    }

    new_game_state = Game.check_for_win(old_game_state)
    assert new_game_state.win? == true
  end

  test "test that a non winning game_state for player_1 passed into a check for win function has a false for win?" do
    old_game_state = %{
      :player_1_moves => [1, 3, 7],
      :win? => false,
      :current_player => 1
    }

    new_game_state = Game.check_for_win(old_game_state)
    assert new_game_state.win? == false
  end

  test "a move for player 1 should update the player move list" do
    old_game_state = %{
      :available_moves => [1, 2, 3, 4, 5, 6, 7, 8, 9],
      :player_1_moves => [],
      :player_2_moves => [],
      :player_1_mark => "X",
      :player_2_mark => "O",
      :win? => false,
      :current_player => 1,
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

    assert Game.handle_move(1, old_game_state)[:player_1_moves] == [1]
  end

  test "a move for player 2 should update the game_state" do
    old_game_state = %{
      :available_moves => [2, 3, 4, 5, 6, 7, 8, 9],
      :player_1_moves => [1],
      :player_2_moves => [],
      :player_1_mark => "X",
      :player_2_mark => "O",
      :win? => false,
      :current_player => 2,
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

    assert Game.handle_move(3, old_game_state)[:player_2_moves] == [3]
  end

  test "change player should change the current player to the next player" do
    game_state = %{
      :current_player => 2
    }

    assert Game.change_player(game_state)[:current_player] == 1
  end

  test "change player should change the player 1 to player 2" do
    game_state = %{
      :current_player => 1
    }

    assert Game.change_player(game_state)[:current_player] == 2
  end

  test " handle random move should take one move from the available move list" do
    game_state = %{
      :available_moves => [1, 2, 3, 4, 5, 6, 7, 8, 9],
      :win? => false,
      :player_1_moves => [],
      :player_2_moves => [],
      :player_1_mark => "X",
      :player_2_mark => "O",
      :current_player => 1,
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

    assert length(Game.handle_random_move(game_state)[:available_moves]) == 8
  end

  test " handle random move should add one move to the current player's move list" do
    game_state = %{
      :available_moves => [1, 2, 3, 4, 5, 6, 7, 8, 9],
      :win? => false,
      :player_1_moves => [],
      :player_2_moves => [],
      :player_1_mark => "X",
      :player_2_mark => "O",
      :current_player => 1,
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

    assert length(Game.handle_random_move(game_state)[:player_1_moves]) == 1
  end

  test "assign_player_2_type with random should set player 2 to random" do
    game_state = %{
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

    assert Game.assign_player_2_type(:random, game_state)[:player_2_type] == :random
  end

  test "get current player type should return the current player type for human in player 1" do
    game_state = %{
      :player_1_type => :human,
      :player_2_type => :human,
      :current_player => 1
    }

    assert Game.get_current_player_type(game_state) == :human
  end

  test "get current player type should return the current player type for random for player 2" do
    game_state = %{
      :player_1_type => :human,
      :player_2_type => :random,
      :current_player => 2
    }

    assert Game.get_current_player_type(game_state) == :random
  end
end
