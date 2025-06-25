import pygame
import sys
import random

pygame.init()

WHITE = (255, 255, 255)
BLACK = (0, 0, 0)
RED = (255, 0, 0)
BLUE = (0, 0, 255)

SIZE = WIDTH, HEIGHT = 300, 300
LINE_WIDTH = 5

screen = pygame.display.set_mode(SIZE)
pygame.display.set_caption("Tic Tac Toe")

board = [[" " for _ in range(3)] for _ in range(3)]

def draw_board():
    """
    Draws the Tic Tac Toe board on the screen.
    """
    screen.fill(WHITE)
    for i in range(1, 3):
        pygame.draw.line(screen, BLACK, (0, HEIGHT / 3 * i), (WIDTH, HEIGHT / 3 * i), LINE_WIDTH)
        pygame.draw.line(screen, BLACK, (WIDTH / 3 * i, 0), (WIDTH / 3 * i, HEIGHT), LINE_WIDTH)
    pygame.display.flip()

def draw_move(row, col, player):
    """
    Draws the player's move (X or O) at the specified row and column.
    Loads and displays an image for X or O.
    """
    x = col * WIDTH / 3 + WIDTH / 6
    y = row * HEIGHT / 3 + HEIGHT / 6
    if player == "X":
        x_img = pygame.image.load("cross.png")
        x_img = pygame.transform.scale(x_img, (WIDTH // 6, HEIGHT // 6))
        screen.blit(x_img, (x - WIDTH // 12, y - HEIGHT // 12))
    else:
        o_img = pygame.image.load("circle.png")
        o_img = pygame.transform.scale(o_img, (WIDTH // 6, HEIGHT // 6))
        screen.blit(o_img, (x - WIDTH // 12, y - HEIGHT // 12))
    pygame.display.flip()

def check_win(board, player):
    """
    Checks if the specified player has won the game.
    Returns True if the player has won, otherwise False.
    """
    for row in board:
        if all(s == player for s in row):
            return True
    for col in range(3):
        if all(row[col] == player for row in board):
            return True
    if all(board[i][i] == player for i in range(3)) or all(board[i][2 - i] == player for i in range(3)):
        return True
    return False

def get_empty_positions(board):
    """
    Returns a list of all empty positions on the board.
    Each position is represented as a tuple (row, column).
    """
    return [(i, j) for i in range(3) for j in range(3) if board[i][j] == " "]

def player_move(pos):
    """
    Handles the player's move based on mouse click position.
    Returns True if the move is valid, otherwise False.
    """
    row, col = pos[1] // (HEIGHT // 3), pos[0] // (WIDTH // 3)
    if board[row][col] == " ":
        board[row][col] = "X"
        draw_move(row, col, "X")
        return True
    return False

def minimax(board, depth, is_maximizing):
    """
    Minimax algorithm for the AI to determine the best move.
    Returns a score based on the board evaluation.
    """
    if check_win(board, "O"):
        return 1
    if check_win(board, "X"):
        return -1
    if not get_empty_positions(board):
        return 0

    if is_maximizing:
        best_score = -float('inf')
        for (i, j) in get_empty_positions(board):
            board[i][j] = "O"
            score = minimax(board, depth + 1, False)
            board[i][j] = " "
            best_score = max(score, best_score)
        return best_score
    else:
        best_score = float('inf')
        for (i, j) in get_empty_positions(board):
            board[i][j] = "X"
            score = minimax(board, depth + 1, True)
            board[i][j] = " "
            best_score = min(score, best_score)
        return best_score

def ai_move():
    """
    Determines and executes the best move for the AI using the minimax algorithm.
    """
    best_score = -float('inf')
    best_move = None
    for (i, j) in get_empty_positions(board):
        board[i][j] = "O"
        score = minimax(board, 0, False)
        board[i][j] = " "
        if score > best_score:
            best_score = score
            best_move = (i, j)
    if best_move:
        board[best_move[0]][best_move[1]] = "O"
        draw_move(best_move[0], best_move[1], "O")

def display_end_message(message):
    """
    Displays an end-of-game message and exits after a short delay.
    """
    screen.fill(WHITE)
    font = pygame.font.Font(None, 36)
    text = font.render(message, True, BLACK)
    text_rect = text.get_rect(center=(WIDTH // 2, HEIGHT // 2))
    screen.blit(text, text_rect)
    pygame.display.flip()
    pygame.time.wait(2000)
    pygame.quit()
    sys.exit()

def choose_mode():
    """
    Displays a menu to choose the game mode.
    Returns "pvp" for player vs player, "pve" for player vs AI.
    """
    font = pygame.font.Font(None, 32)
    screen.fill(WHITE)
    text1 = font.render("A: Player vs Player", True, BLACK)
    text2 = font.render("B: Player vs AI", True, BLACK)
    screen.blit(text1, (40, 100))
    screen.blit(text2, (40, 150))
    pygame.display.flip()
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_a:
                    return "pvp"
                elif event.key == pygame.K_b:
                    return "pve"

def handle_player_click(event, current_player, mode):
    """
    Handles a player's click event, updates the board, and checks for a win or draw.
    Returns True if a move was made, otherwise False.
    """
    row, col = event.pos[1] // (HEIGHT // 3), event.pos[0] // (WIDTH // 3)
    if board[row][col] == " ":
        board[row][col] = current_player
        draw_move(row, col, current_player)
        if check_win(board, current_player):
            if mode == "pvp":
                display_end_message(f"Player {current_player} wins!")
            else:
                display_end_message("You win!" if current_player == "X" else "AI wins!")
        elif not get_empty_positions(board):
            display_end_message("It's a draw!")
        else:
            return True
    return False

def handle_ai_turn():
    """
    Handles the AI's turn, updates the board, and checks for a win or draw.
    """
    ai_move()
    if check_win(board, "O"):
        display_end_message("AI wins!")
    elif not get_empty_positions(board):
        display_end_message("It's a draw!")

def game_loop(mode):
    """
    Main game loop. Handles events and alternates turns between players or player and AI.
    """
    draw_board()
    current_player = "X"
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
            elif event.type == pygame.MOUSEBUTTONDOWN:
                if mode == "pvp":
                    if handle_player_click(event, current_player, mode):
                        current_player = "O" if current_player == "X" else "X"
                else:
                    if current_player == "X":
                        if handle_player_click(event, "X", mode):
                            handle_ai_turn()
                    current_player = "X"

def main():
    """
    Main function to run the Tic Tac Toe game.
    """
    mode = choose_mode()
    game_loop(mode)

if __name__ == "__main__":
    main()
    pygame.quit()
    sys.exit()