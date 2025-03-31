
DROP TABLE account;
DROP TABLE checkin_location;
DROP TABLE user_check_in;
DROP TABLE user_followers;
DROP TABLE following;
DROP TABLE user;

CREATE TABLE user(
  user_ID VARCHAR(5),
  user_name VARCHAR(50),
  user_email VARCHAR(50),
  PRIMARY KEY(user_ID)
);

CREATE TABLE account(
  account_ID INTEGER,
  user_ID VARCHAR(5),
  account_handle VARCHAR(25), -- Account's name?
  social_media_account_type VARCHAR(30),
  profile_url VARCHAR(50),
  PRIMARY KEY(account_ID),
  FOREIGN KEY (user_ID) REFERENCES user(user_ID)
);

CREATE TABLE user_check_in(
  check_in_ID INTEGER,
  user_ID VARCHAR(5),
  PRIMARY KEY (check_in_ID),
  FOREIGN KEY (user_ID) REFERENCES user(user_ID)
);

CREATE TABLE checkin_location (
  check_in_ID INTEGER,  
  place VARCHAR(30),
  city VARCHAR(30),
  country VARCHAR(30),
  last_checkin INTEGER,
  PRIMARY KEY (check_in_ID, place),  -- Composite key allows multiple locations per check-in
  FOREIGN KEY (check_in_ID) REFERENCES user_check_in(check_in_ID)
);

CREATE TABLE following(
  user_ID VARCHAR(5),
  follower_ID VARCHAR(5),
  PRIMARY KEY(user_ID, follower_ID),
  FOREIGN KEY (user_ID) REFERENCES user(user_ID),
  FOREIGN KEY (follower_ID) REFERENCES user(user_ID)
);

CREATE TABLE user_followers(
  followed_ID VARCHAR(5),
  follower_ID VARCHAR(5),
  PRIMARY KEY(follower_ID, followed_ID),
  FOREIGN KEY (follower_ID) REFERENCES following(follower_ID),
  FOREIGN KEY (followed_ID) REFERENCES user(user_ID)
);

INSERT INTO user(user_ID, user_name, user_email) VALUES
('T312', 'Alex Turner', 'AlexT@company.com'),
('L520', 'Mia Chen', 'MiaChen@domain.co.uk'),
('Q789', 'Leo Sanchez', 'Leo.Sanchez@webmail.com'),
('Y120', 'Johnny Bravo', 'Johnny.Bravo@webmail.com'),
('P120', 'Sophia Wong', 'SophiaW@yahoo.com'),
('R543', 'Peter Parker', 'Parker@yahoo.com');

INSERT INTO account(account_ID, user_ID, account_handle, social_media_account_type, profile_url) VALUES
(238, 'T312', 'xy5z09', 'Photographer', 'mySoMe.com/xy5z09'),
(456, 'L520', 'bh3f67', 'Public Figure', 'mySoMe.com/bh3f67'),
(863, 'Q789', 'lp9x34', 'Business', 'mySoMe.com/lp9x34'),
(429, 'Y120', 'ab4s12', 'Private', 'mySoMe.com/ab4s12');

INSERT INTO user_check_in(check_in_ID, user_ID) VALUES
(1, 'T312'),
(2, 'L520'),
(3, 'Q789'),
(4, 'P120');

INSERT INTO checkin_location(check_in_ID, place, city, country, last_checkin) VALUES
(2, 'Big Ben', 'London', 'UK', 0),
(2, 'Brandenburg Gate', 'Berlin', 'Germany', 1),
(3, 'Times Square', 'New York', 'USA', 0),
(3, 'Royal Palace', 'Madrid', 'Spain', 1),
(4, 'Sydney Opera House', 'Sydney', 'Australia', 0),
(4, 'Marina Bay Sands', 'Singapore', NULL, 1);

INSERT INTO following(user_ID, follower_ID) VALUES
('T312', 'R543'),
('L520', 'Q789'),
('Q789', 'T312'),
('P120', 'Q789'),
('P120', 'R543');

INSERT INTO user_followers(followed_ID, follower_ID) VALUES
('Y120', 'R543'),
('Y120', 'Q789'),
('Y120', 'T312');

SELECT user.user_name, COUNT(user_followers.follower_ID) AS total_followers
FROM user
LEFT JOIN user_followers ON user.user_ID = user_followers.followed_ID
LEFT JOIN user_check_in ON user.user_ID = user_check_in.user_ID
GROUP BY user.user_ID, user.user_name
ORDER BY user.user_name ASC, total_followers DESC;