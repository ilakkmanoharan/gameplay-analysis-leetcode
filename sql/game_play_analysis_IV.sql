WITH first_login AS (
    SELECT 
        player_id,
        MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
),
next_day_login AS (
    SELECT DISTINCT
        f.player_id
    FROM first_login f
    JOIN Activity a
      ON a.player_id = f.player_id
     AND a.event_date = DATE_ADD(f.first_login, INTERVAL 1 DAY)
)
SELECT 
    ROUND(
        COUNT(next_day_login.player_id) / COUNT(first_login.player_id),
        2
    ) AS fraction
FROM first_login
LEFT JOIN next_day_login
  ON first_login.player_id = next_day_login.player_id;
