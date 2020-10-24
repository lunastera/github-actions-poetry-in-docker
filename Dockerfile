# env
ARG APP_ENV=development
ARG MAIN_MODULE=gapid

# :base
FROM python:3.7-stretch as base

ENV APP_DIR /app
ENV PIP_NO_CACHE_DIR=true \
  POETRY_HOME="/opt/poetry" \
  POETRY_VIRTUALENVS_CREATE=false \
  POETRY_NO_INTERACTION=1
ENV PATH="${POETRY_HOME}/bin:$PATH"

# install poetry
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

# work dirs
WORKDIR ${APP_DIR}
COPY pyproject.toml poetry.lock ${MAIN_MODULE} ./

EXPOSE 8000

# :development
FROM base as development
RUN poetry install

# :production
FROM base as production
RUN poetry install --no-dev

# :final
FROM ${APP_ENV} as final
COPY . .
CMD ["./docker-entrypoint.sh"]
