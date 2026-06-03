BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "coach_athlete" (
    "id" bigserial PRIMARY KEY,
    "coachId" bigint NOT NULL,
    "athleteId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "coach_athlete_coach_idx" ON "coach_athlete" USING btree ("coachId");
CREATE INDEX "coach_athlete_athlete_idx" ON "coach_athlete" USING btree ("athleteId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "video_comment" (
    "id" bigserial PRIMARY KEY,
    "videoId" bigint NOT NULL,
    "coachId" bigint NOT NULL,
    "coachName" text NOT NULL,
    "text" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "video_comment_video_idx" ON "video_comment" USING btree ("videoId");
CREATE INDEX "video_comment_coach_idx" ON "video_comment" USING btree ("coachId");


--
-- MIGRATION VERSION FOR coach_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('coach_app', '20260529204431180', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260529204431180', "timestamp" = now();

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
