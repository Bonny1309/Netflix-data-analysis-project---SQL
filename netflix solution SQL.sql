create table netflix (
show_id varchar(6),
type varchar(10),
title varchar(150),
director varchar(208),
casts varchar(1000),
country varchar(150),
date_added varchar(100),
release_year int,
rating varchar(10),
duration varchar(15),
listed_in varchar (100),
description varchar (250)
);

select * from netflix;
select count (*) from netflix;

-- 1. Count the number of Movies vs TV Shows

select type, count(type)
from netflix
group by type;

-- 2. Find the most common rating for movies and TV shows
select * from netflix

select * from 
(select type,rating, count(*),
dense_rank() over(partition by type order by count(*) desc) as rk
from netflix
group by type, rating) as a
where rk = 1;


-- 3. List all movies released in a specific year (e.g., 2020)
select * from netflix;

select * from netflix
where release_year = 2020 and type = 'Movie';


-- 4. Find the top 5 countries with the most content on Netflix
select * from netflix;

select country, count(*)
from netflix
group by country
order by count(*) desc

select unnest(string_to_array(country,','))as new_country, count (show_id)
from netflix
group by new_country
order by 2 desc
limit 5;


-- 5. Identify the longest movie
select * from netflix;

select title, duration, substring(duration FROM 1 FOR POSITION (' ' IN duration)-1)as d
from  netflix
where type = 'Movie'
order by 3 desc;


-- 6. Find content added in the last 5 years
select * from netflix

select type, title, date_added
from netflix
where date_added > adddate(curdate(),interval -5 year)


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

select type, title, director
from netflix
where director like '%Rajiv Chilaka%'


-- 8. List all TV shows with more than 5 seasons
select type, title, duration
from netflix
where type = 'TV Show' and left(duration,1) > '5'


select type, title, duration,split_part(duration,' ',1)::int as seasons
from netflix
where type = 'TV Show' and split_part(duration,' ',1)::int > 5

-- 9. Count the number of content items in each genre
select * from netflix

select unnest(string_to_array(listed_in,','))as genre, count(*)
from netflix
group by genre


-- 10. Find each year and the average numbers of content release by India on netflix. 
-- return top 5 year with highest avg content release !

select * from netflix

select release year, avg(cnt) from
(select release_year,count(show_id) as cnt
from netflix)
group by release_year


-- 11. List all movies that are documentaries
select * from netflix

select type, title, listed_in
from netflix
where type = 'Movie' and listed_in ilike '%Documentaries'


-- 12. Find all content without a director
select * from netflix
where director is null;


-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select * from netflix

select type, title, casts, release_year
from netflix
where type='Movie' and casts like '%Salman Khan%' and release_year > extract(year from current_date) - 10


-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
select unnest(string_to_array(casts,',')) as actors, count(show_id)
from netflix
where country = 'India'
group by actors
order by 2 desc
limit 10;

-- Question 15:
-- Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'.

select * from netflix

select type, title, case
when description ilike '%kill%' or description ilike '%violence%' then 'bad'
else 'good'
end as catagory
from netflix








