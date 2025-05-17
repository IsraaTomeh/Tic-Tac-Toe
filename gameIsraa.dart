import 'dart:io';

// Represents the 3x3 game board
List<String> gameBoard = [];

void main() {
  while (true) {
    resetBoard(); // Reset the board
    playGame(); // Start the game

    // Ask the user if they want to play again
    stdout.write('\nDo you want to play again? (y/n): ');
    String? response = stdin.readLineSync();
    if (response == null || response.toLowerCase() != 'y') {
      print('\nThanks for playing! 👋');
      break;
    }
  }
}

// Resets the board with numbers 1 to 9
void resetBoard() {
  gameBoard = List.generate(9, (index) => '${index + 1}');
}

// Handles the main game loop and logic
void playGame() {
  String currentPlayer = 'X';

  while (true) {
    displayBoard(); // Print current board
    int move = getPlayerMove(currentPlayer); // Get move from player

    applyMove(move, currentPlayer); // Apply the move

    if (checkWinner(currentPlayer)) {
      displayBoard();
      print('\n🎉 Player $currentPlayer wins the game!');
      break;
    } else if (isBoardFull()) {
      displayBoard();
      print("\nIt's a tie! 🤝");
      break;
    }

    currentPlayer = switchPlayer(currentPlayer); // Switch player
  }
}

// Displays the current state of the board
void displayBoard() {
  print('\nCurrent Board:\n');
  print(' ${gameBoard[0]} | ${gameBoard[1]} | ${gameBoard[2]} ');
  print('---+---+---');
  print(' ${gameBoard[3]} | ${gameBoard[4]} | ${gameBoard[5]} ');
  print('---+---+---');
  print(' ${gameBoard[6]} | ${gameBoard[7]} | ${gameBoard[8]} ');
}

// Prompts the player for a valid move input
int getPlayerMove(String player) {
  while (true) {
    stdout.write("\nPlayer $player's turn. Choose a cell (1 - 9): ");
    int? input = int.tryParse(stdin.readLineSync()!);

    if (input == null || input < 1 || input > 9 || !isValidMove(input - 1)) {
      print('❌ Invalid move. Please try again.');
    } else {
      return input - 1;
    }
  }
}

// Checks if the selected cell is valid (not already taken)
bool isValidMove(int index) {
  return gameBoard[index] != 'X' && gameBoard[index] != 'O';
}

// Applies the player's move to the board
void applyMove(int index, String symbol) {
  gameBoard[index] = symbol;
}

// Checks if the current player has won
bool checkWinner(String symbol) {
  List<List<int>> winningCombos = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var combo in winningCombos) {
    if (gameBoard[combo[0]] == symbol &&
        gameBoard[combo[1]] == symbol &&
        gameBoard[combo[2]] == symbol) {
      return true;
    }
  }
  return false;
}

// Checks if the board is full (draw)
bool isBoardFull() {
  return gameBoard.every((cell) => cell == 'X' || cell == 'O');
}

// Switches the player from X to O or O to X
String switchPlayer(String currentPlayer) {
  return currentPlayer == 'X' ? 'O' : 'X';
}
