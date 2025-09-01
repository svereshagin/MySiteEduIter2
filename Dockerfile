FROM python:3.11-slim-bookworm

# Create non-root user
RUN groupadd --gid 1000 app \
    && useradd --uid 1000 --gid app --shell /bin/bash --create-home app

# Set working directory
WORKDIR /code

# Create directories with correct permissions
RUN mkdir -p /code/src/user_files /code/app/logs \
    && chown -R app:app /code \
    && chmod -R 755 /code

# Copy project files
COPY ./src /code/src
COPY ./requirements.txt /code/requirements.txt

# Install dependencies
RUN pip install --no-cache-dir -r /code/requirements.txt

# Switch to non-root user
USER app

# Set PYTHONPATH for imports
ENV PYTHONPATH=/code/src

# Command to run the application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]