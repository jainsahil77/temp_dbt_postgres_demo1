-- Combine with failure data
with FailureData AS (
    SELECT
        f.DATETIME,
        f."machineID",
        f.FAILURE
    FROM
        DBT_TEST.DBO."PdM_failures" f
)

select * from FailureData
