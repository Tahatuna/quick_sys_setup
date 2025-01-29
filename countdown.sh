#!/bin/bash

countdown_time=3

while [ $countdown_time -gt 0 ]; do
    echo "$countdown_time seconds remaining..."
    sleep 1
    countdown_time=$((countdown_time - 1))
done

echo -e "\aProcess starting...\n"