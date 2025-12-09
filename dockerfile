FROM postgis/postgis:16-3.4

# Set environment variables
ENV POSTGRES_DB=hikudb \
    POSTGRES_USER=hikuuser \
    POSTGRES_PASSWORD=hikupassword \
    PGDATA=/var/lib/postgresql/data/pgdata

# Copy initialization scripts
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Health check
HEALTHCHECK --interval=10s --timeout=5s --retries=5 \
    CMD pg_isready -U $POSTGRES_USER -d $POSTGRES_DB

# Expose PostgreSQL port
EXPOSE 11000

# Default command
CMD ["postgres"]
