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

function rowWinnerCheck(){
	local row=0;
	local winnerRecieved=false;
	for (( count=1; count<=3; count++ ))
	do
		row=$(( $row+1 ))
		if [[ ${PlayingBoard[$row]} == ${PlayingBoard[$row+1]} ]] && [[ ${PlayingBoard[$row+1]} == ${PlayingBoard[$row+2]} ]]
		then
			winnerRecieved=true;
			break;
		else
			row=$(( $row+2 ))
		fi
	done
	echo $winnerRecieved
}

function coloumnWinnerCheck(){
	local coloumn=0;
	local winnerRecieved=false;
	for (( count=1; count<=3; count++ ))
	do
		coloumn=$(( $coloumn+1 ))
		if [[ ${PlayingBoard[$coloumn]} == ${PlayingBoard[$coloumn+3]} ]] && [[ ${PlayingBoard[$coloumn+3]} == ${PlayingBoard[$coloumn+6]} ]]
		then
			winnerRecieved=true;
			break;
		fi
	done
	echo $winnerRecieved
}

function diagonalWinnerCheck(){
	local winnerRecieved=false
	for (( count=1; count<=3; count++ ))
	do
		if [[ ${PlayingBoard[$count]} == ${PlayingBoard[$count+4]} ]] && [[ ${PlayingBoard[$count+4]} == ${PlayingBoard[$count+8]} ]]
		then
			winnerRecieved=true;
			break;
		elif [[ ${PlayingBoard[$count+2]} == ${PlayingBoard[$count+4]} ]] && [[ ${PlayingBoard[$count+4]} == ${PlayingBoard[$count+6]} ]]
		then
			winnerRecieved=true;
			break;
		fi
	done
	echo $winnerRecieved;
}

function winnerCheck() {
	local row=$( rowWinnerCheck )
	local coloumn=$( coloumnWinnerCheck )
	local diagonal=$( diagonalWinnerCheck )
	local winnerRecieved=false;
	if [[ $row == true ]] || [[ $coloumn == true ]] || [[ $diagonal == true ]]
	then
		winnerRecieved=true;
	fi
	echo $winnerRecieved;
}
displayBoard
while [ true ]
do
	read -p "Enter your choice" replace
	findReplace $replace
	displayBoard
	winner=$( winnerCheck )
	if [ $winner == true ]
	then
		break;
	fi
done
