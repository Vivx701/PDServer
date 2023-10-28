# syntax=docker/dockerfile:1

FROM golang:1.21.2

# Set destination for COPY
RUN mkdir /App
#RUN mkdir /App/pdserver




# Copy the source code. Note the slash at the end, as explained in
# https://docs.docker.com/engine/reference/builder/#copy
COPY go.mod go.sum /App
#COPY pkg /App/pdserver
#COPY main.go /App/pdserver
COPY PatientDetails.json /App
COPY PDDatabase.db /App
COPY pdserver /App

WORKDIR /App

# Download Go modules
RUN go mod download

# Build
#RUN export CGO_ENABLED = 1
#RUN export GOOS = "linux"
#RUN go build -o PDServer

# Optional:
# To bind to a TCP port, runtime parameters must be supplied to the docker command.
# But we can document in the Dockerfile what ports
# the application is going to listen on by default.
# https://docs.docker.com/engine/reference/builder/#expose
EXPOSE 8000

# Run
CMD ["/App/pdserver"]