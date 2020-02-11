#!/bin/bash -x
echo "Welcome to THE SNAKE AND LADDER GAME for 2 players"

#CONSTANTS

NO_PLAY=0
SNAKE=1
LADDER=2
WINNING_POSITION=100

#DICTIONARY
declare -A recordPositionO
declare -A recordPositionT

#VARIABLES
playerPositionOne=0
playerPositionTwo=0
dieCounterO=0
dieCounterT=0

#FUNCTIONS

function rollDie()
{
   dieValue=$(( (RANDOM%6)+1 ))
   echo "Die value: $dieValue"
}

function playerMoveO()
{
	rollDie
    (( dieCounterO++ ))
    randomPlayerMove=$((RANDOM%3))
    echo "Move value generator: $randomPlayerMove"
	case $randomPlayerMove in
	   $NO_PLAY)
	      playerPositionOne=$playerPositionOne
	      ;;
	   $SNAKE)
	      playerPositionOne=$(($playerPositionOne-$dieValue))
	      ;;
	   $LADDER)
	      playerPositionOne=$(($playerPositionOne+$dieValue))
	      ;;
	esac
	constraintsO
    if (( $playerPositionOne == $WINNING_POSITION ))
    then
        echo "p1 won"
        return 1
    fi
}

function playerMoveT()
{
	rollDie
    (( dieCounterT++ ))
    randomPlayerMove=$((RANDOM%3))
    echo "Move value generator: $randomPlayerMove"
	case $randomPlayerMove in
	   $NO_PLAY)
	      playerPositionTwo=$playerPositionTwo
	      ;;
	   $SNAKE)
	      playerPositionTwo=$(($playerPositionTwo-$dieValue))
	      ;;
	   $LADDER)
	      playerPositionTwo=$(($playerPositionTwo+$dieValue))
	      ;;
	esac
	constraintsT
    if (( $playerPositionTwo == $WINNING_POSITION ))
    then
        echo "p2 won"
        return 2
    fi
}

function constraintsO()
{
	if (( $playerPositionOne < 0 ))
	then
		playerPositionOne=0
	fi
	
	if (( playerPositionOne > $WINNING_POSITION ))
	then
   playerPositionOne=$(( $playerPositionOne-$dieValue ))
	fi
	echo "p1" recordPositionO[$dieCounterO]=$playerPositionOne
    
}

function constraintsT()
{
	if (( $playerPositionTwo < 0 ))
	then
		playerPositionTwo=0
	fi
	
	if (( playerPositionTwo > $WINNING_POSITION ))
	then
   playerPositionTwo=$(( $playerPositionTwo-$dieValue ))
	fi
	echo "p2" recordPositionT[$dieCounterT]=$playerPositionTwo
    
}

#MAIN
while :
do
	playerMoveO
    if(( $? == 1 ))
    then
        break
    fi
    playerMoveT
    if(( $? == 2 ))
    then
        break
    fi
done
