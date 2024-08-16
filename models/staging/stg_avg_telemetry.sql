-- Calculate average telemetry values per machine
WITH TelemetryFeatures AS (
    SELECT
        t.DATETIME,
        t.machine_id,
        t.VOLT,
        t.ROTATE,
        t.PRESSURE,
        t.VIBRATION,
        m.MODEL,
        m.AGE
    FROM
        DBT_TEST.DBO.pdm_telemetry t
    JOIN DBT_TEST.DBO.pdm_machines m ON t.machine_id = m.machine_id
)

, AvgTelemetry AS (
    SELECT
        machine_id,
        AVG(VOLT) AS AVG_VOLT,
        AVG(ROTATE) AS AVG_ROTATE,
        AVG(PRESSURE) AS AVG_PRESSURE,
        AVG(VIBRATION) AS AVG_VIBRATION
    FROM
        TelemetryFeatures
    GROUP BY
        machine_id
)

select * from AvgTelemetry
