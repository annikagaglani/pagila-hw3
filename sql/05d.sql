/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */

WITH american_circus_actors AS (
    SELECT actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'AMERICAN CIRCUS'
),
academy_dinosaur_actors AS (
    SELECT actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'ACADEMY DINOSAUR'
),
agent_truman_actors AS (
    SELECT actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'AGENT TRUMAN'
)

SELECT DISTINCT f.title
FROM film f
WHERE EXISTS (
    SELECT 1
    FROM film_actor fa
    WHERE fa.film_id = f.film_id
    AND fa.actor_id IN (SELECT actor_id FROM american_circus_actors)
)
AND EXISTS (
    SELECT 1
    FROM film_actor fa
    WHERE fa.film_id = f.film_id
    AND fa.actor_id IN (SELECT actor_id FROM academy_dinosaur_actors)
)
AND EXISTS (
    SELECT 1
    FROM film_actor fa
    WHERE fa.film_id = f.film_id
    AND fa.actor_id IN (SELECT actor_id FROM agent_truman_actors)
)
ORDER BY f.title;
