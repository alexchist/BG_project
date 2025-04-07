SELECT u.user_id,
       u.name,
       u.email,
       p.photo_url
FROM tinder_app.users u
         JOIN tinder_app.profile_photo p
              ON u.user_id = p.user_id
WHERE p.is_main = TRUE;
