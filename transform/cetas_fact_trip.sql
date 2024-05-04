-- Use CETAS to export select statement
IF OBJECT_ID('dbo.fact_trip') IS NOT NULL BEGIN DROP EXTERNAL TABLE [dbo].[fact_trip];
END CREATE EXTERNAL TABLE dbo.fact_trip WITH (
  LOCATION = 'fact_trip',
  DATA_SOURCE = [azdlfs_azdl12_dfs_core_windows_net],
  FILE_FORMAT = [SynapseDelimitedTextFormat]
) AS
SELECT st.trip_id,
  st.rider_id,
  st.rideable_type,
  st.start_at started_at,
  st.ended_at,
  st.start_station_id,
  st.end_station_id,
  DATEDIFF(HOUR, st.start_at, st.ended_at) AS duration,
  DATEDIFF(YEAR, sr.birthday, st.start_at) AS rider_age
FROM [dbo].[staging_trip] st
  JOIN [dbo].[staging_rider] sr ON sr.rider_id = st.rider_id;
GO -- Query the newly created CETAS external table
SELECT TOP 100 *
FROM dbo.fact_trip
GO