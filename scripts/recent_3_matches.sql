SELECT match_id, user1_id, user2_id, matched_at
FROM tinder_app.matchs
ORDER BY matched_at DESC
LIMIT 3;
