# Build stage
FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY . .

RUN go build -o main main.go
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.17.1/migrate.linux-amd64.tar.gz | tar xvz

# Run stage
FROM alpine:3.19
WORKDIR /app

COPY --from=builder /app/main .
COPY --from=builder /app/migrate ./migrate 
COPY app.env .
COPY start.sh .
COPY wait-for.sh .
COPY db/migration ./migration

# Ensure that the scripts have executable permissions
RUN chmod +x start.sh wait-for.sh

EXPOSE 8080

# Change CMD and ENTRYPOINT to ensure correct script execution
CMD [ "/app/main" ]
ENTRYPOINT [ "/app/start.sh" ]
