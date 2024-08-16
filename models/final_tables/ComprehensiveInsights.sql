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
        tf."machineID",
        tf.MODEL,
        tf.AGE,
        at.AVG_VOLT,
        at.AVG_ROTATE,
        at.AVG_PRESSURE,
        at.AVG_VIBRATION,
        ed."errorID",
        md.COMP,
        fd.FAILURE
    FROM
        TelemetryFeatures tf
    LEFT JOIN AvgTelemetry at ON tf."machineID" = at."machineID"
    LEFT JOIN ErrorData ed ON tf."machineID" = ed."machineID" AND tf.DATETIME = ed.DATETIME
    LEFT JOIN MaintenanceData md ON tf."machineID" = md."machineID" AND tf.DATETIME = md.DATETIME
    LEFT JOIN FailureData fd ON tf."machineID" = fd."machineID" AND tf.DATETIME = fd.DATETIME
)

select * from ComprehensiveInsights