##
## EPITECH PROJECT, 2022
## chocolatine (Workspace)
## File description:
## Makefile
##

SRC	=	test.c

SILENT	=	@

CC	=	$(SILENT)gcc

RM	=	$(SILENT)rm -f

CFLAGS	=	-Wall -Wextra

CPPFLAGS	=	-iquote ./include

OBJ	=	$(SRC.c=.o)

NAME	=	hello_world

all: $(NAME)

$(NAME): $(OBJ)
	$(CC) -o $(NAME) $(SRC) $(CFLAGS) $(CPPFLAGS)

clean:
	$(RM) $(OBJ)

fclean: clean
	$(RM) $(NAME)

re: fclean all

.PHONY: all clean fclean re
