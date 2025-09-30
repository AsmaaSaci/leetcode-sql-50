WITH FirstLogin AS (
    SELECT 
        player_id,
        MIN(event_date) AS first_date
    FROM Activity
    GROUP BY player_id
),
NextDayLogin AS (
    SELECT DISTINCT f.player_id
    FROM FirstLogin f
    JOIN Activity a
      ON f.player_id = a.player_id
     AND a.event_date = DATEADD(day, 1, f.first_date)
)
SELECT 
    ROUND(CAST(COUNT(DISTINCT n.player_id) AS DECIMAL) 
          / CAST(COUNT(DISTINCT f.player_id) AS DECIMAL), 2) AS fraction
FROM FirstLogin f
LEFT JOIN NextDayLogin n
  ON f.player_id = n.player_id;
