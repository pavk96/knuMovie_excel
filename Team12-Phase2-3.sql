
--Q1
SELECT count(*) AS num_account FROM ACCOUNT;

--Q2
SELECT First_name, last_name, address FROM ACCOUNT, ADMIN WHERE Account_id = uid;

--Q3
SELECT count(*) AS num_account FROM (SELECT count(*) AS uid FROM RATING GROUP BY uid HAVING uid > 5) AS T; 

--Q4
SELECT count(*) AS num_movie FROM MOVIE LEFT OUTER JOIN (
	SELECT * FROM GENRE JOIN GENRE_OF ON gen = Genre_id where Genre = 'Romance') as g 
on mid = Movie_id where date_part('year', Start_year) = 2020;

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

--Q12 (모든 배우를 대상으로) 작업한 모든 영상물의 평균 평점이 8 점 이상인 배우의 이름은 무엇인가?
SELECT Actor_name FROM ACTOR AS A WHERE
NOT EXISTS(SELECT * FROM MOVIE AS B,ACTOR_OF AS C WHERE B.Movie_id=C.mid AND A.Actor_id = C.aid AND 
	NOT EXISTS(SELECT * FROM MOVIE AS D WHERE B.Movie_id = D.Movie_id AND D.Rating >= 8));
--Q13 
SELECT DISTINCT Actor_name, Original_title FROM MOVIE, ACTOR_OF AS A, ACTOR, GENRE, GENRE_OF AS G 
WHERE A.mid=Movie_id AND A.aid=Actor_id AND G.gen=Genre_id AND G.mid = Movie_id 
AND Genre != 'Action' AND Rating < 6 AND Type = 'movie' AND date_part('year',start_year)>=2010;

--Q14
select count(*) from movie,(select MAX(date_part('year',birthday)) as YOUTH 
	from account,membership where sid = Membership_id AND membership_name = 'prime') as Y where date_part('year',start_year)=Y.YOUTH;

--Q15
select max(start_year) from (select uid, count(*) as R from membership,rating, movie, account 
	where sid=Membership_id AND Membership_name = 'premium' 
	AND mid = movie_id AND rating<8 AND type != 'tvSeries' group by uid) as F, movie;

--Q16
SELECT Phone 
FROM ACCOUNT AS A, (SELECT uid FROM RATING, MOVIE WHERE mid=Movie_id AND Rating = (SELECT max(Rating) FROM MOVIE))AS T
WHERE uid=A.Account_id AND length(A.Address) = (SELECT max(length(B.Address)) FROM ACCOUNT AS B);

--Q17 
select count(*) from movie as Q,(SELECT Movie_id, MIN(Start_year), rating FROM MOVIE, ACTOR_OF AS A,
(SELECT (ROW_NUMBER() OVER(ORDER BY num_filmed DESC)) AS ROW, * FROM
(SELECT num_filmed, aid FROM
(SELECT count(*) AS num_filmed,aid FROM ACTOR_OF GROUP BY aid ORDER BY num_filmed LIMIT 10) AS T1) AS T2
) AS T3 WHERE ROW = 3 AND T3.aid = A.aid AND A.mid = Movie_id 
group by movie_id) as T4 where Q.rating<T4.rating+1 AND Q.rating>T4.rating-1;

--Q18


SELECT M.Rating FROM MOVIE AS M,
(SELECT count(*) AS num_version,M2.Movie_id as m2id FROM MOVIE AS M2, VERSION WHERE M2.Movie_id=mid GROUP BY M2.Movie_id) AS T1,
(SELECT count(*) AS num_actor, M3.Movie_id as m3id FROM MOVIE AS M3, ACTOR_OF WHERE M3.Movie_id=mid GROUP BY M3.MOVIE_ID) AS T2, 
(SELECT M4.Movie_id FROM MOVIE AS M4 WHERE M4.Type = 'movie' OR M4.Type = 'tvSeries') AS T3
WHERE M.Movie_id = m2id 
AND M.Movie_id = m3id AND num_version >= 5 AND num_version <= 10 AND num_actor <= 5 AND M.Movie_id = T3.Movie_id;
--Q19
select original_title from movie,(select mid, running_time from movie, (select (ROW_NUMBER() OVER(ORDER BY rate DESC)) as ROW,* from (select mid, rating as rate from movie, actor_of as A,(select aid, Max(rating) from movie,actor_of,actor where mid=movie_id AND aid=actor_id group by aid) as T1 where mid=movie_id AND A.aid= T1.aid) as T2) as T3 where T3.ROW =2 AND T3.mid = movie_id) as T4 where T4.mid= movie_id;
--Q20 
select First_name,Last_name from account,(select start_year from movie,(select movie_id, count(uid) as G from rating, movie,genre_of,(select gen from genre_of,(select mid, Max(T4.B) as F from (select mid, count(uid) as B from rating,(select movie_id,account_id from account,rating,movie,(select T1.movie_id as T1M, MAX(T1.C) as M from(select movie_id, count(uid) as C from rating,movie,account where sex='Female' AND account_id = uid AND movie_id = mid group by movie_id) as T1  group by movie_id order by M desc) as T2 where sex='Male' AND uid= account_id AND mid = movie_id AND movie_id = T2.T1M)as T3 where T3.account_id=uid AND mid = T3.movie_id group by mid) as T4 group by mid order by F desc limit 1) as T5 where genre_of.mid = T5.mid) as T6 where T6.gen = genre_of.gen AND genre_of.mid = movie_id AND rating.mid=movie_id group by movie_id order by G asc limit 1) as T7 where movie.movie_id = T7.movie_id) as T8 where account.birthday = T8.start_year;

