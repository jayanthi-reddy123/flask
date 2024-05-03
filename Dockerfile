# pull official base image
FROM python:3.11.3-slim-buster

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Make entrypoint script executable
RUN chmod +x entrypoint.sh

# install system dependencies
RUN apt-get update && apt-get install -y netcat

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt /usr/src/app/requirements.txt
RUN pip install -r requirements.txt

# copy project
COPY . /usr/src/app/

# Expose port 5000 to the outside world
EXPOSE 5000

# run entrypoint.sh
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]

# Run entrypoint script when the container launches
CMD ["./entrypoint.sh"]
