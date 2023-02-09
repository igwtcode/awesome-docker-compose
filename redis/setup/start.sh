#!/bin/bash

# setup directory
SETUP_DIR=/setup

# healthcheck template script path
HEALTHCHECK_SCRIPT_TEMPLATE=$SETUP_DIR/healthcheck.sh.template

# healthcheck script path
HEALTHCHECK_SCRIPT=/healthcheck.sh

# redis template config file path
REDIS_CONF_TEMPLATE=$SETUP_DIR/redis.conf.template

# redis config file path
REDIS_CONF=/redis.conf

# redis port
REDIS_PORT="${REDIS_PORT:=6379}"

# redis healthcheck user credentials
REDIS_HEALTHCHECK_USER="${REDIS_HEALTHCHECK_USER:=healthcheckUser}"
REDIS_HEALTHCHECK_PASS="${REDIS_HEALTHCHECK_PASS:=healthcheckUserPassword}"

# redis user credentials
REDIS_USER="${REDIS_USER:=redisUser}"
REDIS_PASS="${REDIS_PASS:=redisUserPassword}"

# array of variables to replace in redis config file and healthcheck script
declare -a arr=("REDIS_PORT" "REDIS_HEALTHCHECK_USER" "REDIS_HEALTHCHECK_PASS" "REDIS_USER" "REDIS_PASS")

# copy template config file to redis config file path
cp $REDIS_CONF_TEMPLATE $REDIS_CONF

# copy template healthcheck script to healthcheck script path
cp $HEALTHCHECK_SCRIPT_TEMPLATE $HEALTHCHECK_SCRIPT

# make healthcheck script executable
chmod +x $HEALTHCHECK_SCRIPT

for i in "${arr[@]}"; do
  # replace all occurrences of $i with ${!i} in redis config file and healthcheck script
  sed -i "s/$i/${!i}/" $REDIS_CONF
  sed -i "s/$i/${!i}/" $HEALTHCHECK_SCRIPT
done

# start redis server with custom config file
redis-server $REDIS_CONF
