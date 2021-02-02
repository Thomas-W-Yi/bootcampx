SELECT cohorts.name as cohort, count(assignment_submissions.*) as total_submissions
FROM assignment_submissions
JOIN students ON students.id = student_id
join cohorts on cohorts.id = cohort_id
where students.end_date is null
GROUP BY cohorts.name

-- SELECT students.name as student, COUNT(assignment_submissions.id) as total_submissions
-- FROM assignment_submissions
-- JOIN students ON student_id = students.id
-- group by student
-- order by student;

SELECT name
FROM world
WHERE continent = 'Europe' AND gdp/population > (SELECT gdp/population FROM world WHERE name = 'United Kingdom')

SELECT name,  continent 
FROM world
WHERE continent = (SELECT continent FROM world WHERE name = 'Argentina') OR continent = (SELECT continent FROM world WHERE name = 'Australia')

SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND population < (SELECT population FROM world WHERE name = 'Poland')

SELECT name, CONCAT(Round(population*100/(SELECT population FROM world WHERE name = 'Germany')), '%') as percentage
FROM world
WHERE continent = 'Europe'

SELECT name
FROM world as x
WHERE gdp > (SELECT MAX(gdp) FROM world WHERE continent = 'Europe' )

SELECT continent, name
FROM world as x
WHERE name = (SELECT TOP 1 name FROM world as y WHERE x.continent = y.continent)

SELECT continent, name, population 
FROM world as x
WHERE area = (SELECT MAX(area) FROM world as y WHERE x.continent = y.continent)

SELECT name, continent, population
FROM world
WHERE (SELECT count(name) as total_country, continent FROM world group by continent).total_country = (SELECT count(name) as total_country_p FROM world as y WHERE population <=25000000 group by continent).

SELECT continent
FROM (SELECT count(name) as total_country, continent FROM world group by continent) as x
WHERE x.total_country = (SELECT total_country_p FROM (SELECT count(name) as total_country_p, continent FROM world WHERE population <=25000000 group by continent) as y WHERE x.continent = y.continent)


-- Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
SELECT name, continent, population
FROM world
WHERE continent IN (SELECT continent
FROM (SELECT count(name) as total_country, continent FROM world group by continent) as x
WHERE x.total_country = (SELECT total_country_p FROM (SELECT count(name) as total_country_p, continent FROM world WHERE population <=25000000 group by continent) as y WHERE x.continent = y.continent))


-- Some countries have populations more than three times that of any of their neighbours (in the same continent). Give the countries and continents.
SELECT name, continent
from (SELECT continent, name, population
FROM world as x
WHERE population IN (SELECT TOP 2 population FROM world as y WHERE x.continent = y.continent ORDER BY population DESC)) as a
WHERE population/3 > (SELECT TOP 1 population FROM (SELECT continent, name, population
FROM world as x
WHERE population IN (SELECT TOP 2 population FROM world as y WHERE x.continent = y.continent ORDER BY population DESC)) as b where a.continent = b.continent ORDER BY population)