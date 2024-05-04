-- Use CETAS to export select statement
IF OBJECT_ID('dbo.dim_date') IS NOT NULL BEGIN DROP EXTERNAL TABLE [dbo].[dim_date];
END CREATE EXTERNAL TABLE dbo.dim_date WITH (
  LOCATION = 'dim_date',
  DATA_SOURCE = [azdlfs_azdl12_dfs_core_windows_net],
  FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS
SELECT NEWID() AS time_id,
  start_at AS date,
  DATEPART(WEEKDAY, start_at) day_of_week,
  DATEPART(DAY, start_at) day_of_month,
  DATEPART(WEEK, start_at) week_of_year,
  DATEPART(QUARTER, start_at) quarter,
  DATEPART(MONTH, start_at) month,
  DATEPART(YEAR, start_at) year
FROM [dbo].[staging_trip]
WHERE start_at IS NOT NULL
UNION
SELECT NEWID() AS time_id,
  ended_at AS date,
  DATEPART(WEEKDAY, ended_at) day_of_week,
  DATEPART(DAY, ended_at) day_of_month,
  DATEPART(WEEK, ended_at) week_of_year,
  DATEPART(QUARTER, ended_at) quarter,
  DATEPART(MONTH, ended_at) month,
  DATEPART(YEAR, ended_at) year
FROM [dbo].[staging_trip]
WHERE ended_at IS NOT NULL
UNION
SELECT NEWID() AS time_id,
  birthday AS date,
  DATEPART(WEEKDAY, birthday) day_of_week,
  DATEPART(DAY, birthday) day_of_month,
  DATEPART(WEEK, birthday) week_of_year,
  DATEPART(QUARTER, birthday) quarter,
  DATEPART(MONTH, birthday) month,
  DATEPART(YEAR, birthday) year
FROM [dbo].[staging_rider]
WHERE birthday IS NOT NULL
UNION
SELECT NEWID() AS time_id,
  account_start_date AS date,
  DATEPART(WEEKDAY, account_start_date) day_of_week,
  DATEPART(DAY, account_start_date) day_of_month,
  DATEPART(WEEK, account_start_date) week_of_year,
  DATEPART(QUARTER, account_start_date) quarter,
  DATEPART(MONTH, account_start_date) month,
  DATEPART(YEAR, account_start_date) year
FROM [dbo].[staging_rider]
WHERE account_start_date IS NOT NULL
UNION
SELECT NEWID() AS time_id,
  account_end_date AS date,
  DATEPART(WEEKDAY, account_end_date) day_of_week,
  DATEPART(DAY, account_end_date) day_of_month,
  DATEPART(WEEK, account_end_date) week_of_year,
  DATEPART(QUARTER, account_end_date) quarter,
  DATEPART(MONTH, account_end_date) month,
  DATEPART(YEAR, account_end_date) year
FROM [dbo].[staging_rider]
WHERE account_end_date IS NOT NULL
UNION
SELECT NEWID() AS time_id,
  date,
  DATEPART(WEEKDAY, date) day_of_week,
  DATEPART(DAY, date) day_of_month,
  DATEPART(WEEK, date) week_of_year,
  DATEPART(QUARTER, date) quarter,
  DATEPART(MONTH, date) month,
  DATEPART(YEAR, date) year
FROM [dbo].[staging_payment]
WHERE date IS NOT NULL
GO
SELECT TOP 100 *
FROM dbo.dim_date
ORDER BY date
GO