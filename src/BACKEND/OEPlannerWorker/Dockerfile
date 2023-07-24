FROM python:3.10-slim

WORKDIR /app

# Copy pyproject.toml and poetry.locl
COPY pyproject.toml poetry.lock ./

# Install poetry
RUN pip install poetry

# Install dependencies
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

# Copy source code
COPY . .

CMD ["poetry", "run", "celery", "-A", "oeplannerworker.celery_app", "worker", "--loglevel=info"]