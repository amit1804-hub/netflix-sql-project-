create table netflix
(
show_id varchar(15),
type varchar(200),
title varchar(250),
director varchar(250),
casts varchar(1000), 
country varchar(150),
data_added varchar(50),
releas_year  int ,
rating varchar(20),
duration varchar(30),
listed_in varchar(150),
description varchar(350)
);

select * from netflix;


1. Count the number of Movies vs TV Shows

select type ,
count(*) as total_content
from netflix
group by 1;

2. Find the most common rating for movies and TV shows


select  type ,rating  
from(
select type,rating,count(*),
rank () over (partition by type order by count(*) desc ) as ranking
from netflix 
group by 1 ,2)
as T1
where ranking = 1 ;

3. List all movies released in a specific year (e.g., 2020)


select * from netflix 
where type ilike 'Movie'
      and 
	  releas_year = 2020;

4. Find the top 5 countries with the most content on Netflix

 select 
unnest (string_to_array(country,',')) as new_country,
count(show_id) as total_content
from netflix
group by 1
order by 2 desc 
limit 5

5. Identify the longest movie


select type,title,duration from 
netflix
where type ilike 'movie'
      and
	  duration =(select max(duration) from netflix);

6. Find content added in the last 5 years


select * from netflix
where TO_DATE(date_added ,'Month dd,yyyy') >= current_date - INTERVAL '5 year';

7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

select * from netflix
where director ilike 'Rajiv Chilaka';

8. List all TV shows with more than 5 seasons


select * from netflix
where type = 'TV Show'
    and 
	split_part(duration ,' ',1):: numeric > 5;

9. Count the number of content items in each genre


select * from netflix

select
unnest(string_to_array(listed_in,',')) as genre,
count (show_id) as total_content
from netflix
group by 1
order by 2 desc;

10.Find each year and the average numbers of content release in India on netflix return top 5 year with highest avg content release!

select 
extract(year from To_date(Date_added ,'Month dd,yyyy')) as year,
count(*),
round (count(*)::numeric /(select count(*)from netflix where country ='India') * 100 ,2)as avg_per_year
from netflix
where country = 'India'
group by 1;

11. List all movies that are documentaries

select  * from netflix
where listed_in ilike 'documentaries' ;

12. Find all content without a director

select * from netflix
where director is null;

13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

select * from netflix
where casts ilike '%salman khan%'
and release_year > extract(year from current_date) - 10;

14. Find the top 10 actors who have appeared in the highest number of movies produced in India.


select unnest(string_to_array(casts ,',')) as actors 
,count(*) as total_content
from netflix
where country ilike 'india'
group by actors
order by total_content desc 
limit 10;

15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.

with new_category as
(select
case 
   when description ilike '%kill%' or description ilike '%violence%'
   then 'bad_content'
   else 'good_content'
end category
from netflix)
select category, count(*)
from new_category
group by 1
order by 2 desc;


























 
















