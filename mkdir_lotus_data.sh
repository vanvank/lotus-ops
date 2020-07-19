#!/bin/bash
echo -n "Enter user who will own /lotus_data: "
read user
if [ ! -d "/lotus_data" ]; then
  mkdir /lotus_data
fi
if [ ! -d "/lotus_data/tmp" ]; then
  mkdir /lotus_data/tmp
fi
chown -R $user:$user /lotus_data
