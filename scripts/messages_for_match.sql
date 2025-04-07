SELECT m.message_id,
       m.text,
       m.sent_at,
       u.name AS sender_name
FROM tinder_app.message m
         JOIN tinder_app.users u ON m.sender_id = u.user_id
WHERE m.match_id = 5
ORDER BY m.sent_at;
