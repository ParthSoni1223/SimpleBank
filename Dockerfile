# Build stage
FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY . .

RUN go build -o main main.go

# Run stage
FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/main .
FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate ./migrate 
COPY app.env .
COPY start.sh .
COPY wait-for.sh .
COPY db/migration ./migration

EXPOSE 8080

CMD ["/app/main"]
ENTRYPOINT [ "/app/start.sh" ]