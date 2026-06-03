BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workout_video" (
    "id" bigserial PRIMARY KEY,
    "workoutId" bigint NOT NULL,
    "workoutExerciseId" bigint NOT NULL,
    "workoutSetId" bigint NOT NULL,
    "athleteId" bigint NOT NULL,
    "fileName" text NOT NULL,
    "filePath" text NOT NULL,
    "uploadedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "workout_video_workout_idx" ON "workout_video" USING btree ("workoutId");
CREATE INDEX "workout_video_set_idx" ON "workout_video" USING btree ("workoutSetId");
CREATE INDEX "workout_video_athlete_idx" ON "workout_video" USING btree ("athleteId");


--
-- MIGRATION VERSION FOR coach_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('coach_app', '20260529145320751', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260529145320751', "timestamp" = now();

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
