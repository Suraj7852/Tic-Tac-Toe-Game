#!/bin/bash -x

echo "--------------------------Tic Tac Toe Game-----------------------"

COMPUTER="X";
PLAYER="O";
moveCount=0;
positionToReplace=0;
declare -a PlayingBoard

for (( counter=1; counter<=9; counter++ ))
do
	PlayingBoard[$counter]=$counter;
done

function computerTurn(){
	local comPlay=0;
	local moveCountByComputer=0;
	while [ $moveCountByComputer -ne 1 ]
	do
		comPlay=$(( RANDOM%9 + 1 ))
		if [[ ${PlayingBoard[$comPlay]} -ne $COMPUTER ]] || [[ ${PlayingBoard[$comPlay]} -ne $PLAYER ]]
		then
			findReplaceComputer $comPlay
			moveCountByComputer=$(( $moveCountByComputer+1 ))
			echo $moveCountByComputer $comPlay
		fi
	done
	displayBoard
}

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
	displayPosition=0;
	for (( count=1; count<=3; count++ ))
	do
		displayPosition=$(( $displayPosition+1 ))
		echo "||  ${PlayingBoard[$displayPosition]}  ||  ${PlayingBoard[$displayPosition+1]}  ||  ${PlayingBoard[$displayPosition+2]}  ||"
		echo "-----------------------"
		displayPosition=$(( $displayPosition+2 ))
	done
}

function findReplacePlayer(){
	replace=$1;
	for (( indexValue=1;indexValue<=${#PlayingBoard[@]}; indexValue++ ))
	do
		if [[ ${PlayingBoard[indexValue]} == $replace ]]
		then
			PlayingBoard[$indexValue]=$PLAYER
		fi
	done
}

function findReplaceComputer(){
	replace=$1;
	for (( indexValue=1;indexValue<=${#PlayingBoard[@]}; indexValue++ ))
	do
		if [[ ${PlayingBoard[indexValue]} == $replace ]]
		then
			PlayingBoard[$indexValue]=$COMPUTER
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
	local winnerRecieved=false;
	for (( count=1; count<=3; count++ ))
	do
		row=$(( $row+1 ))
		if [[ ${PlayingBoard[$row]} == ${PlayingBoard[$row+1]} ]] || [[ ${PlayingBoard[$row+1]} == ${PlayingBoard[$row+2]} ]] || [[ ${PlayingBoard[$row+2]} == ${PlayingBoard[$row]} ]]
		then
			for (( countInnerLoop=$row; countInnerLoop<=$row+2; countInnerLoop++ ))
			do
				if [[ ${PlayingBoard[$countInnerLoop]} -ne O ]] || [[ ${PlayingBoard[$countInnerLoop]} -ne X ]]
				then
					#echo "count val" $countInnerLoop
					positionToReplace=$countInnerLoop
				fi
			done
		else
			row=$(( $row+2 ))
		fi
	done
	echo $positionToReplace
}

function coloumnCanWin(){
	local coloumn=0;
	local winnerRecieved=false;
	for (( count=1; count<=3; count++ ))
	do
		coloumn=$(( $coloumn+1 ))
		if [[ ${PlayingBoard[$coloumn]} == ${PlayingBoard[$coloumn+3]} ]] || [[ ${PlayingBoard[$coloumn+3]} == ${PlayingBoard[$coloumn+6]} ]] || [[ ${PlayingBoard[$coloumn+6]} == ${PlayingBoard[$coloumn]} ]] 
		then
			for (( countInnerLoop=1; countInnerLoop<=3; countInnerLoop++ ))
			do
				if [[ ${PlayingBoard[$coloumn]} -ne O ]] || [[ ${PlayingBoard[$coloumn]} -ne X ]]
				then
					positionToReplace=$coloumn
				fi
				coloumn=$(( $coloumn+3 ))
			done
		fi
	done
	echo $positionToReplace
}

function diagonalCanWin(){
	local diagCount=1;
	local count=1;
	local winnerRecieved=false;
	if [[ ${PlayingBoard[$diagCount]} == ${PlayingBoard[$diagCount+4]} ]] || [[ ${PlayingBoard[$diagCount+4]} == ${PlayingBoard[$diagCount+8]} ]] || [[ ${PlayingBoard[$diagCount+8]} == ${PlayingBoard[$diagCount]} ]]
	then
		for (( countInnerLoop=1; countInnerLoop<=3; countInnerLoop++ ))
		do
			if [[ ${PlayingBoard[$diagCount]} -ne O ]] || [[ ${PlayingBoard[$diagCount]} -ne X ]]
			then
				positionToReplace=$diagCount
			fi
			diagCount=$(( $diagCount+4 ))
		done
	elif [[ ${PlayingBoard[$count+2]} == ${PlayingBoard[$count+4]} ]] || [[ ${PlayingBoard[$count+4]} == ${PlayingBoard[$count+6]} ]] || [[ ${PlayingBoard[$count+6]} == ${PlayingBoard[$count+2]} ]]
	then
		for (( countInnerLoop=1; countInnerLoop<=3; countInnerLoop++ ))
		do
			count=$(( $count+2 ))
			if [[ ${PlayingBoard[$count]} -ne O ]] || [[ ${PlayingBoard[$count]} -ne X ]]
			then
				positionToReplace=$count
			fi
		done
	fi
	echo $positionToReplace
}

function takingCorner(){
	local count=1;
	for (( countInnerLoop=1; countInnerLoop<=2; countInnerLoop++ ))
	do
		if [[ ${PlayingBoard[$count]} -ne $PLAYER ]] || [[ ${PlayingBoard[$count]} -ne $COMPUTER ]]
		then
			positionToReplay=$count
		elif [[ ${PlayingBoard[$count+2]} -ne $PLAYER ]] || [[ ${PlayingBoard[$count+2]} -ne $COMPUTER ]]
		then
			positionToReplay=$(( $count+2 ))
		fi
		count=$(( $count+6 ))
	done
	echo $positionToReplay
}

function takingCenter(){
	 if [[ ${PlayingBoard[5]} -ne $PLAYER ]] || [[ ${PlayingBoard[5]} -ne $COMPUTER ]]
         then
		positionToReplay=5;
         fi
	echo $positionToReplay
}

function possiblityForWinning(){
	row=$( rowCanWin)
	col=$( coloumnCanWin )
	diag=$( diagonalCanWin )
	corner=$( takingCorner )
	center=$( takingCenter )

	if [[ $row -gt 0 ]]
	then
		findReplaceComputer $row
        	displayBoard
		positionToReplace=0;
	elif [[ $col -gt 0 ]]
	then
		findReplaceComputer $col
        	displayBoard
		positionToReplace=0;
	elif [[ $diag -gt 0 ]]
	then
		findReplaceComputer $diag
        	displayBoard
		positionToReplace=0;
	elif [[ $corner -gt 0 ]]
	then
		findReplaceComputer $corner
		displayBoard
		positionToReplace=0;
	elif [[ $center -gt 0 ]]
	then
		findReplaceComputer $center
                displayBoard
                positionToReplace=0;
	else
		computerTurn
	fi
}

displayBoard
echo $toss
while [ true ]
do
	moveCount=$(( $moveCount+1 ))
	if [ $toss == $PLAYER ]
	then
		read -p "Enter your choice: " replace
		findReplacePlayer $replace
		winner=$( winnerCheck )
		if [ $winner == true ]
		then
			echo "PLAYER WON"
			break;
		fi
		toss=$COMPUTER;
	else
		possiblityForWinning
		winner=$( winnerCheck )
		if [ $winner == true ]
        then
               	echo "Computer WON"
               	break;
        fi
		toss=$PLAYER
	fi

	if [ $moveCount -gt 8 ]
    then
        echo "TIE"
        break;
    fi

done



