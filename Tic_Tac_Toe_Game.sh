#!/bin/bash -x

echo "--------------------------Tic Tac Toe Game-----------------------"

declare -a PlayingBoard
for (( counter=1; counter<=9; counter++ ))
do
	PlayingBoard[$counter]=$counter;
done

echo ${PlayingBoard[@]}
