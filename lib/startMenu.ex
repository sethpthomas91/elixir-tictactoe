defmodule StartMenu do
  def get_user_input do
    String.to_integer(String.trim(IO.gets("Please enter a number: ")))
  end

  def display_instructions do
    IO.puts("Welcome to Elixir Tic-Tac-Toe.")
    IO.puts("You are the first player.")
    IO.puts("When prompted by the computer, enter a number to play in a space.")
    IO.puts("The game will end when there is a win.")
  end

  def display_win(marker) do
    IO.puts("Player #{marker} has won!")
  end
end
