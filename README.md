# Getting Started

The following assumes you have installed and have running [Podman] and/or [Podman Desktop]
and/or [Docker Desktop].

> NOTE: If you are using Docker substitute the command `podman` for `docker` below

## 1. Build the Postgres Image

We will be using the `Containerfile` to build our image. Run the following:

```
→ podman build \
  -t localhost/postgres:16.1-alpine3.18 \
  --env now=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
  --env POSTGRES_DB=reactatx \
  --env POSTGRES_USER=reactatx \
  --env POSTGRES_PASSWORD=admin \
  .
```

A quick sanity check:

`→ podman images`

```
REPOSITORY          TAG              IMAGE ID      CREATED         SIZE
localhost/postgres  16.1-alpine3.18  5ea5105c896e  13 minutes ago  242 MB
```

The postgres database is initialized with a superuser named `reactatx` and a database with the same name.

## 2. Persisting Postgres Data

In order to persist data from the container start/stop/remove cycle we first create a `volume` with a name `pgdata`:

`→ podman volume create pgdata`

A quick sanity check:

`→ podman volume ls`

```
DRIVER      VOLUME NAME
local       pgdata
```

## 3. Running a Postgres Container

Create a postgres container with the name local-pg:

```
→ podman run \
  -d \
  --name local-pg \
  -v pgdata:/var/lib/postgresql/data \
  -p 5432:5432 \
  localhost/postgres:16.1-alpine3.18

→ 48803f2864eba641bef9dcc11fb94c0a76802b89fc6c236bc9752df56b4e808e
```
The flag `-d` means to run the container in a detached mode. After executing the above command you should see a container ID sha as the only output (similar to this): `48803f2864eba641bef9dcc11fb94c0a76802b89fc6c236bc9752df56b4e808e`

## 4. Sanity Checks

Connect to the postgres container:

```
→ podman exec -it local-pg bash

48803f2864eb:/#
```

Note that `48803f2864eb` is part of the container ID sha from above.

Inside the container we will run the following psql command and see the output:

`psql -h localhost -U reactatx -d reactatx`

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
  --env-file=.env \
  -v pgdata:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:16.1-alpine

→ debc19aaf34fb7a87e7ced1704a68fcc66964a40721f93eb863ae498bc6b4c2b
```

Then

```
→ podman exec -it local-pg bash

debc19aaf34f:/#
```

and finally

`psql -h localhost -U reactatx -d reactatx`

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

# Initialize & Seed the database

To initialize and seed the database it is assumed that you are using one of the package managers: [pnpm], [yarn], or [npm].

Run the podman command to create a new database container. Once that is running execute the following commands (substitute for your package manager):

1. `→ pnpm initdb`
1. `→ pnpm seeddb`

At this point, you can use a db client to connect to the database locally to verify that the tables and seed data were indeed initialized.

You can also `podman exec -it local-pg bash` and follow the above instructions to verify.

# Helpful Commands

### Stop Container
`podman container stop local-pg`

### Start Container
`podman container start local-pg`

### Remove Container
`podman container rm local-pg -f`

### Create Volume
`podman volume create pgdata`

### Remove Volume
`podman volume rm pgdata`


[podman]: https://podman.io
[podman desktop]: https://podman-desktop.io
[docker hub]: https://hub.docker.com/_/postgres
[docker desktop]: https://docs.docker.com/desktop
[pnpm]: https://pnpm.io
[yarn]: https://yarnpkg.com
[npm]: https://www.npmjs.com