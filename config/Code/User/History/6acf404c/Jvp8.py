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
    if player == """  REMPLIR   """:
        # Charger et dessiner l'image pour X
        x_img = pygame.image.load("""     REMPLIR       """)
        x_img = pygame.transform.scale(x_img, (WIDTH // 6, HEIGHT // 6))
        screen.blit(x_img, (x - WIDTH // 12, y - HEIGHT // 12))
    else:
        # Charger et dessiner l'image pour O
        o_img = pygame.image.load("""     REMPLIR       """)
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

# ETAPE 3 : IA aléatoire
# Faites jouer l'ia aléatoirement.
def ai_move():
    #Gère le mouvement de l'IA.
    empty_positions = """   REMPLIR  """(board)
    move = random.choice(empty_positions)
    """ REMPLIR """[move[0]][move[1]] = "O"
    draw_move(move[0], move[1], "O")

# ETAPE 2 : Ajouter un Écran de Fin de Partie
# Afficher un message de fin de partie et une option pour rejouer.
def display_end_message(message):
    screen.fill(WHITE)
    font = pygame.font.Font(None, 36)
    text = font.render(""" REMPLIR """, True, BLACK)
    text_rect = text.get_rect(center=(""" REMPLIR """))
    screen.blit(text, """ REMPLIR """)
    pygame.display.flip()
    pygame.time.wait(""" REMPLIR """)
    pygame.quit()
    sys.exit()

def main():
    """
    Fonction principale qui gère le déroulement du jeu.
    """
    draw_board()
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
            elif event.type == pygame.MOUSEBUTTONDOWN:
                if player_move(event.pos):
                    if check_win(board, "X"):
                        display_end_message("Vous avez gagné!")
                    elif not get_empty_positions(board):
                        display_end_message("C'est un match nul!")
                    else:
                        ai_move()
                        if check_win(board, "O"):
                            display_end_message("L'IA a gagné!")
                        elif not get_empty_positions(board):
                            display_end_message("C'est un match nul!")

if __name__ == "__main__":
    main()
