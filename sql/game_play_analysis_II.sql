SELECT 
    a.player_id,
    a.device_id
FROM Activity AS a
JOIN (
    SELECT 
        player_id,
        MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
) AS f
ON a.player_id = f.player_id
AND a.event_date = f.first_login;

