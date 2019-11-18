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

function displayBoard(){
	echo "-----------------------"
	i=0;
	for (( count=1; count<=3; count++ ))
	do
		i=$(( $i+1 ))
		echo "||  ${PlayingBoard[$i]}  ||  ${PlayingBoard[$i+1]}  ||  ${PlayingBoard[$i+2]}  ||"
		echo "-----------------------"
		i=$(( $i+2 ))
	done
}

function findReplace(){
	replace=$1;
	for (( i=0;i<=${#PlayingBoard[@]}; i++ ))
	do
		if [[ ${PlayingBoard[i]} == $replace ]]
		then
			PlayingBoard[$i]=$PLAYER
		fi
	done
}


displayBoard
while [ true ]
do
	read -p "Enter your choice" replace
	findReplace $replace
	displayBoard
done