FROM python:3.9

# Set the working directory in the container
WORKDIR .

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
    && rm -rf /var/lib/apt/lists/*

CMD ["python", "hello.py"]
