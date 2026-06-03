# Build this image from the repository root:
# docker build -f coach_app_server/Dockerfile -t coach-app-server .
FROM dart:3.8.0 AS build
WORKDIR /app
COPY coach_app_server/ ./

# The repository uses a Dart workspace, but the server image is built without
# Flutter SDK. For the container build we resolve only the Serverpod server.
RUN sed -i '/^resolution:[[:space:]]*workspace$/d' pubspec.yaml
RUN dart pub get
RUN dart compile exe bin/main.dart -o bin/server

# Final stage
FROM alpine:latest

# Environment variables
ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

# Copy runtime dependencies
COPY --from=build /runtime/ /

# Copy compiled server executable
COPY --from=build /app/bin/server server

# Copy configuration files and resources
COPY --from=build /app/config/ config/
COPY --from=build /app/web/ web/
COPY --from=build /app/migrations/ migrations/

# This file is required to enable the endpoint log filter in Insights.
COPY --from=build /app/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml

# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Define the entrypoint command. Extra arguments, such as --apply-migrations,
# are appended to the server command.
ENTRYPOINT ["sh", "-c", "exec ./server --mode=${runmode} --server-id=${serverid} --logging=${logging} --role=${role} \"$@\"", "--"]
