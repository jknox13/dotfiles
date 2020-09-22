#!/bin/sh
# maps inc/dec to percieved values
# percieved % = log( machine % )

# (assume (-x /usr/bin/xbacklight)
xbacklight=/usr/bin/xbacklight

# n steps from 0...100
N_STEPS=10

# define inc/dec operator
CURR=$(xbacklight)

if [ "$1" = "inc" ]; then
	# xbacklight tries, but there is a tolerance
	if [ "$(echo "$CURR>0.9" | bc)" -eq 1 ]; then
		# -l flag ensures float division
		xbacklight -set "$(echo "e(l($CURR) + 100/$N_STEPS)^2" | bc -l)"
	else
		# xbacklight set <1 => 0
		xbacklight -set 1
	fi
elif [ "$1" = "dec" ]; then
	# xbacklight floors @ 0
	if [ "$(echo "$CURR>0" | bc)" -eq 1 ]; then
		xbacklight -set "$(echo "e(l($CURR) - 100/$N_STEPS)^2" | bc -l)"
	fi
else
	# return current brightness (mimics xbacklight)
	echo "$CURR"
fi
