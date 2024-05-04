-- Use CETAS to export select statement
IF OBJECT_ID('dbo.dim_station') IS NOT NULL
BEGIN
  DROP EXTERNAL TABLE [dbo].[dim_station];
END

CREATE EXTERNAL TABLE dbo.dim_station
WITH (
    LOCATION    = 'dim_station',
    DATA_SOURCE = [azdlfs_azdl12_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT station_id, name, latitude, longitude
FROM [dbo].[staging_station];
GO

-- Query the newly created CETAS external table
SELECT TOP 100 * FROM dbo.dim_station
GO