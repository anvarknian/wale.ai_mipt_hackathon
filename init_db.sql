-- Create 'countries' table
CREATE TABLE countries
(
    id             INTEGER PRIMARY KEY,
    name           TEXT NOT NULL,
    continent_name TEXT NOT NULL
);
INSERT INTO countries (name, continent_name)
VALUES ('United States', 'North America'),
       ('United Kingdom', 'Europe'),
       ('Canada', 'North America');
       
-- Create 'event_types' table
CREATE TABLE event_types
(
    id         INTEGER PRIMARY KEY,
    event_type TEXT NOT NULL
);
INSERT INTO event_types (event_type)
VALUES ('Platform'),
       ('Company'),
       ('Fund');
       
-- Create 'feed_types' table
CREATE TABLE feed_types
(
    id        INTEGER PRIMARY KEY,
    feed_type TEXT NOT NULL
);
INSERT INTO feed_types (feed_type)
VALUES ('comment'),
       ('like'),
       ('share'),
       ('report');

-- Create 'users' table
CREATE TABLE users
(
    id                INTEGER PRIMARY KEY,
    phone_number      TEXT NOT NULL,
    username          TEXT NOT NULL,
    email             TEXT NOT NULL,
    password          TEXT NOT NULL,
    registration_date DATE NOT NULL,
    country_id        INTEGER,
    FOREIGN KEY (country_id) REFERENCES countries (id)
);
INSERT INTO users (phone_number, username, email, password, registration_date, country_id)
VALUES ('123456789', 'johnDoe', 'johndoe@example.com', 'password1', '2023-06-01', 1),
       ('987654321', 'janeSmith', 'janesmith@example.com', 'password2', '2023-06-02', 2),
       ('555555555', 'bobJohnson', 'bobjohnson@example.com', 'password3', '2023-06-03', 1);


-- Create 'companies' table
CREATE TABLE companies
(
    id           INTEGER PRIMARY KEY,
    company_name TEXT NOT NULL
);
INSERT INTO companies (company_name)
VALUES ('Company A'),
       ('Company B'),
       ('Company C');

-- Create 'watchlist' table
CREATE TABLE watchlist
(
    id          INTEGER PRIMARY KEY,
    user_id     INTEGER NOT NULL,
    company_ids TEXT    NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id)
);
INSERT INTO watchlist (user_id, company_ids)
VALUES (1, json('["1", "2"]')),
       (2, json('["3"]')),
       (3, json('["3", "2"]'));


-- Create 'tags' table
CREATE TABLE tags
(
    id            INTEGER PRIMARY KEY,
    company_id    INTEGER NOT NULL,
    tags_values   TEXT    NOT NULL,
    creation_date DATE    NOT NULL,
    FOREIGN KEY (company_id) REFERENCES companies (id)
);
INSERT INTO tags (company_id, tags_values, creation_date)
VALUES (1, 'technology, software', '2023-06-01'),
       (2, 'finance, banking', '2023-06-02'),
       (3, 'healthcare, medical', '2023-06-03');

-- Create 'company_feed' table
CREATE TABLE company_feed
(
    id            INTEGER PRIMARY KEY,
    company_id    INTEGER NOT NULL,
    feed_type     INTEGER NOT NULL,
    source        TEXT    NOT NULL,
    content       TEXT    NOT NULL,
    creation_date DATE    NOT NULL,
    FOREIGN KEY (company_id) REFERENCES companies (id),
    FOREIGN KEY (feed_type) REFERENCES feed_types (id)
);
INSERT INTO company_feed (company_id, feed_type, source, content, creation_date)
VALUES (1, 1, 'Source 1', 'Content 1', '2023-06-01'),
       (2, 2, 'Source 2', 'Content 2', '2023-06-02'),
       (3, 1, 'Source 3', 'Content 3', '2023-06-03');

-- Create 'events' table
CREATE TABLE events
(
    id            INTEGER PRIMARY KEY,
    company_id    INTEGER NOT NULL,
    event_type    INTEGER NOT NULL,
    source        TEXT    NOT NULL,
    content       TEXT    NOT NULL,
    creation_date DATE    NOT NULL,
    FOREIGN KEY (event_type) REFERENCES event_types (id),
    FOREIGN KEY (company_id) REFERENCES companies (id)
);
INSERT INTO events (company_id, event_type, source, content, creation_date)
VALUES (1, 1, 'Source 4', 'Content 4', '2023-06-01'),
       (2, 2, 'Source 5', 'Content 5', '2023-06-02'),
       (3, 1, 'Source 6', 'Content 6', '2023-06-03');


-- Create 'notifications' table
CREATE TABLE notifications
(
    id            INTEGER PRIMARY KEY,
    user_id       INTEGER NOT NULL,
    feed_type  TEXT    NOT NULL,
    is_read       INTEGER NOT NULL,
    content       TEXT    NOT NULL,
    creation_date DATE    NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id),
    foreign key (feed_type) references feed_types(id)
);
INSERT INTO notifications (user_id, feed_type, is_read, content, creation_date)
VALUES (1, 2, true, 'Notification 1', '2023-06-01'),
       (2, 1, false, 'Notification 2', '2023-06-02'),
       (3, 1, true, 'Notification 3', '2023-06-03');

-- Create 'payment' table
CREATE TABLE payment
(
    id           INTEGER PRIMARY KEY,
    user_id      INTEGER NOT NULL,
    amount       REAL    NOT NULL,
    payment_date DATE    NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id)
);
INSERT INTO payment (user_id, amount, payment_date)
VALUES (1, 100.50, '2023-06-01'),
       (2, 75.20, '2023-06-02'),
       (3, 50.00, '2023-06-03');
       
-- Create 'triggers_type' table
CREATE TABLE triggers_type
(
    id         INTEGER PRIMARY KEY,
    trigger_type TEXT NOT NULL
);
INSERT INTO triggers_type (trigger_type)
VALUES ('Hourly'),
       ('Daily'),
       ('Monthly'),
       ('Yearly');


-- Create 'triggers' table
CREATE TABLE triggers
(
    trigger_id    INTEGER PRIMARY KEY,
    trigger_name  TEXT    NOT NULL,
    trigger_type  INTEGER    NOT NULL,
    event_id      INTEGER NOT NULL,
    event_type    INTEGER    NOT NULL,
    user_id       INTEGER,
    description   TEXT    NOT NULL,
    creation_date DATE    NOT NULL,
    FOREIGN KEY (event_type) references event_types(id),
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (trigger_type) REFERENCES triggers_type (id),
    FOREIGN KEY (event_id) REFERENCES events (id)
);
INSERT INTO triggers (trigger_id, trigger_name, event_id, event_type, description, trigger_type, creation_date, user_id)
VALUES (1, 'Trigger 1', 1, 1, 'Description 1', 1, '2023-06-01', 1),
       (2, 'Trigger 2', 2, 2, 'Description 2', 2, '2023-06-02', 2),
       (3, 'Trigger 3', 3, 1, 'Description 3', 4, '2023-06-03', 3);
