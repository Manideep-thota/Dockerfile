# Sample Dockerfile for a simple Python app
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy current directory contents into the container at /app
COPY . /app

# Install any dependencies
RUN pip install --no-cache-dir -r requirements.txt || echo "No requirements.txt file, skipping"

# Run a simple Python script
CMD ["python", "-c", "print('Hello from Docker!')"]
