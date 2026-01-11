# Database Documentation

## Overview

This directory contains the **local development database setup** for the Hiku  application. Production uses Azure managed services.

### Purpose
- Provides a local PostgreSQL database with PostGIS for development and testing
- Includes pgAdmin for database management 
- Contains migration scripts

## Architecture

### Database Technology Stack
- **PostgreSQL 16**: Primary relational database
- **PostGIS 3.4**: Spatial database extension for geographic data
- **Flyway 10**: Database migration and version control
- **pgAdmin 4**: Database administration and query tool

### Extensions
The database uses several PostgreSQL extensions:
- `uuid-ossp`: UUID generation functions
- `postgis`: Geographic objects and spatial queries
- `pg_trgm`: Text similarity and fuzzy string matching

## Local Development 

### Components

#### 1. PostgreSQL Container (Local Development Only)
**Image**: `postgis/postgis:16-3.4`

**Features**:
- Persistent storage with Docker volume
- Health check monitoring
- PostGIS spatial capabilities for geographic data for peaks locations


#### 2. pgAdmin Container (Local Development Only)
**Image**: `dpage/pgadmin4:latest`


**Features**:
- Web-based database management interface
- Pre-configured server connection
- Query editor and schema visualization
- Accessible at `http://localhost:5050`

#### 3. Database Migrator 
**Image**: `flyway/flyway:10-alpine`

**Purpose**: Manages database schema versions and migrations 

**Dockerfile**: [database/Dockerfile.migrator](../Dockerfile.migrator)


## Kubernetes Deployment 

The database includes Helm charts primarily for:
1. **Local/Dev K8s clusters**: Deploy PostgreSQL in minikube/kind
2. **Migration automation**: Run Flyway migrations against any database (local or Azure)
3. **Configuration management**: Template-based configuration for different environments

### Helm Chart Structure

**Location**: `database/helm/`

**Chart Components**:
- `Chart.yaml`: Helm chart metadata
- `values-dev.yaml`: Development environment values
- `templates/`: Kubernetes resource templates

### Deployment Modes

#### Development Mode (`postgres.enabled: true`) - Local K8s Only

Features:
- In-cluster PostgreSQL instance
- 5Gi persistent storage
- Resource limits: 512Mi memory, 250m CPU
- pgAdmin enabled on NodePort 30090

#### Azure Mode (`azure.enabled: true`) 

## Database Migrations

### Migration Files

Location: `database/migration/`

### Migration Strategy

**Flyway**:
- Baseline Version: 0
- Baseline on Migrate: true
- History Table


**Migration Naming Convention**:
```
V{version}__{description}.sql
Example: V1__extension_init.sql
```

**How It Works**:
1. Flyway scans  for migration scripts
2. Compares with flyway_history table
3. Applies new migrations in version order
4. Records applied migrations in history table


## Database Schemas

The Hiku application uses multiple schemas for microservice data isolation:

### Schema Overview

| Schema | Purpose | Service |
|--------|---------|---------|
| `peaks_hikes_service` | Geographic data for peaks, trails, and routes | Peaks & Hikes Service |
| `badge_service` |  User logbooks | Badge Service |
| `user_service` | User profiles and follow relationship | User Service |
| `activity_service` | User activities and tracking | Activity Service |
| `social_feed_service` | Posts and social feeds | Social Feed Service |
| `scoreboards_challenges_service` | Leaderboards and challenges | Scoreboards & Challenges Service |

## Query Examples

### Useful Development Queries

**Location**: `database/pgAdmin queries`

**Last Updated**: January 2026  
**Database Version**: PostgreSQL 16 with PostGIS 3.4  
**Flyway Version**: 10-alpine
