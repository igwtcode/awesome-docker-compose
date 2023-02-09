# Redis

## Description

simple redis setup based on the official image (`redis:7.0.8`) with custom configuration, healthcheck, user-password authentication and gui client _(redis insight)_

## Features and Configuration

- custom configuration file (see `setup/redis.conf.template`)
- no default user
- healthcheck by user having only `ping` permission (see `setup/redis.conf.template`, `setup/healthcheck.sh.template` and `docker-compose.yml`)
- custom user having all permissions (with credentials defined in `.env` file or default values)
- multiple options to use redis gui client _(redis insight)_
- redis data would be persisted in `./data` directory (host) which is mounted to `/data` directory (container) and ignored by git

## Environment Variables

create `.env` file with the following content and update the values as per your requirements or use the default values.

```bash
REDIS_PORT=<port> # default 6379

REDIS_USER=<username> # default redisUser
REDIS_PASS=<password> # default redisUserPassword

REDIS_HEALTHCHECK_USER=<username> # default healthcheckUser
REDIS_HEALTHCHECK_PASS=<password> # default healthcheckUserPassword
```

> **hint:** to generate random strong passwords, use the following command:
>
> ```bash
> openssl rand -hex <length>
> ```

## Commands

```bash
# start containers in background
docker-compose up -d

# redis server logs (follow)
docker-compose logs -f redis

# redis insight logs (follow)
docker-compose logs -f redis-insight

# stop and remove containers
docker-compose down
```

## URL

redis server would be available at the following urls:

- from host machine

  ```bash
  redis://<REDIS_USER>:<REDIS_PASS>@localhost:<REDIS_PORT>

  # with default values
  redis://redisUser:redisUserPassword@localhost:6379
  ```

- inside docker network

  ```bash
  redis://<REDIS_USER>:<REDIS_PASS>@redis:<REDIS_PORT>

  # with default values
  redis://redisUser:redisUserPassword@redis:6379
  ```

## GUI Client

_redis insight_ is a GUI client for redis which can be used to connect to redis server and perform various operations.

- use `redis-insight` docker service in `docker-compose.yml` file

  > web interface would be available at [`http://localhost:8001`](http://localhost:8001)
  >
  > **NOTE:** to authenticate in web interface, _the docker service name for redis server in `docker-compose.yml` file_ (here: **`redis`**), should be used as host name instead of `localhost`

- download and install _redis insight_ desktop application from official website from [here](https://redislabs.com/redis-enterprise/redis-insight/) or [here](https://docs.redis.com/latest/ri/installing/install-redis-desktop/)

- install _redis insight_ desktop application via homebrew

```bash
brew install --cask redisinsight
```
