-- Calculate average telemetry values per machine
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

, AvgTelemetry AS (
    SELECT
        "machineID",
        AVG(VOLT) AS AVG_VOLT,
        AVG(ROTATE) AS AVG_ROTATE,
        AVG(PRESSURE) AS AVG_PRESSURE,
        AVG(VIBRATION) AS AVG_VIBRATION
    FROM
        TelemetryFeatures
    GROUP BY
        "machineID"
)

select * from AvgTelemetry