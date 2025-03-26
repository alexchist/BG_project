-- query8_latest_message_per_match.sql
SELECT m.match_id,
       m.message_id,
       m.text,
       m.sent_at
FROM tinder_app.message m
WHERE m.sent_at = (
    SELECT MAX(sent_at)
    FROM tinder_app.message m2
    WHERE m2.match_id = m.match_id
)
ORDER BY m.match_id;
