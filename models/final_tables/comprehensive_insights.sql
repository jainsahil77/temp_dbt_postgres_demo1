-- Combine telemetry data with machine features
{{ config(materialized='table') }}

WITH TelemetryFeatures AS (
    SELECT * FROM {{ref('stg_telemetry_features')}}
  
)

-- Calculate average telemetry values per machine
, AvgTelemetry AS (
    SELECT * FROM {{ref('stg_avg_telemetry')}}
)

-- Combine with error data
, ErrorData AS (
    SELECT * FROM {{ref('stg_error_data')}}
)

-- Combine with maintenance data
, MaintenanceData AS (
    SELECT * FROM {{ref('stg_maintenance_data')}}
)

-- Combine with failure data
, FailureData AS (
    SELECT * FROM {{ref('stg_failure_data')}}
),

-- Combine all data for comprehensive insights
ComprehensiveInsights AS (
    SELECT
        tf.DATETIME,
        tf.machineid,
        tf.MODEL,
        tf.AGE,
        at.AVG_VOLT,
        at.AVG_ROTATE,
        at.AVG_PRESSURE,
        at.AVG_VIBRATION,
        ed.errorid,
        md.COMP,
        fd.FAILURE
    FROM
        TelemetryFeatures tf
    LEFT JOIN AvgTelemetry at ON tf.machineid = at.machineid
    LEFT JOIN ErrorData ed ON tf.machineid = ed.machineid AND tf.DATETIME = ed.DATETIME
    LEFT JOIN MaintenanceData md ON tf.machineid = md.machineid AND tf.DATETIME = md.DATETIME
    LEFT JOIN FailureData fd ON tf.machineid = fd.machineid AND tf.DATETIME = fd.DATETIME
)

select * from ComprehensiveInsights
