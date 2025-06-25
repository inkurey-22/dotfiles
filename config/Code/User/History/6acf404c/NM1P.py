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
    #Dessine le plateau de jeu.
    screen.fill(WHITE)
    for i in range(1, 3):
        pygame.draw.line(screen, BLACK, (0, HEIGHT / 3 * i), (WIDTH, HEIGHT / 3 * i), LINE_WIDTH)
        pygame.draw.line(screen, BLACK, (WIDTH / 3 * i, 0), (WIDTH / 3 * i, HEIGHT), LINE_WIDTH)
    pygame.display.flip()

# ETAPE 1 : Améliorer l'Interface Utilisateur
# Ajoutez des images pour les X et O.
def draw_move(row, col, player):
    x = col * WIDTH / 3 + WIDTH / 6
    y = row * HEIGHT / 3 + HEIGHT / 6
    if player == "X":
        # Charger et dessiner l'image pour X
        x_img = pygame.image.load("cross.png")
        x_img = pygame.transform.scale(x_img, (WIDTH // 6, HEIGHT // 6))
        screen.blit(x_img, (x - WIDTH // 12, y - HEIGHT // 12))
    else:
        # Charger et dessiner l'image pour O
        o_img = pygame.image.load("circle.png")
        o_img = pygame.transform.scale(o_img, (WIDTH // 6, HEIGHT // 6))
        screen.blit(o_img, (x - WIDTH // 12, y - HEIGHT // 12))
    pygame.display.flip()

def check_win(board, player):
    #Vérifie si un joueur a gagné.
    #:param board: Plateau de jeu.
    #:param player: 'X' ou 'O' selon le joueur à vérifier.
    #:return: True si le joueur a gagné, sinon False.
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
    #Retourne une liste de toutes les positions vides sur le plateau.
    #:param board: Plateau de jeu.
    #:return: Liste de tuples représentant les positions vides.
    return [(i, j) for i in range(3) for j in range(3) if board[i][j] == " "]

def player_move(pos):
    #Gère le mouvement du joueur.
    #:param pos: Position du clic de la souris.
    #:return: True si le mouvement est valide, sinon False.
    row, col = pos[1] // (HEIGHT // 3), pos[0] // (WIDTH // 3)
    if board[row][col] == " ":
        board[row][col] = "X"
        draw_move(row, col, "X")
        return True
    return False

# ETAPE 5 : Améliorer l'IA avec Alpha-Bêta Pruning

# ETAPE 4 : Remplacer IA aléatoire par l'algorithme minimax
def minimax(board, depth, is_maximizing):
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

# ETAPE 3 : IA aléatoire
# Faites jouer l'ia aléatoirement.
def ai_move():
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

# ETAPE 2 : Ajouter un Écran de Fin de Partie
# Afficher un message de fin de partie et une option pour rejouer.
def display_end_message(message):
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
    Affiche un menu pour choisir le mode de jeu.
    Retourne "pvp" pour joueur contre joueur, "pve" pour joueur contre IA.
    """
    font = pygame.font.Font(None, 32)
    screen.fill(WHITE)
    text1 = font.render("A: Joueur vs Joueur", True, BLACK)
    text2 = font.render("B: Joueur vs IA", True, BLACK)
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
    row, col = event.pos[1] // (HEIGHT // 3), event.pos[0] // (WIDTH // 3)
    if board[row][col] == " ":
        board[row][col] = current_player
        draw_move(row, col, current_player)
        if check_win(board, current_player):
            if mode == "pvp":
                display_end_message(f"Le joueur {current_player} a gagné!")
            else:
                display_end_message("Vous avez gagné!" if current_player == "X" else "L'IA a gagné!")
        elif not get_empty_positions(board):
            display_end_message("C'est un match nul!")
        else:
            return True  # Move was made
    return False  # Invalid move or game ended

def handle_ai_turn():
    ai_move()
    if check_win(board, "O"):
        display_end_message("L'IA a gagné!")
    elif not get_empty_positions(board):
        display_end_message("C'est un match nul!")

def game_loop(mode):
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
                else:  # pve
                    if current_player == "X":
                        if handle_player_click(event, "X", mode):
                            handle_ai_turn()
                    # Always return to player after AI
                    current_player = "X"

def main():
    """
    Fonction principale qui gère le déroulement du jeu.
    """
    mode = choose_mode()
    game_loop(mode)

if __name__ == "__main__":
    main()