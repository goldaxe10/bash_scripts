#!/bin/bash
x=15
y=6

if (( $x % $y == 0 ))
then
	echo "true"
else
	echo "false"
fi

