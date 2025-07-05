FROM python:3.9-slim

# Create working folder and install dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application contents
COPY service/ ./service/

# Switch to a non-root user
RUN useradd --uid 1000 srpolo && chown -R srpolo /app
USER srpolo

# Run the service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]