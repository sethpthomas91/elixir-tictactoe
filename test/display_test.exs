defmodule Displaytest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "a game with no moves in the player spaces should display blank" do
    game = %{
      :available_moves => [1, 2, 3, 4, 5, 6, 7, 8, 9],
      :player_1_moves => [],
      :player_2_moves => [],
      :player_1_mark => "X",
      :player_2_mark => "O",
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

    clear_screen = "\e[H\e[J\n"
    row1 = " 1 | 2 | 3 \n"
    row2 = "---+---+---\n"
    row3 = " 4 | 5 | 6 \n"
    row4 = "---+---+---\n"
    row5 = " 7 | 8 | 9 \n"
    display = clear_screen <> row1 <> row2 <> row3 <> row4 <> row5
    assert capture_io(fn -> Display.display_board(game) end) == display
  end

  test "a game with one move in the player_1 spaces should display that move" do
    game = %{
      :board => %{
        1 => "X",
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

    clear_screen = "\e[H\e[J\n"
    row1 = " X | 2 | 3 \n"
    row2 = "---+---+---\n"
    row3 = " 4 | 5 | 6 \n"
    row4 = "---+---+---\n"
    row5 = " 7 | 8 | 9 \n"
    display = clear_screen <> row1 <> row2 <> row3 <> row4 <> row5
    assert capture_io(fn -> Display.display_board(game) end) == display
  end

  test "a game with moves in the player_1 spaces should display those moves" do
    game = %{
      :board => %{
        1 => "X",
        2 => "2",
        3 => "3",
        4 => "4",
        5 => "X",
        6 => "X",
        7 => "7",
        8 => "8",
        9 => "9"
      }
    }

    clear_screen = "\e[H\e[J\n"
    row1 = " X | 2 | 3 \n"
    row2 = "---+---+---\n"
    row3 = " 4 | X | X \n"
    row4 = "---+---+---\n"
    row5 = " 7 | 8 | 9 \n"
    display = clear_screen <> row1 <> row2 <> row3 <> row4 <> row5
    assert capture_io(fn -> Display.display_board(game) end) == display
  end

  test "a game with moves in the player_1 and player_2 spaces should display those moves" do
    game = %{
      :board => %{
        1 => "X",
        2 => "O",
        3 => "O",
        4 => "O",
        5 => "X",
        6 => "X",
        7 => "7",
        8 => "8",
        9 => "9"
      }
    }

    clear_screen = "\e[H\e[J\n"
    row1 = " X | O | O \n"
    row2 = "---+---+---\n"
    row3 = " O | X | X \n"
    row4 = "---+---+---\n"
    row5 = " 7 | 8 | 9 \n"
    display = clear_screen <> row1 <> row2 <> row3 <> row4 <> row5
    assert capture_io(fn -> Display.display_board(game) end) == display
  end
end
