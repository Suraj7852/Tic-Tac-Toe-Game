#!/bin/bash -x

echo "--------------------------Tic Tac Toe Game-----------------------"

declare -a PlayingBoard
for (( counter=1; counter<=9; counter++ ))
do
	PlayingBoard[$counter]=$counter;
done

computer="X";
player="O";
function TOSS(){
	toss=$((RANDOM%2))
	if [ $toss -eq 0 ]
	then
		choiceToPlayFirst=$computer
	else
		choiceToPlayFirst=$player
	fi	
	echo $choiceToPlayFirst
}

function displayBoard(){
	echo "-----------------------"
	echo "||  ${PlayingBoard[1]}  ||  ${PlayingBoard[2]}  ||  ${PlayingBoard[3]}  ||"
	echo "-----------------------"
	echo "||     ||     ||     ||"
	echo "||  ${PlayingBoard[4]}  ||  ${PlayingBoard[5]}  ||  ${PlayingBoard[6]}  ||"
	echo "-----------------------"
	echo "||     ||     ||     ||"
	echo "||  ${PlayingBoard[7]}  ||  ${PlayingBoard[8]}  ||  ${PlayingBoard[9]}  ||"
	echo "-----------------------"
}

function findReplace(){
	replace=$1;
	for (( i=1;i<=${#PlayingBoard[@]}; i++ ))
	do
		if [ ${PlayingBoard[i]} -eq $replace ]
		then
			PlayingBoard[$i]=$player
		fi
	done
	#echo "Not a valid input"
}
echo ${PlayingBoard[@]}
TOSS 
displayBoard
read -p "Enter your choice" replace
findReplace $replace
displayBoard