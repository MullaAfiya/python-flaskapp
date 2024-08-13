# Base image with Flet installed
FROM python:3.9-slim-buster AS builder

WORKDIR /app

# Install Flet dependencies
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copy your Python application code
COPY . .

# Build a slimmer image for production
FROM python:3.9-slim-buster

# Copy the application code from the builder stage
COPY --from=builder /app /app

# Set the working directory
WORKDIR /app

# Expose the port used by Flet (optional)
EXPOSE 8080

# Command to run the application 
CMD ["flet", "app.py"]  # Replace "app.py" with your main script name
