#!/bin/bash -x

echo "--------------------------Tic Tac Toe Game-----------------------"

COMPUTER="X";
PLAYER="O";
moveCount=0;
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

function findReplaceCom(){
	replace=$1;
	for (( i=0;i<=${#PlayingBoard[@]}; i++ ))
	do
		if [[ ${PlayingBoard[i]} == $replace ]]
		then
			PlayingBoard[$i]=$COMPUTER
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

function rowCanWin(){
	local row=0;
	for (( count=1; count<=3; count++ ))
	do
		row=$(( $row+1 ))
		if [[ ${PlayingBoard[$row]} == ${PlayingBoard[$row+1]} ]] || [[ ${PlayingBoard[$row+1]} == ${PlayingBoard[$row+2]} ]] || [[ ${PlayingBoard[$row+2]} == ${PlayingBoard[$row]} ]]
		then
			echo $row
			for (( i=$row; i<=$row+2; i++ ))
			do
				if [[ ${PlayingBoard[$i]} -ne O ]] || [[ ${PlayingBoard[$i]} -ne X ]]
				then
					echo "same variable found in row "$i
				fi
			done
		else
			row=$(( $row+2 ))
		fi
	done
}

function coloumnCanWin(){
	local coloumn=0;
	for (( count=1; count<=3; count++ ))
	do
		coloumn=$(( $coloumn+1 ))
		if [[ ${PlayingBoard[$coloumn]} == ${PlayingBoard[$coloumn+3]} ]] || [[ ${PlayingBoard[$coloumn+3]} == ${PlayingBoard[$coloumn+6]} ]] || [[ ${PlayingBoard[$coloumn+6]} == ${PlayingBoard[$coloumn]} ]] 
		then
			for (( i=1; i<=3; i++ ))
			do
				if [[ ${PlayingBoard[$coloumn]} -ne O ]] || [[ ${PlayingBoard[$coloumn]} -ne X ]]
				then
					echo "Same variable found in col "$coloumn
				fi
				coloumn=$(( $coloumn+3 ))
			done
		fi
	done
}

function diagonalCanWin(){
	local diagCount=1;
	local count=1;
	if [[ ${PlayingBoard[$diagCount]} == ${PlayingBoard[$diagCount+4]} ]] || [[ ${PlayingBoard[$diagCount+4]} == ${PlayingBoard[$diagCount+8]} ]] || [[ ${PlayingBoard[$diagCount+8]} == ${PlayingBoard[$diagCount]} ]]
	then
		echo "In diagonal"
		for (( i=1; i<=3; i++ ))
		do
			if [[ ${PlayingBoard[$diagCount]} -ne O ]] || [[ ${PlayingBoard[$diagCount]} -ne X ]]
			then
				echo "Same vertical found in diagonal " $diagCount
			fi
			diagCount=$(( $diagCount+4 ))
		done
	elif [[ ${PlayingBoard[$count+2]} == ${PlayingBoard[$count+4]} ]] || [[ ${PlayingBoard[$count+4]} == ${PlayingBoard[$count+6]} ]] || [[ ${PlayingBoard[$count+6]} == ${PlayingBoard[$count+2]} ]]
	then
		echo "Tn diagonal space"
		for (( i=1; i<=3; i++ ))
		do
			count=$(( $count+2 ))
			if [[ ${PlayingBoard[$count]} -ne O ]] || [[ ${PlayingBoard[$count]} -ne X ]]
			then
				echo "Same veriable found in diagonal "$count
			fi
		done
	fi
}

displayBoard
while [ true ]
do
	moveCount=$(( $moveCount+2 ))
	read -p "Enter your choice: " replace
	findReplace $replace
	displayBoard
	rowCanWin
	coloumnCanWin
	diagonalCanWin
	#assignAndReplace
	winner=$( winnerCheck )
	if [ $winner == true ]
	then
		echo "PLAYER WON"
		break;
	fi

	if [ $moveCount -gt 9 ]
	then 
		echo "TIE"
		break;
	fi

	# read -p "Enter your choice" replace
	# findReplaceCom $replace
	# displayBoard
	# #assignAndReplace
	# winner=$( winnerCheck )
	# if [ $winner == true ]
	# then
	# 	echo "COMPUTER WON"
	# 	break;
	# fi
done
