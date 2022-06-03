defmodule Display do
  def display_board(game_state) do
    board = %{
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

    board = place_markers_on_board(game_state.player_1_mark, game_state.player_1_moves, board)
    board = place_markers_on_board(game_state.player_2_mark, game_state.player_2_moves, board)
    clear_screen = "\e[H\e[J\n"
    row_1 = " #{board[1]} | #{board[2]} | #{board[3]} \n"
    row_2 = " #{board[4]} | #{board[5]} | #{board[6]} \n"
    row_3 = " #{board[7]} | #{board[8]} | #{board[9]} \n"
    horiz_divide = "---+---+---\n"
    display = clear_screen <> row_1 <> horiz_divide <> row_2 <> horiz_divide <> row_3
    IO.write(display)
  end

  def place_markers_on_board(_marker, [], board) do
    board
  end

  def place_markers_on_board(marker, moves, board) do
    [head | tail] = moves
    board = Map.replace(board, head, marker)
    place_markers_on_board(marker, tail, board)
  end
end
