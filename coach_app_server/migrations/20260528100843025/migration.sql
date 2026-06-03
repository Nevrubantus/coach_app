BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "exercise" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "description" text NOT NULL,
    "mediaUrl" text,
    "mediaType" text
);

-- Indexes
CREATE INDEX "exercise_name_idx" ON "exercise" USING btree ("name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workout" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "scheduledAt" timestamp without time zone NOT NULL,
    "durationMinutes" bigint,
    "notes" text,
    "isCompleted" boolean NOT NULL
);

-- Indexes
CREATE INDEX "workout_user_idx" ON "workout" USING btree ("userId");
CREATE INDEX "workout_scheduled_at_idx" ON "workout" USING btree ("scheduledAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workout_exercise" (
    "id" bigserial PRIMARY KEY,
    "workoutId" bigint NOT NULL,
    "exerciseId" bigint NOT NULL,
    "exerciseName" text NOT NULL,
    "orderIndex" bigint NOT NULL,
    "notes" text
);

-- Indexes
CREATE INDEX "workout_exercise_workout_idx" ON "workout_exercise" USING btree ("workoutId");
CREATE INDEX "workout_exercise_exercise_idx" ON "workout_exercise" USING btree ("exerciseId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "workout_set" (
    "id" bigserial PRIMARY KEY,
    "workoutExerciseId" bigint NOT NULL,
    "setIndex" bigint NOT NULL,
    "weight" double precision NOT NULL,
    "reps" bigint NOT NULL,
    "notes" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "workout_set_exercise_idx" ON "workout_set" USING btree ("workoutExerciseId");


--
-- MIGRATION VERSION FOR coach_app
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('coach_app', '20260528100843025', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260528100843025', "timestamp" = now();

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
