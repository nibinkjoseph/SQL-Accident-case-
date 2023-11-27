select 
	[Area],
	count([AccidentIndex]) as 'Total Accident'
from accident
group by Area

select * from accident
select * from vehicle

--Question 1: How many accidents have occurred in urban areas versus rural areas?
select [Area], count([AccidentIndex]) as 'Total Accident'
from accident
group by
	Area

	--Question 2: Which day of the week has the highest number of accidents?

	select
		 DAY, count([AccidentIndex]) as 'Total Accident'

	from accident
	group by Day
	order by 'Total Accident' DESC;

--Question 3: What is the average age of vehicles involved in accidents based on their type?
SELECT
	[VehicleType],
	COUNT([AccidentIndex]) AS 'Total Accident',
	AVG([AgeVehicle]) AS "Average Age"
FROM vehicle
where AgeVehicle IS NOT NULL
group by VehicleType
ORDER BY 'Average Age' DESC;




--Question 4: Can we identify any trends in accidents based on the age of vehicles involved?

select AgeGroup, count([AccidentIndex]) as 'Total Accident',
		avg([AgeVehicle]) as 'Average Year'
from

(
select
	[AccidentIndex],
    [AgeVehicle],
	case	
		when [AgeVehicle] between 0 and 5 then 'New'
		when [AgeVehicle] between 6 and 10 then'Regular'
		else 'Old'
	end as AgeGroup
	from vehicle) as subquery

	group by AgeGroup;



	--Question 5: Are there any specific weather conditions that contribute to severe accidents?
	select
	[WeatherConditions],
	count([Severity]) as 'Total Accident'
	from accident
	where [Severity] = 'Fatal'
	group by [WeatherConditions]
	order by 'Total Accident' desc;



	--Question 5: Are there any specific weather conditions that contribute to severe accidents?
DECLARE @Sevierity varchar(100)
SET @Sevierity = 'Fatal' --Serious, Fatal, Slight

SELECT 
	[WeatherConditions],
	COUNT([Severity]) AS 'Total Accident'
FROM 
	[dbo].[accident]
WHERE 
	[Severity] = @Sevierity
GROUP BY 
	[WeatherConditions]
ORDER BY 
	'Total Accident' DESC;


	--Question 6: Do accidents often involve impacts on the left-hand side of vehicles?
SELECT 
	[LeftHand], 
	COUNT([AccidentIndex]) AS 'Total Accident'
FROM 
	[dbo].[vehicle]
GROUP BY 
	[LeftHand]
HAVING
	[LeftHand] IS NOT NULL
order by [Total Accident] desc;



--Question 7: Are there any relationships between journey purposes and the severity of accidents?
SELECT 
	V.[JourneyPurpose], 
	COUNT(A.[Severity]) AS 'Total Accident',
	CASE 
		WHEN COUNT(A.[Severity]) BETWEEN 0 AND 1000 THEN 'Low'
		WHEN COUNT(A.[Severity]) BETWEEN 1001 AND 3000 THEN 'Moderate'
		ELSE 'High'
	END AS 'Level'
FROM 
	[dbo].[accident] A
JOIN 
	[dbo].[vehicle] V ON A.[AccidentIndex] = V.[AccidentIndex]
GROUP BY 
	V.[JourneyPurpose]
ORDER BY 
	'Total Accident' DESC;


	--Question 8: Calculate the average age of vehicles involved in accidents , considering Day light and point of impact:
	select 
		a. [LightConditions],
        v. [PointImpact],
		avg([AgeVehicle]) as 'Age'
from accident a
join
vehicle v on a.AccidentIndex = v.AccidentIndex

where a.[LightConditions] = 'Daylight' and v. [PointImpact]= 'Offside'
group by 
	[PointImpact], [LightConditions]



DECLARE @Impact varchar(100)
DECLARE @Light varchar(100)
SET @Impact = 'Offside' --Did not impact, Nearside, Front, Offside, Back
SET @Light = 'Darkness' --Daylight, Darkness

SELECT 
	A.[LightConditions], 
	V.[PointImpact], 
	AVG(V.[AgeVehicle]) AS 'Average Vehicle Year'
FROM 
	[dbo].[accident] A
JOIN 
	[dbo].[vehicle] V ON A.[AccidentIndex] = V.[AccidentIndex]
GROUP BY 
	V.[PointImpact], A.[LightConditions]
HAVING 
	V.[PointImpact] = @Impact AND A.[LightConditions] = @Light;

