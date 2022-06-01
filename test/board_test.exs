defmodule Boardtest do
  use ExUnit.Case

  test "test generates blank board" do
    blankBoard = [
      {{1,1}, " "},
      {{2,1}, " "},
      {{3,1}, " "},
      {{1,2}, " "},
      {{2,2}, " "},
      {{3,2}, " "},
      {{1,3}, " "},
      {{2,3}, " "},
      {{3,3}, " "}
    ]
    assert Board.createBlankBoard == blankBoard
  end

  test "test returns false if there is not a winning condition" do
    board = [
      {{1,1}, " "},
      {{2,1}, " "},
      {{3,1}, " "},
      {{1,2}, " "},
      {{2,2}, " "},
      {{3,2}, " "},
      {{1,3}, " "},
      {{2,3}, " "},
      {{3,3}, " "}
    ]
    assert Board.win?(board) == false
  end

end
