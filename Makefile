postgres:
	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=secret -d postgres

postgres_cli:
	docker exec -it postgres psql -U postgres

create_db:
	docker exec -it postgres createdb --username=postgres --owner=postgres simple_bank

drop_db:
	docker exec -it postgres dropdb --username=postgres simple_bank


migrate_up:
	migrate -path db/migration -database "postgresql://postgres:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrate_down:
	migrate -path db/migration -database "postgresql://postgres:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down


sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres postgres_cli create_db drop_db migrate_up migrate_down