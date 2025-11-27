FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Copy CLI code
COPY lectoncli/ lectoncli/
COPY entrypoint.sh entrypoint.sh

# Install dependencies
RUN pip install --no-cache-dir click

# Make entrypoint executable
RUN chmod +x entrypoint.sh

# Default entrypoint
ENTRYPOINT ["./entrypoint.sh"]
