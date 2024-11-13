# Netflix Movies and TV Shows Data Analysis using SQL
![Netflix logo](https://github.com/amit1804-hub/netflix-sql-project-/blob/main/netflix%20logo.jpeg)

Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

Objectives
Analyze the distribution of content types (movies vs TV shows).
Identify the most common ratings for movies and TV shows.
List and analyze content based on release years, countries, and durations.
Explore and categorize content based on specific criteria and keywords.
Dataset
The data for this project is sourced from the Kaggle dataset:

Dataset Link: (https://github.com/amit1804-hub/netflix-sql-project-/blob/main/netflix_titles.csv)

# Schema
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

#Business Problems and Solutions

### 1. Count the number of Movies vs TV Shows

select type ,
count(*) as total_content
from netflix
group by 1;

### 2. Find the most common rating for movies and TV shows


select  type ,rating  
from(
select type,rating,count(*),
rank () over (partition by type order by count(*) desc ) as ranking
from netflix 
group by 1 ,2)
as T1
where ranking = 1 ;

### 3. List all movies released in a specific year (e.g., 2020)

select * from netflix 
where type ilike 'Movie'
      and 
	  releas_year = 2020;







 
