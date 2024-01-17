# https://hub.docker.com/layers/library/postgres/16.1-alpine3.19/images/sha256-d9449d47e5bc5ac6b832168b0f38e7ea7762ac75c574963d5ebfd75090f55d35?context=explore
FROM docker.io/library/postgres:16.1-alpine3.19

# labels from https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL org.opencontainers.image.created=$now
LABEL org.opencontainers.image.authors=roberto.fuentes@webfountain.io

# URL to find more information on the image
# LABEL org.opencontainers.image.url=https://hub.docker.com/r/bretfisher/jekyll

# URL to get documentation on the image
# LABEL org.opencontainers.image.documentation=https://hub.docker.com/r/bretfisher/jekyll

# URL to get source code for building the image
# LABEL org.opencontainers.image.source=https://github.com/BretFisher/udemy-docker-mastery-for-nodejs

# Version of the packaged software - The version MAY match a label or tag in the source code repository
# LABEL org.opencontainers.image.version=$PACKAGE_VERSION

# Source control revision identifier for the packaged software.
# LABEL org.opencontainers.image.revision=$SOURCE_COMMIT

# Name of the distributing entity, organization or individual.
LABEL org.opencontainers.image.vendor="Web Fountain, Inc"

# License(s) under which contained software is distributed as an SPDX License Expression.
LABEL org.opencontainers.image.licenses=Apache-2.0

# title, description, name, digest of image
LABEL org.opencontainers.image.title="React ATX Database"
LABEL org.opencontainers.image.description="Postgres database for local application development"
LABEL org.opencontainers.image.base.name=dokcer.io/library/postgres:16.1-alpine3.19
LABEL org.opencontainers.image.base.digest=sha256:d9449d47e5bc5ac6b832168b0f38e7ea7762ac75c574963d5ebfd75090f55d35

# version
LABEL io.webfountain.postgres.version=16.1

# env variables
ENV POSTGRES_DB=$POSTGRES_DB
ENV POSTGRES_USER=$POSTGRES_USER
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD


USER postgres
EXPOSE 5432
