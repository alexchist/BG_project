WITH user_likes AS (
    SELECT
        u.user_id,
        u.name,
        COUNT(s.swipe_id) AS total_likes
    FROM tinder_app.users u
             LEFT JOIN tinder_app.swipe s
                       ON u.user_id = s.target_id AND s.swipe_type = 'like'
    GROUP BY u.user_id, u.name
)
SELECT
    user_id,
    name,
    total_likes,
    RANK() OVER (ORDER BY total_likes DESC) AS like_rank,
    LAG(total_likes) OVER (ORDER BY total_likes DESC) AS prev_likes
FROM user_likes
ORDER BY total_likes DESC;
