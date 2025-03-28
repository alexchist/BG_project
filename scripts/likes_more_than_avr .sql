SELECT
    u.user_id,
    u.name,
    (SELECT COUNT(*)
     FROM tinder_app.swipe s
     WHERE s.target_id = u.user_id AND s.swipe_type = 'like'
    ) AS likes
FROM tinder_app.users u
WHERE (SELECT COUNT(*)
       FROM tinder_app.swipe s
       WHERE s.target_id = u.user_id AND s.swipe_type = 'like'
      ) > (
          SELECT AVG(lc)
          FROM (
                   SELECT COUNT(*) AS lc
                   FROM tinder_app.swipe
                   WHERE swipe_type = 'like'
                   GROUP BY target_id
               ) t
      )
  AND EXISTS (
    SELECT 1
    FROM tinder_app.matchs m
    WHERE m.user1_id = u.user_id OR m.user2_id = u.user_id
);
