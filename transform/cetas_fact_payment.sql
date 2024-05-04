-- Use CETAS to export select statement
IF OBJECT_ID('dbo.fact_payment') IS NOT NULL
BEGIN
  DROP EXTERNAL TABLE [dbo].[fact_payment];
END

CREATE EXTERNAL TABLE dbo.fact_payment
WITH (
    LOCATION    = 'fact_payment',
    DATA_SOURCE = [azdlfs_azdl12_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT payment_id, date AS payment_date, amount, rider_id
FROM [dbo].[staging_payment];
GO

-- Query the newly created CETAS external table
SELECT TOP 100 * FROM dbo.fact_payment
GO