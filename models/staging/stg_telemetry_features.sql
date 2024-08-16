-- Combine telemetry data with machine features
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

select * from TelemetryFeatures
