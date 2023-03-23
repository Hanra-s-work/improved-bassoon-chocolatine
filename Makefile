##
## EPITECH PROJECT, 2022
## chocolatine (Workspace)
## File description:
## Makefile
##

SRC	=	./src/my_putstr.c	\
		./src/my_strlen.c	\

MAIN	=	test.c

SILENT	=

CC	=	$(SILENT)gcc

RM	=	$(SILENT)rm -f

LDFLAGS	=

LDLIBS	=

CFLAGS	=	-Wall -Wextra

CPPFLAGS	=	-iquote ./include

OBJ	=	$(SRC:.c=.o)

NAME	=	hello_world

TEST_SRC	=	./tests/test_my_strlen.c	\
				./tests/test_my_putstr.c	\
				./tests/test_will_fail.c	\

TEST_OBJ	=	$(TEST_SRC:.c=.o)

TEST_TARGET	=	unit_test

all: $(NAME)

$(NAME): $(OBJ)
	$(CC) -o $(NAME) $(MAIN) $(SRC) $(CFLAGS) $(CPPFLAGS)

clean:
	$(RM) $(OBJ)

clean_tests:
	$(RM) *.gcda
	$(RM) *.gcno
	$(RM) $(TEST_OBJ)
	cd tests && \
	$(RM) *.gcda && \
	$(RM) *.gcno && \
	cd ..
	cd src && \
	$(RM) *.gcda && \
	$(RM) *.gcno && \
	cd ..

fclean: clean clean_tests
	$(RM) $(NAME)
	$(RM) $(TEST_TARGET)

tests_run: CFLAGS += --coverage
tests_run: LDFLAGS += -lcriterion
tests_run: clean_tests
tests_run: $(TEST_OBJ) $(OBJ)
	$(CC) -o $(TEST_TARGET) $(CPPFLAGS) $(CFLAGS) $(TEST_SRC) $(SRC) $(LDFLAGS)
	./$(TEST_TARGET)

re: fclean all

.PHONY: all clean fclean re tests_run clean_tests
