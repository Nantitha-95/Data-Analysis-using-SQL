-- The analysis was performed using Google bigquery.
-- Data source: [Kaggle](https://www.kaggle.com/)

The analysis is about the World University Rankings.  
The dataset includes columns such as World rank,Institutions,National rank,Education rank,Employability rank,Faculty rank,Research rank & Score.

-- Clean & transform the dataset
-- To view all the columns in the dataset

SELECT * FROM `UniversityRankings.World_University_Rankings`
  
-- Column Education rank,Employability rank,Faculty rank,Research rank are of STRING datatype. To change it to INTEGER, first check for any NULL or missing values. All the below columns have missing values having character "-" 

-- To view only the rows without NULL or missing values.

SELECT * FROM `UniversityRankings.World_University_Rankings`
WHERE Education_Rank!="-" AND Employability_Rank!="-" AND Faculty_Rank!="-" AND Research_Rank!="-";
 

-- To change the datatype from STRING to INTEGER

SELECT World_Rank,Institution,Location,National_Rank,   
  CAST(Education_Rank AS INT64) AS Education_Rank,
  CAST(Employability_Rank AS iNT64 )AS Employability_Rank,
  CAST(Faculty_Rank AS INT64) AS Faculty_Rank,
  CAST(Research_Rank AS INT64) AS Research_Rank,
  Score
FROM `UniversityRankings.Duplicate_World_University_Rankings`;
 
-- To check for duplicate entries.
 
SELECT Institution,COUNT(Institution) as count
FROM `UniversityRankings.Changed_Datatype_table`
GROUP BY Institution
HAVING COUNT(Institution)>1;
  
-- To sort the dataset from highest to lowest WORLD_RANK, and display only the top 150 data.
 
SELECT * FROM `UniversityRankings.Changed_Datatype_table`
ORDER BY World_Rank 
LIMIT 150

-- To check for any NULL values in the sorted table

SELECT * 
FROM `UniversityRankings.SortedTable`
WHERE World_Rank is NULL or Institution is null or Location is null or National_Rank is null or Education_Rank is null or
Employability_Rank is null or Faculty_Rank is null or Research_Rank is null or Score is null;

-- Analyze the data

-- To view only the top 50 universities

SELECT * FROM my-data-project-16691.UniversityRankings.SortedTable
WHERE World_Rank<=50
ORDER BY World_Rank 

-- Count the total of each location and average score by location for the top 50 Universities  

SELECT Location,COUNT(Location) AS LOCATION_COUNT, ROUND(AVG(Score),2) AS AVERAGE_SCORE
FROM (SELECT * 
FROM `my-data-project-16691.UniversityRankings.SortedTable`
ORDER BY World_Rank LIMIT 50) 
GROUP BY Location
ORDER BY AVERAGE_SCORE DESC

-- To view the university based on their World rank followed by Education rank, Employability rank and Research rank

SELECT Institution,World_Rank,Education_Rank,Employability_Rank,Research_Rank
FROM my-data-project-16691.UniversityRankings.SortedTable
WHERE World_Rank<=50
ORDER BY World_Rank,Education_Rank,Employability_Rank,Research_Rank

