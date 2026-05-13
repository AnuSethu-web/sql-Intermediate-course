/*
SQL Course - CASE Lesson
We can add a new calculated column and use CASE to return different values depending on the data.
*/

/*
Match an exact value: return a different label depending on which hospital the patient is in.
*/

SELECT
    ps.PatientId
    ,ps.Hospital
    ,CASE ps.Hospital
        WHEN 'PRUH' THEN 'Princess Royal University Hospital'
        WHEN 'Oxleas' THEN 'Oxleas NHS Foundation Trust'
        ELSE 'Other Hospitals'
    END AS HospitalGroup
    ,ps.Ward
FROM
    dbo.PatientStay ps
ORDER BY
    HospitalGroup;

/*
Check a condition: return a different label depending on which ward the patient is in.
*/

SELECT
    ps.PatientId
    ,ps.Hospital
    ,ps.Ward
    ,CASE
        WHEN ps.Ward LIKE '%Surgery' THEN 'Surgical'
        WHEN ps.Ward IN ('Accident', 'Emergency', 'Ophthalmology') THEN 'A&E'
        ELSE 'General'
    END AS WardType
FROM
    dbo.PatientStay ps
ORDER BY
    WardType;

/*
Count rows where a condition is true using SUM with CASE.
Each row scores 1 if the condition is true, 0 if not — SUM then adds those scores up.
Starting with 100.0 (not 100) ensures the division gives a decimal result rather than a whole number.
*/

SELECT
    ps.Hospital
    ,COUNT(*) AS NumberOfPatients
    ,SUM(CASE WHEN ps.Ward LIKE '%Surgery' THEN 1 ELSE 0 END)
     AS NumberOfPatientsInSurgery
    ,(100.0 * SUM(CASE WHEN ps.Ward LIKE '%Surgery' THEN 1 ELSE 0 END)) / COUNT(*) 
    AS PercentageOfPatientsInSurgery
FROM
    dbo.PatientStay ps
GROUP BY
    ps.Hospital
ORDER BY
    ps.Hospital;


/*
Optional advanced section

Work out which financial year a patient was admitted in.
This assumes the financial year starts on 1st March.
For example, a patient admitted in January 2024 is in FY-2023-2024,
and a patient admitted in March 2024 is in FY-2024-2025.
*/

SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,CASE
        WHEN DATEPART(MONTH, ps.AdmittedDate) >= 3
            THEN CONCAT('FY-', DATEPART(YEAR, ps.AdmittedDate), '-', DATEPART(YEAR, ps.AdmittedDate) + 1)
        ELSE CONCAT('FY-', DATEPART(YEAR, ps.AdmittedDate) - 1, '-', DATEPART(YEAR, ps.AdmittedDate))
    END AS FinancialYear
FROM
    dbo.PatientStay ps
WHERE
    ps.Hospital = 'PRUH'
ORDER BY
    ps.AdmittedDate
    ,ps.PatientId;



/*
SQL Course - CASE Exercise
*/

-- Simple CASE form:   CASE <column> WHEN <value> THEN <result> ... ELSE <result> END
-- Searched CASE form: CASE WHEN <condition> THEN <result> ... ELSE <result> END

/*
Create a new column HospitalLocation
Kings College is Urban, other hospitals are Rural
Use the simple CASE form
*/

SELECT
    ps.PatientId
    ,ps.Hospital
    ,'???' AS HospitalLocation
FROM
    dbo.PatientStay ps
ORDER BY
    HospitalLocation;

/*
Create a new column WardType
Any ward that contains 'Surgery' is 'Surgical', otherwise 'Non Surgical'
Use the searched CASE form
*/

SELECT
    ps.PatientId
    ,ps.Hospital
    ,'???' AS WardType
FROM
    dbo.PatientStay ps
ORDER BY
    WardType;

/*
Create a new column PatientTariffGroup
A patient with a Tariff of 7 or more is in the 'High Tariff' group
A patient with a Tariff of 4 or more but below 7 is in the 'Medium Tariff' group
A patient with a Tariff below 4 is in the 'Low Tariff' group

Optional advanced question: how many patients are in each PatientTariffGroup?
*/

SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Tariff
    ,'???' AS PatientTariffGroup
FROM
    dbo.PatientStay ps
ORDER BY
    PatientTariffGroup
    ,ps.Tariff
    ,ps.PatientId;