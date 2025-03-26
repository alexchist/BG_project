SELECT m.match_id,
       u1.name AS user1_name,
       u2.name AS user2_name,
       m.matched_at
FROM tinder_app.matchs m
         JOIN tinder_app.users u1 ON m.user1_id = u1.user_id
         JOIN tinder_app.users u2 ON m.user2_id = u2.user_id
ORDER BY m.matched_at DESC;
