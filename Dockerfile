FROM python:3.9

# Set the working directory in the container
WORKDIR /app
# Copy the requirements file into the container
COPY hello.py /app

CMD ["python", "hello.py"]
