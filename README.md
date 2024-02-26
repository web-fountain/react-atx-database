React ATX Database
==========

Database for the React ATX Meetup

---

* [Getting Started](#getting-started)
  - [Podman]
    - [Build Image](#build-image)
    - [Persist Data](#persist-data)
    - [Run Container](#run-container)
    - [Sanity Checks](#sanity-checks)
  - [Docker](#docker)
    - [Build Image](#build-image)
    - [Persist Data](#persist-data)
    - [Run Container](#run-container)
    - [Sanity Checks](#sanity-checks)
* [Initialize and Seed the database](#initialize-and-seed-the-database)
* [Helpful Commands](#helpful-commands)

---

# Getting Started

## Podman

The following assumes you have installed and have running [Podman] and/or [Podman Desktop].

> NOTE: If you are using Docker substitute the command `podman` for `docker` below

### Build Image

We will be using the `Containerfile` to build our image. Run the following:

```
→ podman build \
  -t localhost/postgres:16.2-alpine3.19 \
  --build-arg now=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
  --build-arg POSTGRES_DB=reactatx \
  --build-arg POSTGRES_USER=dev \
  --build-arg POSTGRES_PASSWORD=local-dev \
  .
```

A quick sanity check:

`→ podman images`

```
REPOSITORY          TAG              IMAGE ID      CREATED         SIZE
localhost/postgres  16.1-alpine3.19  5ea5105c896e  13 minutes ago  242 MB
```

The postgres database is initialized with a superuser named `dev` and a database with the same name.

### Persist Data

In order to persist data from the container start/stop/remove cycle we first create a `volume` with a name `pgdata`:

`→ podman volume create pgdata`

A quick sanity check:

`→ podman volume ls`

```
DRIVER      VOLUME NAME
local       pgdata
```

### Run Container

Create a postgres container with the name local-pg:

```
→ podman run \
  -d \
  --name local-pg \
  -v pgdata:/var/lib/postgresql/data \
  -p 5432:5432 \
  localhost/postgres:16.2-alpine3.19

→ 48803f2864eba641bef9dcc11fb94c0a76802b89fc6c236bc9752df56b4e808e
```
The flag `-d` means to run the container in a detached mode. After executing the above command you should see a container ID sha as the only output (similar to this): `48803f2864eba641bef9dcc11fb94c0a76802b89fc6c236bc9752df56b4e808e`

### Sanity Checks

Connect to the postgres container:

```
→ podman exec -it local-pg bash

48803f2864eb:/#
```

Note that `48803f2864eb` is part of the container ID sha from above.

Inside the container we will run the following psql command and see the output:

`psql -h localhost -U dev -d reactatx`

```
psql (16.1)
Type "help" for help.

reactatx=#
```

Next, copy/paste the following to create the table `member`:

```
CREATE TABLE IF NOT EXISTS member (
  email  TEXT
);
```
Insert some data into the table:

`INSERT INTO member (email) VALUES ('member@reactatx.org');`

Then do a `SELECT * FROM member;` and you should see

```
        email
---------------------
 member@reactatx.org
(1 row)
```

Great! Now lets `\q` to quit postgres and then `exit` to exit the container.

To check that the data is persisted we are going to remove the running container:

`→ podman container rm local-pg -f`

and then re-run the command:

```
→ podman run \
  -d \
  --name local-pg \
  -v pgdata:/var/lib/postgresql/data \
  -p 5432:5432 \
  localhost/postgres:16.2-alpine3.19

→ debc19aaf34fb7a87e7ced1704a68fcc66964a40721f93eb863ae498bc6b4c2b
```

Then

```
→ podman exec -it local-pg bash

debc19aaf34f:/#
```

and finally

`psql -h localhost -U dev -d reactatx`

```
psql (16.1)
Type "help" for help.

reactatx=#
```

Run the SQL `SELECT * FROM member;` and you should see

```
        email
---------------------
 member@reactatx.org
(1 row)
```

Our data persists!

>NOTE: Remove the data once you checked your sanity:
> 1. stop & remove the container: `podman container rm local-g -f`
> 2. remove the volume: `podman volume remove pgdata`
> 3. create a new volume: `podman volume create pgdata`
> 4. run a new container following the above `podman run` command

## Docker

The following assumes you have installed and have running [Docker Desktop].

### Build Image

We will be using the `Containerfile` to build our image. Run the following:

```
→ docker build \
  -t localhost/postgres:16.2-alpine3.19 \
  --build-arg now=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
  --build-arg POSTGRES_DB=reactatx \
  --build-arg POSTGRES_USER=dev \
  --build-arg POSTGRES_PASSWORD=local-dev \
  -f Containerfile \
  .
```

A quick sanity check:

`→ docker images`

```
REPOSITORY           TAG               IMAGE ID       CREATED       SIZE
localhost/postgres   16.1-alpine3.19   877f8b2edce7   5 weeks ago   353MB
```

The postgres database is initialized with a superuser named `dev` and a database with the same name.

### Persist Data

In order to persist data from the container start/stop/remove cycle we first create a `volume` with a name `pgdata`:

`→ docker volume create pgdata`

A quick sanity check:

`→ docker volume ls`

```
DRIVER      VOLUME NAME
local       pgdata
```

### Run Container

Create a postgres container with the name local-pg:

```
→ docker run \
  -d \
  --name local-pg \
  -v pgdata:/var/lib/postgresql/data \
  -p 5432:5432 \
  localhost/postgres:16.2-alpine3.19

→ 238a31bfa1113c9f6f665a59a5dd586fed09405004b552daf8abf7141df6a9ba
```
The flag `-d` means to run the container in a detached mode. After executing the above command you should see a container ID sha as the only output (yours will be different but similar): `238a31bfa1113c9f6f665a59a5dd586fed09405004b552daf8abf7141df6a9ba`

### Sanity Checks

Connect to the postgres container:

```
→ docker exec -it local-pg bash

238a31bfa111:/#
```

Note that `238a31bfa111` is part of the container ID sha from above.

Inside the container we will run the following psql command and see the output:

`psql -h localhost -U dev -d reactatx`

```
psql (16.1)
Type "help" for help.

reactatx=#
```

Next, copy/paste the following to create the table `member`:

```
CREATE TABLE IF NOT EXISTS member (
  email  TEXT
);
```
Insert some data into the table:

`INSERT INTO member (email) VALUES ('member@reactatx.org');`

Then do a `SELECT * FROM member;` and you should see

```
        email
---------------------
 member@reactatx.org
(1 row)
```

Great! Now lets `\q` to quit postgres and then `exit` to exit the container.

To check that the data is persisted we are going to remove the running container:

`→ docker container rm local-pg -f`

and then re-run the command:

```
→ docker run \
  -d \
  --name local-pg \
  -v pgdata:/var/lib/postgresql/data \
  -p 5432:5432 \
  localhost/postgres:16.2-alpine3.19

→ debc19aaf34fb7a87e7ced1704a68fcc66964a40721f93eb863ae498bc6b4c2b
```

Then

```
→ docker exec -it local-pg bash

debc19aaf34f:/#
```

and finally

`psql -h localhost -U dev -d reactatx`

```
psql (16.1)
Type "help" for help.

reactatx=#
```

Run the SQL `SELECT * FROM member;` and you should see

```
        email
---------------------
 member@reactatx.org
(1 row)
```

Our data persists!

>NOTE: Remove the data once you checked your sanity:
> 1. stop & remove the container: `docker container rm local-pg -f`
> 2. remove the volume: `docker volume remove pgdata`
> 3. create a new volume: `docker volume create pgdata`
> 4. run a new container following the above `docker run` command

# Initialize and Seed the database

> NOTE: In order to perform the following commands you need to have `psql` installed on your system. We will use `psql` to talk to the database server inside the container. Find the installation for your OS [here](https://www.postgresql.org/download/).

To initialize and seed the database it is assumed that you are using one of the package managers: [pnpm], [yarn], or [npm].

Run the podman command to create a new database container. Once that is running execute the following commands (substitute for your package manager):

1. `→ pnpm initdb`
2. `→ pnpm seeddb`

At this point, you can use a db client to connect to the database locally to verify that the tables and seed data were indeed initialized.

You can also `podman exec -it local-pg bash` or `docker exec -it local-pg bash` and follow the above instructions to verify.

# Helpful Commands

### Stop Container
`podman container stop local-pg`
`docker container stop local-pg`

### Start Container
`podman container start local-pg`
`docker container start local-pg`

### Remove Container
`podman container rm local-pg -f`
`docker container rm local-pg -f`

### Create Volume
`podman volume create pgdata`
`docker volume create pgdata`

### Remove Volume
`podman volume rm pgdata`
`docker volume rm pgdata`


[podman]: https://podman.io
[podman desktop]: https://podman-desktop.io
[docker hub]: https://hub.docker.com/_/postgres
[docker desktop]: https://docs.docker.com/desktop
[pnpm]: https://pnpm.io
[yarn]: https://yarnpkg.com
[npm]: https://www.npmjs.com
