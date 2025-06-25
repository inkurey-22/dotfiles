##
## EPITECH PROJECT, 2024
## c_proj_template
## File description:
## Makefile
##

# Colors
BOLD=\033[1m
RED=\033[0;31m
GREEN=\033[0;32m
YELLOW=\033[0;33m
BLUE=\033[0;34m
NC=\033[0m # No Color

.PHONY: all clean fclean re debug lib lib_clean lib_fclean

# Directories
LIB_DIR = lib
SRC_DIR = src
INCLUDE_DIR = include
OBJ_DIR = obj
LIB_OBJ_DIR = $(LIB_DIR)/obj

# Files
LIB = $(LIB_DIR)/libmy.a
SRC = $(SRC_DIR)/main.c

# Library sources and objects
LIB_SRC =	$(LIB_DIR)/io/my_putnbr.c                   \
            $(LIB_DIR)/io/my_putstr.c                   \
            $(LIB_DIR)/io/my_puterr.c                   \
            $(LIB_DIR)/io/my_putchar.c                  \
            $(LIB_DIR)/io/my_show_word_array.c          \
            $(LIB_DIR)/my_printf/utilities.c            \
            $(LIB_DIR)/my_printf/my_printf.c            \
            $(LIB_DIR)/my_printf/printf_putnbr.c        \
            $(LIB_DIR)/my_printf/printf_putstr.c        \
            $(LIB_DIR)/my_printf/printf_putchar.c       \
            $(LIB_DIR)/numbers/my_isneg.c               \
            $(LIB_DIR)/numbers/my_getnbr.c              \
            $(LIB_DIR)/numbers/my_is_prime.c            \
            $(LIB_DIR)/numbers/my_find_prime_sup.c      \
            $(LIB_DIR)/numbers/my_compute_power_rec.c   \
            $(LIB_DIR)/numbers/my_compute_square_root.c \
            $(LIB_DIR)/strings/my_strcat.c              \
            $(LIB_DIR)/strings/my_strcmp.c              \
            $(LIB_DIR)/strings/my_strcpy.c              \
            $(LIB_DIR)/strings/my_strdup.c              \
            $(LIB_DIR)/strings/my_strlen.c              \
            $(LIB_DIR)/strings/my_strstr.c              \
            $(LIB_DIR)/strings/my_strchr.c              \
            $(LIB_DIR)/strings/my_revstr.c              \
            $(LIB_DIR)/strings/my_strupcase.c           \
            $(LIB_DIR)/strings/split_string.c           \
            $(LIB_DIR)/strings/my_str_isnum.c           \
            $(LIB_DIR)/strings/my_strlowcase.c          \
            $(LIB_DIR)/strings/my_str_isupper.c         \
            $(LIB_DIR)/strings/my_str_isalpha.c         \
            $(LIB_DIR)/strings/my_str_islower.c         \
            $(LIB_DIR)/strings/my_strarray_len.c        \
            $(LIB_DIR)/strings/my_strcapitalize.c       \
            $(LIB_DIR)/strings/my_str_isprintable.c     \
            $(LIB_DIR)/strings/my_free_word_array.c     \
            $(LIB_DIR)/lists/size.c                     \
            $(LIB_DIR)/lists/sort.c                     \
            $(LIB_DIR)/lists/find.c                     \
            $(LIB_DIR)/lists/append.c                   \
            $(LIB_DIR)/lists/create.c                   \
            $(LIB_DIR)/lists/remove.c                   \
            $(LIB_DIR)/lists/free_list.c                \
            $(LIB_DIR)/lists/add_to_top.c

LIB_OBJ = $(LIB_SRC:$(LIB_DIR)/%.c=$(LIB_OBJ_DIR)/%.o)

OBJ = $(SRC:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)

NAME = proj

# Calculate total steps for progress
TOTAL_STEPS = $(shell echo "$$(($(words $(LIB_OBJ)) + $(words $(OBJ)) + 2))")
CURRENT_STEP = 0

# Compiler
CC = gcc
AR = ar rc
CFLAGS = -I$(INCLUDE_DIR) -Wall -Wextra
LDFLAGS = -L$(LIB_DIR) -lmy

PROGRESS_FILE = .progress

# Calculate total steps for progress
TOTAL_STEPS = $(shell echo "$$(($(words $(LIB_OBJ)) + $(words $(OBJ)) + 3))")

define update_progress
    @echo $$(( $$(cat $(PROGRESS_FILE) 2>/dev/null || echo 0) + 1 )) > $(PROGRESS_FILE)
endef

define show_progress
	@CURRENT_STEP=$$(cat $(PROGRESS_FILE)); \
	PERCENT=$$(( CURRENT_STEP * 100 / $(TOTAL_STEPS) )); \
	printf "$(BOLD)$(BLUE)[%3s%%]$(NC) " "$$PERCENT"
endef

all: $(NAME)

$(NAME): $(LIB) $(OBJ)
	$(update_progress)
	$(show_progress)
	@printf "$(GREEN)$(BOLD)Linking C executable$(NC)$(YELLOW)$(BOLD)%s$(NC)\n" "$(NAME)"
	@$(CC) -o $(NAME) $(OBJ) $(CFLAGS) $(LDFLAGS)
	$(update_progress)
	$(show_progress)
	@printf "$(RED)$(BOLD)Built target$(NC)\n"

# Build the library
$(LIB): $(LIB_OBJ)
	$(update_progress)
	$(show_progress)
	@$(AR) $(LIB) $(LIB_OBJ)
	@printf "$(GREEN)$(BOLD)Linking C static library$(NC)$(YELLOW)$(BOLD)%s$(NC)\n" "$(LIB)"

$(LIB_OBJ_DIR)/%.o: $(LIB_DIR)/%.c
	@mkdir -p $(@D)
	$(update_progress)
	$(show_progress)
	@printf "$(GREEN)Building C object$(NC)$(YELLOW)%s$(NC)\n" "$@"
	@$(CC) -c $< -o $@ $(CFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(update_progress)
	$(show_progress)
	@printf "$(GREEN)Building C object$(NC)$(YELLOW)%s$(NC)\n" "$@"
	@$(CC) -c $< -o $@ $(CFLAGS)

clean: lib_clean
	rm -rf $(OBJ_DIR)
	@rm -f $(PROGRESS_FILE)

lib_clean:
	rm -rf $(LIB_OBJ_DIR)

fclean: clean lib_fclean
	rm -f $(NAME)
	rm -f $(PROGRESS_FILE)

lib_fclean:
	rm -f $(LIB)

re: fclean all

debug: CFLAGS += -g
debug: re