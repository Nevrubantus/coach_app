BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "body_weight_entry" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "weight" double precision NOT NULL,
    "measuredAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "body_weight_entry_user_idx" ON "body_weight_entry" USING btree ("userId");
CREATE INDEX "body_weight_entry_measured_at_idx" ON "body_weight_entry" USING btree ("measuredAt");


--
-- MIGRATION VERSION FOR coach_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('coach_app', '20260528143736605', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260528143736605', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
