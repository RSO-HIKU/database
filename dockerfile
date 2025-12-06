FROM postgres:16-alpine

# Set environment variables
ENV POSTGRES_DB=hikudb \
    POSTGRES_USER=hikuuser \
    POSTGRES_PASSWORD=hikupassword \
    PGDATA=/var/lib/postgresql/data/pgdata

# Install additional tools if needed
RUN apk add --no-cache \
    postgresql-contrib \
    curl

# Copy initialization scripts
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Health check
HEALTHCHECK --interval=10s --timeout=5s --retries=5 \
    CMD pg_isready -U $POSTGRES_USER -d $POSTGRES_DB

# Expose PostgreSQL port
EXPOSE 11000

# Default command
CMD ["postgres"]
