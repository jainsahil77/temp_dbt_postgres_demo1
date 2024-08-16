-- Combine with error data
with ErrorData AS (
    SELECT
        e.DATETIME,
        e.machine_id,
        e.error_id
    FROM
        DBT_TEST.DBO.pdm_errors e
)

SELECT * from ErrorData
