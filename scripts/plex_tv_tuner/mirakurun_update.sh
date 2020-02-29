#!/bin/bash

#================================================
# Mirakurunのアップデート
#================================================

mirakurun stop
echo "npm update rivarun -g" | su - mirakurun
npm install mirakurun@latest -g --unsafe --production
mirakurun start
