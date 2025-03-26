SELECT s.target_id AS user_id,
       COUNT(*) AS like_count
FROM tinder_app.swipe s
WHERE s.swipe_type = 'like'
GROUP BY s.target_id
ORDER BY like_count DESC;
