
--Q1
SELECT count(*) AS num_account FROM ACCOUNT;
--Q2
SELECT First_name, last_name, address FROM ACCOUNT, ADMIN WHERE Account_id = uid;
--Q3
SELECT count(*) AS num_account FROM (SELECT count(*) AS uid FROM RATING GROUP BY uid HAVING uid > 5) AS T; 
--Q4
SELECT count(*) AS num_movie FROM MOVIE LEFT OUTER JOIN (SELECT * FROM GENRE JOIN GENRE_OF ON gen = Genre_id where Genre = 'Romance') as g on mid = Movie_id where date_part('year', Start_year) = 2020;
--Q5
SELECT count(*) AS num_movie FROM MOVIE WHERE Start_year + interval '5 year' > '2020-10-07';
--Q6
SELECT ROUND(avg(Rating),1) AS avg_rating FROM MOVIE WHERE date_part('year', Start_year) > (date_part('year',NOW())-5);
--Q7
SELECT count(*) AS num_movie FROM MOVIE WHERE Running_time > 100; 
--Q8
SELECT original_title FROM MOVIE 
LEFT OUTER JOIN (SELECT * FROM GENRE_OF, GENRE WHERE gen = Genre_id AND Genre = 'Action' OR Genre = 'Comedy') AS G 
ON Movie_id = mid WHERE Rating IS NOT NULL ORDER BY Rating DESC LIMIT 1;
--Q9
SELECT count(*) AS num_Tv_series 
FROM (SELECT count(*) AS c, pid FROM EPISODE GROUP BY pid) AS T 
WHERE T.c > 5; 
--Q10
SELECT First_name, Last_name FROM ACCOUNT WHERE NOT EXISTS(SELECT NULL FROM RATING WHERE Account_id = uid) 
ORDER BY birthday ASC LIMIT 1;
--Q11
SELECT count(*) AS num_user FROM ACCOUNT ,(SELECT count(*) AS num_rating, uid FROM RATING GROUP BY uid) AS T
WHERE Account_id = T.uid AND T.num_rating = 1 AND Job IS NOT NULL;
--Q12 모든 배우를 대상으로 작업한 모든 영상물의 평균 평점이 8 점 이상인 배우의 이름은 무엇인가?
select Distinct actor_name from actor,(select movie_id, avg(single_rating) as AVG from rating, movie where mid=movie_id group by movie_id) as R where R.AVG>=8;
--Q13 
select Distinct actor_name,R.original_title from actor,(select Original_title, avg(single_rating) as AVG from rating, movie where date_part('year',start_year)>=2010 AND type='Movie' AND mid=movie_id group by movie_id) as R where R.AVG<6;
--Q14
select count(*) from movie,(select MAX(date_part('year',birthday)) as YOUTH from account where membership = 'prime') as Y where date_part('year',start_year)=Y.YOUTH;
--Q15
select max(start_year) from movie,(select uid,count(*) as R from rating,account where uid=account_id AND membership='premium' group by uid) as U,(select avg(single_rating) as AVG from rating,movie where mid=movie_id group by movie_id) as V where U.R>10 AND type != 'tvSeries' AND V.AVG<8;
--Q16

--Q20
select First_name, Last_name from ACCOUNT, (select count(*) as num_rating

