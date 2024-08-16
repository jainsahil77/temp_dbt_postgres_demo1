-- Combine with maintenance data
with MaintenanceData AS (
    SELECT
        m.DATETIME,
        m."machineID",
        m.COMP
    FROM
        DBT_TEST.DBO."PdM_maint" m
)

select * from MaintenanceData