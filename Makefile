CC = gcc
program: src/tictactoe.c
	$(CC) src/tictactoe.c -lpaho-mqtt3c -o tictactoe
