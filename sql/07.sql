/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

SELECT DISTINCT CONCAT(a1.first_name, ' ', a1.last_name) AS "Actor Name"
FROM actor a1
JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
JOIN film f1 ON fa1.film_id = f1.film_id
WHERE f1.film_id IN (
    SELECT f2.film_id
    FROM film f2
    JOIN film_actor fa2 ON f2.film_id = fa2.film_id
    JOIN actor a2 ON fa2.actor_id = a2.actor_id
    WHERE a2.actor_id IN (
        SELECT a3.actor_id
        FROM actor a3
        JOIN film_actor fa3 ON a3.actor_id = fa3.actor_id
        JOIN film f3 ON fa3.film_id = f3.film_id
        WHERE f3.film_id IN (
            SELECT f4.film_id
            FROM film f4
            JOIN film_actor fa4 ON f4.film_id = fa4.film_id
            JOIN actor a4 ON fa4.actor_id = a4.actor_id
            WHERE a4.first_name = 'RUSSELL' AND a4.last_name = 'BACALL'
        )
        AND (a3.first_name != 'RUSSELL' OR a3.last_name != 'BACALL')
    )
)
AND (a1.first_name != 'RUSSELL' OR a1.last_name != 'BACALL')
AND a1.actor_id NOT IN (
    SELECT a5.actor_id
    FROM actor a5
    JOIN film_actor fa5 ON a5.actor_id = fa5.actor_id
    JOIN film f5 ON fa5.film_id = f5.film_id
    WHERE f5.film_id IN (
        SELECT f6.film_id
        FROM film f6
        JOIN film_actor fa6 ON f6.film_id = fa6.film_id
        JOIN actor a6 ON fa6.actor_id = a6.actor_id
        WHERE a6.first_name = 'RUSSELL' AND a6.last_name = 'BACALL'
    )
)
ORDER BY "Actor Name" ASC;

