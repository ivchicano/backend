#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

env

# ----- NEED TO CREATE BEFORE API SCHEMA SINCE MICADO WILL DEPEND ON SOME TABLES AND THUS THOSE TABLES NEED TO BE THERE OR REFERENCE WILL NOT WORK

# ---------- API MANAGER SHARED DB

echo "\nCreating WSO2_Shared components\n"
psql -c "CREATE USER $WSO2_SHARED_USER WITH ENCRYPTED PASSWORD '$WSO2_SHARED_PWD';"
psql -c "CREATE SCHEMA $WSO2_SHARED_SCHEMA;"
psql -c "GRANT CONNECT ON DATABASE $POSTGRES_DB TO $WSO2_SHARED_USER;"
psql -c "GRANT USAGE ON SCHEMA $WSO2_SHARED_SCHEMA TO $WSO2_SHARED_USER;"
psql -c "GRANT CREATE ON SCHEMA $WSO2_SHARED_SCHEMA TO $WSO2_SHARED_USER;"
psql -c "ALTER ROLE $WSO2_SHARED_USER IN DATABASE $POSTGRES_DB SET search_path = $WSO2_SHARED_SCHEMA;"
psql -c "ALTER DEFAULT PRIVILEGES IN SCHEMA $WSO2_SHARED_SCHEMA GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO $WSO2_SHARED_USER;"
psql -c "ALTER DEFAULT PRIVILEGES IN SCHEMA $WSO2_SHARED_SCHEMA GRANT USAGE ON SEQUENCES TO $WSO2_SHARED_USER;"

echo "\nCreated WSO2_SHARED components, now adding tables\n"

psql -U $WSO2_SHARED_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/api_shared_postgresql.sql.txt

# ---------- API MANAGER API DB

echo "\nCreating WSO2_API components\n"
psql -c "CREATE USER $WSO2_API_USER WITH ENCRYPTED PASSWORD '$WSO2_API_PWD';"
psql -c "CREATE SCHEMA $WSO2_API_SCHEMA;"
psql -c "GRANT CONNECT ON DATABASE $POSTGRES_DB TO $WSO2_API_USER;"
psql -c "GRANT USAGE ON SCHEMA $WSO2_API_SCHEMA TO $WSO2_API_USER;"
psql -c "GRANT CREATE ON SCHEMA $WSO2_API_SCHEMA TO $WSO2_API_USER;"
psql -c "ALTER ROLE $WSO2_API_USER IN DATABASE $POSTGRES_DB SET search_path = $WSO2_API_SCHEMA;"
psql -c "ALTER DEFAULT PRIVILEGES IN SCHEMA $WSO2_API_SCHEMA GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO $WSO2_API_USER;"
psql -c "ALTER DEFAULT PRIVILEGES IN SCHEMA $WSO2_API_SCHEMA GRANT USAGE ON SEQUENCES TO $WSO2_API_USER;"

echo "\nCreated WSO2_API components, now adding tables\n"

psql -U $WSO2_API_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/api_api_postgresql.sql.txt
#psql -U $WSO2_API_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/12_wso2_api_postgresql.sql.txt
#psql -U $WSO2_API_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/13_wso2_api_apim_postgresql.sql.txt
#psql -U $WSO2_API_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/14_wso2_api_postgresql-mb.sql.txt
#psql -U $WSO2_API_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/15_wso2_api_metrics_postgresql.sql.txt


#echo "\nCreating WSO2_Identity components\n"
#psql -c "CREATE USER $WSO2_IDENTITY_USER WITH ENCRYPTED PASSWORD '$WSO2_IDENTITY_PWD';"
#psql -c "CREATE SCHEMA $WSO2_IDENTITY_SCHEMA;"
#psql -c "GRANT CONNECT ON DATABASE $POSTGRES_DB TO $WSO2_IDENTITY_USER;"
#psql -c "GRANT USAGE ON SCHEMA $WSO2_IDENTITY_SCHEMA TO $WSO2_IDENTITY_USER;"
#psql -c "GRANT CREATE ON SCHEMA $WSO2_IDENTITY_SCHEMA TO $WSO2_IDENTITY_USER;"
#psql -c "ALTER ROLE $WSO2_IDENTITY_USER IN DATABASE $POSTGRES_DB SET search_path = $WSO2_IDENTITY_SCHEMA;"
#psql -c "ALTER DEFAULT PRIVILEGES IN SCHEMA $WSO2_IDENTITY_SCHEMA GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO $WSO2_IDENTITY_USER;"
#psql -c "ALTER DEFAULT PRIVILEGES IN SCHEMA $WSO2_IDENTITY_SCHEMA GRANT USAGE ON SEQUENCES TO $WSO2_IDENTITY_USER;"

#echo "\nCreated WSO2_IDENTITY components, now adding tables\n"

#psql -U $WSO2_IDENTITY_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/03_wso2_is_postgresql.sql.txt
#psql -U $WSO2_IDENTITY_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/04_wso2_is_api_postgresql_merged.sql.txt
#psql -U $WSO2_IDENTITY_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/05_wso2_is_identity_uma_postgresql.sql.txt
#psql -U $WSO2_IDENTITY_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/06_wso2_is_postgresql_11-tokencleanup.sql.txt
#psql -U $WSO2_IDENTITY_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/07_wso2_is_postgresql-tokencleanup-restore.sql.txt
#psql -U $WSO2_IDENTITY_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/09_wso2_is_bpel_postgresql.sql.txt
#psql -U $WSO2_IDENTITY_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/11_wso2_is_metric_postgresql.sql.txt


echo "\nCreating MICADO apps components\n"
psql -c "CREATE USER $MICADO_DB_USER WITH ENCRYPTED PASSWORD '$MICADO_DB_PWD';"
psql -c "CREATE SCHEMA $MICADO_DB_SCHEMA;"
psql -c "GRANT CONNECT ON DATABASE $POSTGRES_DB TO $MICADO_DB_USER;"
psql -c "GRANT USAGE ON SCHEMA $MICADO_DB_SCHEMA TO $MICADO_DB_USER;"
psql -c "GRANT CREATE ON SCHEMA $MICADO_DB_SCHEMA TO $MICADO_DB_USER;"
psql -c "ALTER ROLE $MICADO_DB_USER IN DATABASE $POSTGRES_DB SET search_path = $MICADO_DB_SCHEMA;"
psql -c "ALTER DEFAULT PRIVILEGES IN SCHEMA $MICADO_DB_SCHEMA GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO $MICADO_DB_USER;"
psql -c "ALTER DEFAULT PRIVILEGES IN SCHEMA $MICADO_DB_SCHEMA GRANT USAGE ON SEQUENCES TO $MICADO_DB_USER;"

# NOW GRANTING USAGE TO SCHEMA AND SPECIFIC TABLES
psql -c "GRANT USAGE ON SCHEMA $WSO2_SHARED_SCHEMA TO $MICADO_DB_USER;"
psql -c "GRANT SELECT, REFERENCES ON $WSO2_SHARED_SCHEMA.um_tenant TO $MICADO_DB_USER;"
psql -c "GRANT SELECT, REFERENCES ON $WSO2_SHARED_SCHEMA.um_user TO $MICADO_DB_USER;"

echo "\nCreated MICADO apps components, now adding tables\n"

#psql -U $MICADO_DB_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/01_db.sql.txt
psql -U $MICADO_DB_USER -d $POSTGRES_DB -a -q -f /docker-entrypoint-initdb.d/Micado_DB_Schema.sql.txt



echo "\nCreating WEBLATE components\n"
psql -c "CREATE USER $WEBLATE_POSTGRES_USER WITH ENCRYPTED PASSWORD '$WEBLATE_POSTGRES_PASSWORD';"
psql -c "CREATE SCHEMA $WEBLATE_DB_SCHEMA;"
psql -c "GRANT CONNECT ON DATABASE $POSTGRES_DB TO $WEBLATE_POSTGRES_USER;"
psql -c "GRANT USAGE ON SCHEMA $WEBLATE_DB_SCHEMA TO $WEBLATE_POSTGRES_USER;"
psql -c "GRANT CREATE ON SCHEMA $WEBLATE_DB_SCHEMA TO $WEBLATE_POSTGRES_USER;"
psql -c "ALTER ROLE $WEBLATE_POSTGRES_USER IN DATABASE $POSTGRES_DB SET search_path = $WEBLATE_DB_SCHEMA;"
psql -c "ALTER DEFAULT PRIVILEGES IN SCHEMA $WEBLATE_DB_SCHEMA GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO $WEBLATE_POSTGRES_USER;"
psql -c "ALTER DEFAULT PRIVILEGES IN SCHEMA $WEBLATE_DB_SCHEMA GRANT USAGE ON SEQUENCES TO $WEBLATE_POSTGRES_USER;"

echo "\nCreated WEBLATE components, now adding tables\n"
