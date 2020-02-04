#!/bin/bash -x
echo "Welcome to THE SNAKE AND LADDER GAME"

#CONSTANTS
NO_OF_PLAYERS=2 #Just a comment not a constant
NO_PLAY=0
SNAKE=1
LADDER=2
WINNING_POSITION=100

#DICTIONARY
declare -A recordPosition

#VARIABLES
playerPosition=0
dieCounter=0

#FUNCTIONS

function rollDie()
{
   dieValue=$(( (RANDOM%6)+1 ))
	((dieCounter++))
}

function playerMove()
{
	rollDie
	case $((RANDOM%3)) in
	   $NO_PLAY)
	      playerPosition=$playerPosition
	      ;;
	   $SNAKE)
	      playerPosition=$(($playerPosition-$dieValue))
	      ;;
	   $LADDER)
	      playerPosition=$(($playerPosition+$dieValue))
	      ;;
	esac
	constraints
}

function constraints()
{
	if (( $playerPosition < 0 ))
	then
		playerPosition=0
	fi
	
	if (( playerPosition > $WINNING_POSITION ))
	then
   	playerPosition=$(( $playerPosition-$dieValue ))
	fi
	echo recordPosition[$dieCounter]=$playerPosition
}

#MAIN
for ((i=0; i<$NO_OF_PLAYERS; i++ )) #Wrong loop
do
	until (( $playerPosition == $WINNING_POSITION ))
	do
		echo "Player: " $(($i+1))
		playerMove
	done
done
echo "Winner: " $i
