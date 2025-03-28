CREATE SCHEMA IF NOT EXISTS tinder_app;

CREATE TABLE IF NOT EXISTS tinder_app.Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    gender CHAR(1) NOT NULL CHECK (gender IN ('M','F','O')),
    birth_date DATE NOT NULL,
    bio TEXT,
    location VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS tinder_app.Preference (
    preference_id INT PRIMARY KEY,
    user_id INT,
    preferred_gender CHAR(1) CHECK (preferred_gender IN ('M','F','O')),
    age_min INT NOT NULL,
    age_max INT NOT NULL,
    distance_km INT NOT NULL,
    valid_from TIMESTAMP NOT NULL,
    valid_to TIMESTAMP NULL,
    is_current BOOLEAN NOT NULL,
    FOREIGN KEY (user_id) REFERENCES tinder_app.Users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS tinder_app.Profile_photo (
    photo_id INT PRIMARY KEY,
    user_id INT,
    photo_url VARCHAR(255) NOT NULL,
    is_main BOOLEAN NOT NULL DEFAULT FALSE,
    uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES tinder_app.Users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS tinder_app.Swipe (
    swipe_id INT PRIMARY KEY,
    swiper_id INT,
    target_id INT,
    swipe_type VARCHAR(10) NOT NULL CHECK (swipe_type IN ('like','dislike')),
    swipe_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (swiper_id) REFERENCES tinder_app.Users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (target_id) REFERENCES tinder_app.Users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS tinder_app.Matchs (
    match_id INT PRIMARY KEY,
    swipe_id INT,
    user1_id INT NOT NULL,
    user2_id INT NOT NULL CHECK (user1_id <> user2_id),
    matched_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (swipe_id) REFERENCES tinder_app.Swipe(swipe_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS tinder_app.Message (
    message_id INT PRIMARY KEY,
    match_id INT NOT NULL,
    sender_id INT NOT NULL,
    text TEXT NOT NULL,
    sent_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (match_id) REFERENCES tinder_app.Matchs(match_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES tinder_app.Users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    );


