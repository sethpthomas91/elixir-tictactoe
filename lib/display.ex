defmodule Display do

  def display_board(game) do
    board = game.board
    clear_screen = "\e[H\e[J\n"
    row_1 = " #{board[1]} | #{board[2]} | #{board[3]} \n"
    row_2 = " #{board[4]} | #{board[5]} | #{board[6]} \n"
    row_3 = " #{board[7]} | #{board[8]} | #{board[9]} \n"
    horiz_divide = "---+---+---\n"

    (clear_screen <> row_1 <> horiz_divide <> row_2 <> horiz_divide <> row_3)
    |> IO.write()
  end

  def get_user_input do
    String.to_integer(String.trim(IO.gets("Please enter a number: ")))
  end

  def display_instructions do
    IO.write("\e[H\e[J\n")
    IO.puts("Welcome to Elixir Tic-Tac-Toe.")
    IO.puts("You are the first player.")
    IO.puts("When prompted by the computer, enter a number to play in a space.")
    IO.puts("The game will end when there is a win.")
    :timer.sleep(2000)
  end

  def display_win(game) do
    marker = if game.current_player == 1, do: game.player_1_mark, else: game.player_2_mark
    IO.write("\e[H\e[J\n")
    display_board(game)
    IO.puts("Player #{marker} has won!")
  end

  def display_draw, do: IO.puts("Game Draw")

  def determine_game_type(game) do
    message = "Do you want to play against a computer?\n 1=Yes 2=No "
    choice = get_user_input(message)

    case choice do
      1 -> Game.assign_player_2_type(:random, game)
      2 -> game
    end
  end

  def get_user_input(message) do
    String.to_integer(String.trim(IO.gets(message)))
  end

  def get_user_move(game) do
    message = "Please enter a move:"
    move = get_user_input(message)

    if move in Game.get_available_moves(game) do
      move
    else
      IO.puts("Please enter a move that has not been entered.")
      get_user_move(game)
    end
  end
end
