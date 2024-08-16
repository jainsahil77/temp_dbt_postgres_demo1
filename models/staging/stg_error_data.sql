-- Combine with error data
with ErrorData AS (
    SELECT
        e.DATETIME,
        e."machineID",
        e."errorID"
    FROM
        DBT_TEST.DBO."PdM_errors" e
)

SELECT * from ErrorData