#!/bin/bash -x

echo "--------------------------Tic Tac Toe Game-----------------------"

COMPUTER="X";
PLAYER="O";
declare -a PlayingBoard

for (( counter=1; counter<=9; counter++ ))
do
	PlayingBoard[$counter]=$counter;
done

function TOSS(){
	toss=$((RANDOM%2))
	if [ $toss -eq 0 ]
	then
		choiceToPlayFirst=$COMPUTER
	else
		choiceToPlayFirst=$PLAYER
	fi	
	echo $choiceToPlayFirst
}

echo ${PlayingBoard[@]}
toss=$( TOSS )

while [ true ]
do
	if [ $toss == $PLAYER ]
	then
		read -p "Enter your choice" replace
		findReplace $replace
		displayBoard
		toss=$COMPUTER
	else
		toss=$PLAYER
	fi
done