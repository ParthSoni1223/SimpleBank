CREATE TABLE "sessions" (
  "id" uuid PRIMARY KEY,
  "username" VARCHAR NOT NULL,
  "refresh_token" VARCHAR NOT NULL,
  "user_agent" VARCHAR NOT NULL,
  "client_ip" VARCHAR NOT NULL,
  "is_blocked" boolean NOT NULL DEFAULT 'false',
  "expires_at" TIMESTAMPTZ NOT NULL,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


ALTER TABLE "sessions" ADD FOREIGN KEY ("username") REFERENCES "users" ("username");