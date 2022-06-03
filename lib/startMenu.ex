import GameState

defmodule StartMenu do

  def display_instructions do
    IO.puts("Welcome to Elixir Tic-Tac-Toe.")
    IO.puts("You are the first player.")
    IO.puts("When prompted by the computer, enter a number to play in a space.")
    IO.puts("The game will end when there is a win.")
  end

  def display_win(marker) do
    IO.puts("Player #{marker} has won!")
  end

  def determine_game_type(game_state) do
    message = "Do you want to play against a computer?\n 1=Yes 2=No "
    choice = String.to_integer(String.trim(IO.gets(message)))
    case choice do
      1 -> set_player_2_type(:random, game_state)
      2 -> game_state
    end
  end
end
