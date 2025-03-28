SELECT user_id, COUNT(*) AS match_count
FROM (
         SELECT user1_id AS user_id FROM tinder_app.matchs
         UNION ALL
         SELECT user2_id AS user_id FROM tinder_app.matchs
     ) all_matches
GROUP BY user_id
HAVING COUNT(*) > 0
ORDER BY match_count DESC;
