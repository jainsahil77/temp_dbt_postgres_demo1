-- Combine with maintenance data
with MaintenanceData AS (
    SELECT
        m.DATETIME,
        m.machine_id,
        m.COMP
    FROM
        DBT_TEST.DBO.pdm_maint m
)

select * from MaintenanceData
