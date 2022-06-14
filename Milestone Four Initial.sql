/* ==================================     SUMMARY    =================================
This is a database to demonstrate various relational database concepts. 
The table features various Olympic athletes in a "messaging" database.
====================================================================== */

/* ============================== CREATION AND POPULATION ==================
This first section demonstrates the ability to create and populate tables
========================================================================= */

/* =========================
Creates the Messaging database. 
Database Name: messaging
========================= */
CREATE DATABASE IF NOT EXISTS messaging;

/* Use the new Messaging database that was created. */
USE messaging;

/* =========================
Creates the Person table. 
Table Name: person
Primary Key: person_id
========================= */
CREATE TABLE person ( 
    person_id INT(8) NOT NULL auto_increment,
    first_name VARCHAR(25) NOT NULL,
    last_name VARCHAR(25) NOT NULL,
    PRIMARY KEY (person_id)
) AUTO_INCREMENT=1;

/* =========================
Creates the Contact List table. 
Table Name: contact_list
Primary Key: connection_id
========================= */
CREATE TABLE contact_list ( 
    connection_id INT(8) NOT NULL auto_increment,
    person_id INT(8) NOT NULL,
    contact_id INT(8) NOT NULL,
    PRIMARY KEY (connection_id)
) AUTO_INCREMENT=1;

/* =========================
Creates the Messages table. 
Table Name: message
Primary Key: message_id
========================= */
CREATE TABLE message ( 
    message_id INT(8) NOT NULL auto_increment,
    sender_id INT(8) NOT NULL,
    receiver_id INT(8) NOT NULL,
    message VARCHAR(255) NOT NULL,
    send_datetime DATETIME NOT NULL,
    PRIMARY KEY (message_id)
) AUTO_INCREMENT=1;

/* =========================
Populates the Person table. 
========================= */
INSERT INTO person (first_name, last_name)
VALUES
("Michael", "Phelps"),
("Katie", "Ledecky"),
("Usain", "Bolt"),
("Allyson", "Felix"),
("Kevin", "Durant"),
("Diana", "Taurasi");

/* =========================
Populates the Contact List table. 
========================= */
INSERT INTO contact_list (person_id, contact_id)
VALUES
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(2, 1),
(2, 3),
(2, 4),
(3, 1),
(3, 4),
(4, 5),
(4, 6),
(5, 1),
(5, 6);

/* =========================
Populates the Message table. 
========================= */
INSERT INTO message (sender_id, receiver_id, message, send_datetime)
VALUES
(1, 2, "Congrats on winning the 800m Freestyle!", "2016-12-25 09:00:00"),
(2, 1, "Congrats on winning 23 gold medals!", "2016-12-25 09:01:00"),
(3, 1, "You're the greatest swimmer ever", "2016-12-25 09:02:00"),
(1, 3, "Thanks!  You're the greatest sprinter ever", "2016-12-25 09:04:00"),
(1, 4, "Good luck on your race", "2016-12-25 09:05:00");

/* ========================= Verify Results ========================= */

/* Shows all of the tables in the database */
SHOW tables;

/* =========================
Shows the details for each of the tables created. 
DESCRIBE and SHOW COLUMNS FROM will do the same thing.
i.e. DESCRIBE table_name;
     SHOW COLUMNS FROM table_name;
========================= */
select * from person;
select * from contact_list;
select * from message;


/* ================= ALTERING TABLES =====================
This next section includes many updates and alterations to the tables created
========================================================== */

/* =========================
Inserts new person into Person table 
========================= */
INSERT INTO person (first_name, last_name)
VALUES ("Jeremiah", "Norcross");

/* =========================
Adds age column to Person table
========================= */
ALTER TABLE person 
ADD age INT(255) UNSIGNED NOT NULL;

/* =========================
Populates age column. 
========================= */
UPDATE person
SET age = 34
WHERE person_id = 1;

UPDATE person
SET age = 22
WHERE person_id = 2;

UPDATE person
SET age = 33
WHERE person_id = 3;

UPDATE person
SET age = 33
WHERE person_id = 4;

UPDATE person
SET age = 31
WHERE person_id = 5;

UPDATE person
SET age = 37
WHERE person_id = 6;

UPDATE person
SET age = 22
WHERE person_id = 7;

/* =========================
Deletes a row from the Person table. 
========================= */
DELETE FROM person 
WHERE first_name = "Diana"
AND last_name = "Taurasi";

/* =========================
Adds favorite column to contact_list table 
========================= */
ALTER TABLE contact_list
ADD favorite VARCHAR(10);

/* =========================
Populates favorite column. 
========================= */
UPDATE contact_list
SET favorite = 'y'
WHERE contact_id = 1;


UPDATE contact_list
SET favorite = 'n'
WHERE contact_id <> 1;


INSERT INTO contact_list (person_id, contact_id, favorite)
VALUES 
(5, 7, 'n'),
(6, 7, 'n'),
(1, 7, 'n');

/* =========================
Creates new tables for 'images' 
========================= */
CREATE TABLE image (
image_id int(8) NOT NULL AUTO_INCREMENT,
image_name VARCHAR(50) NOT NULL,
image_location VARCHAR(250) NOT NULL,
PRIMARY KEY (image_id)
) AUTO_INCREMENT = 1;
    

CREATE TABLE message_image (
message_id INT(8) NOT NULL,
image_id INT(8) NOT NULL,
PRIMARY KEY (message_id, image_id)
);

/* =========================
Populates image table 
========================= */
INSERT INTO image (image_name, image_location)
VALUES 
('Congrats.jpg', 'C:\\Users\\admin\\Pictures'),
('Thank you.jpg', 'C:\\Users\\admin\\Pictures'),
('Lucky cat.jpg', 'C:\\Users\\admin\\Pictures'),
('Good Luck.jpg', 'C:\\Users\\admin\\Pictures'),
('Sonic the Hedgehog.gif', 'C:\\Users\\admin\\Pictures');

/* =========================
Populates the message_image table.
========================= */
INSERT INTO message_image (message_id, image_id)
VALUES
(1, 1),
(2, 1),
(4, 5),
(5, 3),
(5, 4);

/* =========================
Various Select statements to verify results. 
========================= */
SELECT 
s.first_name AS "Sender First Name",
s.last_name AS "Sender Last Name",
r.first_name AS "Receiver Last Name",
r.last_name AS "Receiver Last Name",
message_id AS "Message ID",
message AS "Message",
send_datetime AS "Message Timestamp"
FROM
person s,
person r,
message
WHERE
s.person_id = 1 AND
sender_id = 1 AND
r.person_id = receiver_id;


SELECT 
person_id AS "Person ID", 
first_name AS "First Name", 
last_name AS "Last Name",
COUNT(sender_id) AS "Count of messages"
FROM 
person,
message
WHERE 
sender_id = person_id
GROUP BY 
person_id;


SELECT 
message_image.message_id AS "Message ID",
message AS "Message",
send_datetime AS "Message Timestamp",
image_name AS "First Image Name",
image_location AS "First Image Location"
FROM
message, image 
JOIN message_image ON
message_id = message_image.message_id AND
image.image_id = message_image.image_id
WHERE
message.message_id = message_image.message_id
GROUP BY
message_image.message_id;



