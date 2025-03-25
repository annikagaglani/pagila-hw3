/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */

WITH american_circus_categories AS (
    SELECT fc.category_id
    FROM film_category fc
    JOIN film f ON fc.film_id = f.film_id
    WHERE f.title = 'AMERICAN CIRCUS'
),
american_circus_actors AS (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title = 'AMERICAN CIRCUS'
),
movies_with_categories AS (
    SELECT f.film_id, f.title
    FROM film f
    JOIN film_category fc1 ON f.film_id = fc1.film_id
    JOIN film_category fc2 ON f.film_id = fc2.film_id
    WHERE fc1.category_id IN (SELECT category_id FROM american_circus_categories)
      AND fc2.category_id IN (SELECT category_id FROM american_circus_categories)
      AND fc1.category_id <> fc2.category_id
    GROUP BY f.film_id, f.title
    HAVING COUNT(DISTINCT fc1.category_id) = 2
),
movies_with_actors AS (
    SELECT f.film_id, f.title
    FROM film f
    JOIN film_actor fa ON f.film_id = fa.film_id
    WHERE fa.actor_id IN (SELECT actor_id FROM american_circus_actors)
    GROUP BY f.film_id, f.title
    HAVING COUNT(DISTINCT fa.actor_id) >= 1
)
SELECT DISTINCT mwc.title
FROM movies_with_categories mwc
JOIN movies_with_actors mwa ON mwc.film_id = mwa.film_id
UNION
SELECT 'AMERICAN CIRCUS' AS title
ORDER BY title;

