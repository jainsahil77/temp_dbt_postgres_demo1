-- Combine with failure data
with FailureData AS (
    SELECT
        f.DATETIME,
        f.machine_id,
        f.FAILURE
    FROM
        DBT_TEST.DBO.pdm_failures f
)

select * from FailureData
