.Phony: postgres createdb dropdb migrateup migratedown sqlc test server mock

postgres:
	docker run --name postgres12_new --network bank-network -p 5436:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12_new createdb --username=root --owner=root simplebank

dropdb:
	docker exec -it postgres12_new dropdb simplebank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5436/simplebank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5436/simplebank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5436/simplebank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5436/simplebank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/parth/simplebank/db/sqlc Store


