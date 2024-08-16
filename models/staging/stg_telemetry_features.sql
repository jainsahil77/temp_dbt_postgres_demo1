-- Combine telemetry data with machine features
WITH TelemetryFeatures AS (
    SELECT
        t.DATETIME,
        t."machineID",
        t.VOLT,
        t.ROTATE,
        t.PRESSURE,
        t.VIBRATION,
        m.MODEL,
        m.AGE
    FROM
        DBT_TEST.DBO."PdM_telemetry" t
    JOIN DBT_TEST.DBO."PdM_machines" m ON t."machineID" = m."machineID"
)

select * from TelemetryFeatures