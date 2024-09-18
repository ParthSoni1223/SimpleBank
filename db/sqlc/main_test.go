package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	_ "github.com/lib/pq"
	"github.com/parth/simplebank/util"
)

var TestQueries *Queries
var TestDb *sql.DB

func TestMain(m *testing.M) {
	config, err := util.LoadConfig("../..")
	if err != nil {
		log.Fatal("cannot load config", err)
	}

	TestDb, err = sql.Open(config.DBDRIVER, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	TestQueries = New(TestDb)
	os.Exit(m.Run())
}
