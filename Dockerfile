# Use Python 3.9-slim as the base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files into the image
COPY service/ ./service/

# Create and switch to a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Expose the application port
EXPOSE 8080

# Set the entrypoint command for Gunicorn
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]