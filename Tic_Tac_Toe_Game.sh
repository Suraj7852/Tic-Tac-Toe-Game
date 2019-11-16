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

echo ${PlayingBoard[@]}
echo $( TOSS )
