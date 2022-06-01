defmodule Board do
  def createBlankBoard do
    for y <- 1..3, x <- 1..3, into: [], do: {{x, y}, " "}
  end

  def win?(board) do
    false
  end
end
