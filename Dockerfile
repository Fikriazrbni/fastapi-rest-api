FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy and install dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy app source
COPY app /app/app

# Railway provides a PORT env var at runtime; default to 8000 for local runs
ENV PORT=8000

EXPOSE 8000

# Run with uvicorn. Use sh -c so ${PORT} is expanded from environment.
CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT}"]
