### The analysis was performed using Google bigquery.
### Data source: [Kaggle](https://www.kaggle.com/)

The analysis is about the World University Rankings.  
The dataset includes columns such as World rank,Institutions,National rank,Education rank,Employability rank,Faculty rank,Research rank & Score.

-- Display all the columns in the dataset

SELECT * FROM `UniversityRankings.World_University_Rankings`
  
/* Column Education rank,Employability rank,Faculty rank,Research rank are of STRING datatype. To change it to INTEGER, first check for any NULL or missing values. */

/* All the below columns have missing values having character "-" */

-- Display only the rows without NULL or missing values.

SELECT * FROM `UniversityRankings.World_University_Rankings`
WHERE Education_Rank!="-" AND Employability_Rank!="-" AND Faculty_Rank!="-" AND Research_Rank!="-";
 

-- Change the datatype from STRING to INTEGER

SELECT World_Rank,Institution,Location,National_Rank,   
  CAST(Education_Rank AS INT64) AS Education_Rank,
  CAST(Employability_Rank AS iNT64 )AS Employability_Rank,
  CAST(Faculty_Rank AS INT64) AS Faculty_Rank,
  CAST(Research_Rank AS INT64) AS Research_Rank,
  Score
FROM `UniversityRankings.Duplicate_World_University_Rankings`;
 
-- Check for duplicate entries.
 
SELECT Institution,COUNT(Institution) as count
FROM `UniversityRankings.Changed_Datatype_table`
GROUP BY Institution
HAVING COUNT(Institution)>1;
  
-- Sort the dataset from highest to lowest WORLD_RANK, and display only the top 150 data.
 
SELECT * FROM `UniversityRankings.Changed_Datatype_table`
ORDER BY World_Rank 
LIMIT 150

-- Check for any NULL values in the sorted table

SELECT * 
FROM `UniversityRankings.SortedTable`
WHERE World_Rank is NULL or Institution is null or Location is null or National_Rank is null or Education_Rank is null or
Employability_Rank is null or Faculty_Rank is null or Research_Rank is null or Score is null;

-- Analyze the data

SELECT Location,COUNT(Location) AS LOCATION_COUNT
FROM (SELECT * 
FROM `UniversityRankings.SortedTable`
ORDER BY World_Rank LIMIT 100) 
GROUP BY Location
ORDER BY LOCATION_COUNT DESC



