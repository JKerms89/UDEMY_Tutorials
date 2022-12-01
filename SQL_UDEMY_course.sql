-- These are the SQL queries I generated during the UDEMY course 'The Ultimate MySQL Bootcamp: Go from SQL Beginner to Expert' by Colt Steele 
-- (link: https://www.udemy.com/course/the-ultimate-mysql-bootcamp-go-from-sql-beginner-to-expert/).
-- I thoroughly recommend this course for those who want a solid grounding in how to use SQL.
-- N-b. I had to amend the queries slightly because the course was conducted using MySQL but I used SQL Server.

-- Create a databases in SQL

CREATE DATABASE pet_shop;
CREATE DATABASE SlimeStore;
CREATE DATABASE chicken_coop;
CREATE DATABASE UDEMY;

-- Code for deleting a database

DROP DATABASE SlimeStore;
DROP DATABASE pet_shop;
DROP DATABASE chicken_coop;

-- Pick a database as default

USE UDEMY;

-- Creating a table

CREATE TABLE Tweets ( 
	username VARCHAR(15),
	tweet VARCHAR(140),
	favourites INT
);

-- Inserting values into the table

INSERT INTO Tweets 
VALUES
	('coolguy', 'my first tweet!', 1),
	('guitar_queen', 'I love music!', 10),
	('lonely_heart', 'still looking for love', 0);

SELECT *
FROM Tweets;

-- To view the data type of columns in a table
-- N.B. In MySQL, one only needs to type 'SHOW COLUMNS FROM Tweets' or 'DESCRIBE Tweets' to extract this info.

EXEC SP_HELP Tweets;

-- Dropping tables
-- To delete a table, you simply have to type the following:

DROP TABLE Tweets;

-- Assignment: Create a pastries table. Insert values. Then delete it.
-- It should include 2 columns: name and quantity. Name is 50 char length.

CREATE TABLE pastries 
	(
	name VARCHAR(50),
	quantity INT
	);

INSERT INTO pastries
VALUES ('cornish pasty', 3),
		('sausage roll', 2);

SELECT *
FROM pastries;

DROP TABLE pastries;

-- Inserting data (in more detail)

CREATE TABLE cats
	(
	name VARCHAR(50),
	age INT)
	;

INSERT INTO cats(name, age)
VALUES ('Eddy', 7);

-- To add another value:

INSERT INTO cats (name, age) 
VALUES ('Jenkins', 7);

-- To select all the data from a table, you use the following code:

SELECT * FROM cats;

-- Multiple inserts

INSERT INTO cats(age, name)
VALUES (10, 'Charlie'),
		(3, 'Sadie'),
		(1, 'Lazy Bear');

SELECT * FROM cats;

-- INSERT exercise

CREATE TABLE people (
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	age INT
	);

INSERT INTO people
VALUES ('Tina', 'Belcher', 13),
		('Bob', 'Belcher', 42),
		('Linda', 'Belcher', 45),
		('Phillip', 'Frond', 38),
		('Calvin', 'Fischoeder', 70);

SELECT *
FROM people;

EXEC SP_HELP people;

-- Working with NOT NULL.
-- Nullable means that the column allows for NULL values.
-- Null does not mean zero. It means there is no value assigned / values are unknown.

INSERT INTO cats (name) VALUES ('Todd')
SELECT *
FROM cats;

-- Sometimes, we may not want that a column accepts NULL values. How do we do this? By adding the NOT NULL condition.
-- As you can see, NULL values cannot be accepted in the cats2 table.
-- Nullable == 'No'

CREATE TABLE cats2
	(
		name VARCHAR(100) NOT NULL,
		age INT NOT NULL
	);

INSERT INTO cats2(name) 
VALUES ('Bob');

EXEC SP_HELP cats2;

-- Sidenote: Quotes in MySQL
-- Add double quotation marks ('') when dealing with apostrophe's in strings. (In MySQL, you use \).
-- E.g.

INSERT INTO cats (name)
VALUES ('Eddy''s baby pooch');

SELECT * 
FROM cats;

-- For double quotation marks within single quotation marks, the problem is averted.
-- E.g. 

INSERT INTO cats (name)
VALUES(' "ho ho ho" ')

-- Adding default values

CREATE TABLE cats3
	(
	name VARCHAR(100) NOT NULL DEFAULT 'unnamed',
	age INT NOT NULL DEFAULT 99
	);

INSERT INTO cats3(age) VALUES(2);

SELECT * 
FROM cats3;

-- Introducing Primary Keys
-- A primary key is a fancy name for a unique identifier.
-- It is good practice to have a unique identifier for each row even if all the values in the column are the same (as per below).

INSERT INTO cats3(age) VALUES(2)
INSERT INTO cats3(age) VALUES(2)
INSERT INTO cats3(age) VALUES(2)
INSERT INTO cats3(age) VALUES(2)
SELECT * 
FROM cats3;

-- How do we make each row unique?

CREATE TABLE unique_cats 
	(
	--cat_id INT NOT NULL PRIMARY KEY,
	cat_id INT PRIMARY KEY,
	name VARCHAR(100),
	age INT
	);

-- N.B. NOT NULL is redundant as PRIMARY KEYS can never include NULL values
-- How to identify the primary key of a table:

EXEC sp_pkeys unique_cats;

INSERT INTO unique_cats(cat_id, name, age)
	VALUES(1,'bingo',2)

INSERT INTO unique_cats(cat_id, name, age)
	VALUES(1,'bongo',3)

--  This will return an error as the primary key is the same in both queries.

INSERT INTO unique_cats(cat_id, name, age)
	VALUES(2,'bongo',3)

INSERT INTO unique_cats(cat_id, name, age)
	VALUES(3,'bongo',3)

INSERT INTO unique_cats(cat_id, name, age)
	VALUES(99,'bongo',3)

-- Working with IDENTITY (AUTO_INCREMENT in MySQL)
-- The IDENTITY constraint  informs SQL Server to auto increment the numeric value within the specified column 
-- anytime a new record is INSERTED. While IDENTITY can accept two arguments of the numeric seed where the values 
-- will begin from as well as the increment, these values are typically not specified with the IDENTITY constraint 
-- and instead are left as defaults (both default to 1).

CREATE TABLE unique_cats2
	(
	cat_id INT IDENTITY,
	name VARCHAR(100),
	age INT,
	PRIMARY KEY (cat_id)
	);

INSERT INTO unique_cats2(name, age)
	VALUES('bingo',2)

INSERT INTO unique_cats2(name, age)
	VALUES('bingo',2)

INSERT INTO unique_cats2(name, age)
	VALUES('bingo',2)

SELECT *
FROM unique_cats2

-- Use IDENTITY in conjunction with Primary key

CREATE TABLE unique_cats3
	(
	cat_id INT IDENTITY PRIMARY KEY,
	name VARCHAR(100),
	age INT
	);

EXEC SP_HELP unique_cats3;

--Identity	Seed	Increment	Not For Replication
--cat_id	1		1			0


-- Create Table / Insert Exercise
-- Define an Employees table with the following fields:
--ID, last name, first name, middle name, age and current status.

CREATE TABLE Employees(
			id INT IDENTITY PRIMARY KEY,
			last_name VARCHAR(50) NOT NULL,
			first_name VARCHAR(50) NOT NULL,
			middle_name VARCHAR(50), 
			age INT NOT NULL,
			current_status VARCHAR(50) NOT NULL DEFAULT 'employed'
			);

EXEC SP_HELP Employees;

INSERT INTO Employees(first_name, last_name, age)
	VALUES('thomas', 'white', 87);

SELECT *
FROM Employees;

-- CRUD Basics (Create, Read, Update and Delete)
-- Getting our new 'dataset'

DROP TABLE cats;

CREATE TABLE cats 
  ( 
     cat_id INT IDENTITY, 
     name   VARCHAR(100), 
     breed  VARCHAR(100), 
     age    INT, 
     PRIMARY KEY (cat_id) 
  ); 

INSERT INTO cats(name, breed, age) 
VALUES ('Ringo', 'Tabby', 4),
       ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);


-- How do we read data that is already in a table
-- Select all columns

SELECT *
FROM cats;

-- Select speific columns

SELECT name
FROM cats;

-- Select multiple columns

SELECT age, name
FROM cats;

-- Let's get specific...
-- The WHERE clause (to narrow down the rows we want to work with)
-- Where can we used not only on SELECT statements but also for DELETE statements

SELECT * 
FROM cats
WHERE age != 4;

SELECT *
FROM cats
WHERE name ='Egg';

SELECT *
FROM cats
WHERE name ='eGG';

SELECT *
FROM cats
WHERE name LIKE 'Ci%';

SELECT *
FROM cats
WHERE name LIKE '%sty';

SELECT *
FROM cats
WHERE name LIKE '%ing%';

-- Rapid Fire Exercises
-- Select cat_id for all the rows

SELECT cat_id
FROM cats;

-- Select name and breed column for all rows

SELECT name, breed
FROM cats;

-- Just the Tabby cats

SELECT name, age
FROM cats
WHERE breed = 'Tabby';

-- Where cat_id is same as age

SELECT cat_id, age
FROM cats
WHERE cat_id = age;

-- Aliases 
-- Easier to read results
-- N.B Column is renamed only for this query. The table default column name remains unchanged outside of the query.

SELECT cat_id AS id, name FROM cats;

SELECT name AS kittyname FROM cats;

-- Using UPDATE
-- Important to specify on which columns you want to update hence why we add the WHERE query.
-- If you want to update on every row of the column, there is no need to add a WHERE query.

UPDATE cats SET breed='Shorthair'
WHERE breed='Tabby';

SELECT *
FROM cats;

UPDATE Employees SET current_status='laid off', last_name='who cares'

SELECT*
FROM Employees;

UPDATE cats SET age=14
WHERE name='Misty';

-- A quick rule of thumb
-- Try SELECT before you UPDATE

-- UPDATE Exercises

UPDATE cats SET name='Jack'
WHERE name='Jackson'
SELECT*
FROM cats;

UPDATE cats SET name='George'
WHERE breed='Ragdoll'
SELECT*
FROM cats;

UPDATE cats SET breed='British Shorthair'
WHERE cat_id=1
SELECT*
FROM cats;

UPDATE cats SET age=12
WHERE breed='Maine Coon'
SELECT*
FROM cats;

-- Introducing DELETE
-- Deleting rows from table in SQL
-- N.B DROP TABLE removes the whole table whereas DELETE removes rows from a table.

DELETE FROM cats 
WHERE name='Egg'
SELECT*
FROM cats;

-- To remove every row from the table
-- N.B The table still exists
-- Best to use SELECT clause before deleting rows.

DELETE FROM Employees;

-- DELETE Exercises

DELETE FROM cats
WHERE age=4
SELECT*
FROM cats;

DELETE FROM cats
WHERE cat_id= age
SELECT*
FROM cats;

DELETE FROM cats
SELECT*
FROM cats;

-- CRUD Challenge
-- 1. Create a new database called 'shirts_db'
-- 2. Create a new table called 'shirts' (see slide for how the table should look like).
-- 3. Add a new shirt to the table ('Purple', size M, last worn 50 days ago).
-- 4. Select all shirts but only print out Article and Color.
-- 5. Select all medium shirts but print out Everything but shirt_id.
-- 6. Update all polo shirts changing their size to L.
-- 7. Update the shirt last worn 15 days ago. Change last_worn to 0.
-- 8. Update all white shirts. Change size to 'XS' and color to 'navy blue'.
-- 9. Delete all old shirts last worn 200 days ago.
--10. Delete all tank tops
--11. Delete all shirts
--12. Drop the entire shirts table

CREATE DATABASE shirts_db;
USE shirts_db;

CREATE TABLE shirts(
					shirt_id INT IDENTITY PRIMARY KEY,
					article VARCHAR(100),
					color VARCHAR(100),
					shirt_size VARCHAR(5),
					last_worn INT 
					);

INSERT INTO shirts (article, color, shirt_size, last_worn)
	VALUES 
	('t-shirt', 'white', 'S', 10),
	('t-shirt', 'green', 'S', 200),
	('polo shirt', 'black', 'M', 10),
	('tank top', 'blue', 'S', 50),
	('t-shirt', 'pink', 'S', 10),
	('polo shirt', 'red', 'M', 5),
	('tank top', 'white', 'S', 200),
	('tank top', 'blue', 'M', 15);

INSERT INTO shirts (article, color, shirt_size, last_worn)
VALUES ('polo shirt','purple', 'M', 50);

SELECT article, color
FROM shirts;
			
SELECT * 
FROM shirts 
WHERE shirt_size='M';

SELECT article, color, shirt_size, last_worn 
FROM shirts 
WHERE shirt_size='M';

UPDATE shirts 
SET 
    shirt_size = 'L'
WHERE
    article = 'polo shirt';
    
    
UPDATE shirts 
SET 
    last_worn = 0
WHERE
    last_worn = 15;
    
UPDATE shirts 
SET 
    color = 'off white',
    shirt_size = 'XS'
WHERE
    color = 'white';

SELECT * FROM shirts WHERE last_worn=200;
 
DELETE FROM shirts WHERE last_worn=200;
 
SELECT * FROM shirts WHERE article='tank top';
 
DELETE FROM shirts WHERE article='tank top';
 
SELECT * FROM shirts;
 
DELETE FROM shirts;
 
DROP TABLE shirts;

-- String functions
-- Create database

CREATE DATABASE book_shop;
USE book_shop;

-- Create table

CREATE TABLE books 
    (
        book_id INT NOT NULL IDENTITY,
        title VARCHAR(100),
        author_fname VARCHAR(100),
        author_lname VARCHAR(100),
        released_year INT,
        stock_quantity INT,
        pages INT,
        PRIMARY KEY(book_id)
    );
    
    exec sp_columns books;

-- Insert values into table
    
INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
('Where I''m Calling From: Selected Stories', 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

SELECT * FROM books;
exec sp_columns books;

-- CONCAT function

SELECT CONCAT('J', 'a', 'n');

SELECT CONCAT(author_fname, ' ', author_lname) AS author_fname
FROM books;

-- CONCAT_WS (with seperator)

SELECT CONCAT_WS(' ', author_fname, author_lname) AS author_fname
FROM books;

SELECT CONCAT_WS('-', title, author_fname, author_lname)
FROM books;

-- SUBSTRING, LEFT, and RIGHT
-- 3 arguments - first is input string, second is where you want string to start, and third argument is where you want it to end.
-- NB We can also provide a single argument in MySQL but not on the SQL Server.

SELECT SUBSTRING('Hello World', 1,4)

SELECT REVERSE(SUBSTRING(REVERSE('Hello World'), 1, 1))

-- In MySQL, you can provide less than three arguments without returning an error. E.g. SELECT SUBSTRING('Hello World', 7)
-- or SELECT SUBSTRING('Hello World', -3);
-- However, fortunately there is a workaround to extract the last character of a string using the RIGHT function 

SELECT RIGHT('Hello World', 1);

SELECT LEFT('Hello World', 3);

-- Let's use these functions on real data

SELECT title 
FROM books;

-- Extract the first 15 characters

SELECT SUBSTRING(title, 1, 15) AS abbreviated_title
FROM books;

-- N.B SUBSTR is a synonym for SUBSTRING in MySQL

SELECT SUBSTRING(author_lname, 1,1) AS initial, author_lname 
FROM books;

-- Combining CONCAT and SUBSTRING together

SELECT CONCAT(
			SUBSTRING(title, 1,10), 
			'...'
			)AS short_title
FROM books;

-- Create a column that is the author's initials

SELECT CONCAT(
			SUBSTRING(author_fname, 1,1), '.',
			SUBSTRING(author_lname, 1,1), '.'
			) AS author_initials,
			author_fname,
			author_lname
FROM books;

-- REPLACE parts of a string
-- REPLACE(str, from_str, to_str)
-- There must always be 3 arguments.

SELECT 
	REPLACE('Fucking hell!', 'ucking', '@@@@@@');

SELECT
	REPLACE('cheese bread coffee milk', ' ', ' and ');

-- N-B The function is case sensitive

SELECT
	REPLACE('cheese bread coffee milk', ' ', ' AND ');

-- Let's try this on the book table
-- N-B This does not alter the table permanently.

SELECT
	REPLACE(title, ' ', '-')
	FROM books;

-- REVERSE function

SELECT REVERSE('Hello World')
SELECT REVERSE('chicken nuggets')

SELECT REVERSE(author_fname)
FROM books;

-- Reverse function on a palindrome sentence

SELECT 
	CONCAT(
	'Was it a car or a cat I saw', ', ',
	REVERSE('Was it a car or a cat I saw')) AS palindrome
FROM books;

-- LEN function (in MySQL it is CHAR_LENGTH)
-- N-B- DATALENGTH returns length in bytes whereas LEN returns no. of characters.
-- N.B. In MySQL, LEN returns length in bytes but CHAR_LENGTH returns no. of characters.

SELECT LEN('Jan Kermer                   ') AS num_char
FROM books;
-- Returns no. characters == 10

SELECT DATALENGTH('Jan Kermer                   ') AS num_bytes
FROM books;
-- Returns no. bytes == 29

-- UPPER & LOWER

SELECT UPPER('hello')
SELECT LOWER('HELLO')

SELECT title, UPPER(title) AS title_in_caps
FROM books;

SELECT CONCAT('I LOVE ', UPPER(title), '!!!') 
FROM books;

-- Other string functions
-- STUFF string function (N.B. In MySQL, it is INSERT)

SELECT STUFF('Hello Kermer', 6, 0, ' Mr.')

SELECT STUFF('Hello Kermer', 6, 0, ' Jan Erik')

-- Replace surname with forename

SELECT STUFF('Hello Kermer', 7, 6, ' Jan Erik')

SELECT *
FROM books;

-- LEFT + RIGHT string function

SELECT LEFT('omghahalol!', 3)

SELECT RIGHT('omghahalol!', 4)

-- TRIM/LEAD/TRAIL functions (removes leading and trailing spaces)

SELECT TRIM('     San Antonio    ');

SELECT INSERT('Hello Bobby', 6, 0, 'There'); 
 
SELECT LEFT('omghahalol!', 3);
 
SELECT RIGHT('omghahalol!', 4);
 
SELECT REPLICATE('ha', 4); -- REPEAT in MySQL
 
SELECT TRIM('  pickle  ');

SELECT TRIM('SQL' FROM 'SQLfunctionSQL') as 'SQL remove specific characters from string';


--- Remove the - from the left of San Antonio

SELECT  SUBSTRING('---San Antonio---', 4, LEN('---San Antonio---'))

--- Remove the - from the right of San Antonio

SELECT  SUBSTRING('---San Antonio---', -2, LEN('---San Antonio---'))

-- N.B in MySQL there is a better way to trim lead and trailing characters
-- This cannot be done in SQL Server, to my knowledge


--mysql> SELECT TRIM('  bar   ');
--        -> 'bar'
--mysql> SELECT TRIM(LEADING 'x' FROM 'xxxbarxxx');
--        -> 'barxxx'
--mysql> SELECT TRIM(BOTH 'x' FROM 'xxxbarxxx');
--        -> 'bar'
--mysql> SELECT TRIM(TRAILING 'xyz' FROM 'barxxyz');
--        -> 'barx'


-- String Functions Exercises

SELECT REVERSE(UPPER('Why does my cat look at me with such hatred?'))

SELECT
	REPLACE
	(
	CONCAT('I', ' ', 'like', ' ', 'cats'),
	' ',
	'-'
	);

SELECT REPLACE(title, ' ', '->') AS title
FROM books;

SELECT author_lname AS forwards, REVERSE(author_lname) AS backwards
FROM books;

SELECT UPPER(
		CONCAT(author_fname, ' ', author_lname)) AS 'full name in caps'
FROM books;

SELECT CONCAT(title, ' was released in ', released_year) AS blurb
FROM books;

SELECT title, LEN(title) AS [character count]
FROM books;

SELECT CONCAT(
		SUBSTRING(
				title, 1, 10), 
				'...') AS [short title],
		CONCAT(
			author_lname, ', ', author_fname) AS author,
		CONCAT(
			stock_quantity, ' in stock') AS quantity
FROM books;

-- Refining selections / filtering

INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

SELECT*
FROM books;

-- DISTINCT clause to remove duplicate results

SELECT DISTINCT author_lname
FROM books;

SELECT DISTINCT released_year
FROM books;

SELECT DISTINCT 
	CONCAT(author_fname, author_lname)
	FROM books;

-- The next option is a more efficient query which gives the same result

SELECT DISTINCT author_fname, author_lname
FROM books;

-- ORDER BY clause

SELECT book_id, author_fname, author_lname 
FROM books
ORDER BY author_lname;

-- N-B. ASCENDING is by default

SELECT book_id, author_fname, author_lname 
FROM books
ORDER BY author_lname DESC;

SELECT * FROM books
ORDER BY released_year;

-- More on ORDER BY
-- You can add an integer after order by as shorthand for choosing which feature to order by.

SELECT book_id, author_fname, author_lname 
FROM books
ORDER BY 3 DESC;

-- ORDER by two columns

SELECT author_fname, author_lname 
FROM books
ORDER BY author_lname, author_fname;

SELECT author_lname, released_year, title
FROM books
GROUP BY author_lname, released_year, title;

-- You can also order by aliases that are not part of the original table

SELECT CONCAT(author_fname, ' ', author_lname) AS author_fullname
FROM books
ORDER BY author_fullname;

-- TOP clause to control the no. of results we get back (In MySQL we write LIMIT at the end of the query)

SELECT TOP 5 
book_id, title, released_year
FROM books;

--In MYSQL--
--SELECT book_id, title, released_year
--FROM books
--LIMIT 5;

SELECT TOP 10 
book_id, title, released_year
FROM books
ORDER BY released_year;

-- If you want to select a particular subset of rows in the table, you must use OFFSET and FETCH clauses in SQL Server.
-- In the example below, we are taking rows 3 and 4 of the resulting df. We skipped the first two rows using OFFSET
-- and fetched the next two rows. 

SELECT book_id, title, released_year
FROM books
ORDER BY released_year DESC
OFFSET 2 ROWS
FETCH NEXT 3 ROWS ONLY;

-- In MySQL, it is must easier and more readable to achieve the same result (See below):
-- In this example, we start at row 3 and end at row 5 (3 rows in total).

--SELECT book_id, title, released_year
--FROM books
--ORDER BY released_year DESC
--LIMIT 3,3;


-- The LIKE operator 

SELECT title, author_fname, author_lname
FROM books
WHERE author_fname LIKE '%da%'

-- The underscore_ LIKE operator
-- Return author_fname results with exactly 4 characters

SELECT * FROM books
WHERE author_fname LIKE '____';

---- Return author_fname results with exactly 3 characters and and 'a' in the middle

SELECT * FROM books
WHERE author_fname LIKE '_a_';

SELECT * FROM books
WHERE author_lname LIKE '_a__i_' 
AND author_fname LIKE '__ei_a';

-- Escaping wildcards
-- Search for title which contains the % character
-- In MYSQL
--SELECT * FROM books
--WHERE title LIKE '%\%%';

-- In SQL Server

SELECT * FROM books
WHERE title LIKE '%[%]%';

-- Search for title which contains the _ character

SELECT * FROM books
WHERE title LIKE '%[_]%';

--In MYSQL
--SELECT * FROM books
--WHERE title LIKE '%\_%';

-- Refining Selections Exercises

SELECT title
FROM books
WHERE title LIKE '%stories%';

SELECT TOP 1 title, pages
FROM books
ORDER BY pages DESC;

SELECT TOP 3 
CONCAT(title, '-', released_year) AS summary
FROM books
ORDER BY released_year DESC;

SELECT title, author_lname
FROM books
WHERE author_lname LIKE '% %';

SELECT TOP 3
title, released_year, stock_quantity
FROM books
ORDER BY stock_quantity ASC;

SELECT title, author_lname
FROM books
ORDER BY 2,1;


SELECT
    CONCAT(
        'MY FAVORITE AUTHOR IS ',
        UPPER(author_fname),
        ' ',
        UPPER(author_lname),
        '!'
    ) AS yell
FROM books ORDER BY author_lname;

-- AGGREGATE functions
-- Select no. of rows from books table

SELECT COUNT(*) AS num_rows
FROM books;

SELECT COUNT(DISTINCT author_fname)
FROM books;

SELECT COUNT(*)
FROM books
WHERE title LIKE '%the%';

-- GROUP BY operator

SELECT author_lname, COUNT(*) AS num_books
FROM books
GROUP BY author_lname
ORDER BY 2 DESC;

SELECT TOP 5 released_year, COUNT(*) 
FROM books
GROUP BY released_year
ORDER BY 2 DESC;

-- MIN and MAX Masics
-- N.B Whenever you aggregate in conjunction with a non-aggregated feature, you should use a subquery.
-- E.g.

SELECT MAX(pages), title FROM books;
-- Column 'books.title' is invalid in the select list because it is not contained in 
-- either an aggregate function or the GROUP BY clause.

---We must do the following:

SELECT TOP 1 title, pages
FROM books
ORDER BY pages DESC;

-- Or we can do a subquery which tells SQL to read the subquery/nested query first before actioning the global query.

SELECT title, pages
FROM books
WHERE pages = (SELECT MAX(pages)
				FROM books);

SELECT MIN(released_year) FROM books;
 
SELECT title, released_year FROM books 
WHERE released_year = (SELECT MIN(released_year) FROM books);

-- GROUPING BY multiple columns

SELECT author_fname, author_lname, COUNT(*) AS count
FROM books
GROUP BY author_lname, author_fname;

-- In MySQL, we can create a new column called author/full_name and then count the number of rows according to full name.

SELECT CONCAT(author_fname, ' ', author_lname) AS author,  COUNT(*)
FROM books
GROUP BY author;
--Invalid column name 'author'.

-- However, in SQL Server, the above code does not work. A workaround is to create a #temp table

DROP TABLE IF EXISTS  #Temp

SELECT CONCAT(author_fname, ' ', author_lname) AS Author INTO #temp
FROM books

SELECT COUNT(1) AS NumberOfRows,
   Author
FROM #temp
GROUP BY Author
ORDER BY Author;

-- MIN/MAX with GROUP BY
-- Find the year each author published their first book

SELECT author_lname, MIN(released_year) AS 'First Book'
FROM books
GROUP BY author_lname;


SELECT author_lname, 
author_fname,
COUNT(*) AS books_written, 
MAX(released_year) AS latest_release, 
MIN(released_year) AS earliest_release,
MAX(pages) AS longest_page_count
FROM books 
GROUP BY author_lname, author_fname;

-- SUM operator

SELECT author_lname, SUM(pages) AS num_pages_written
FROM books
GROUP BY author_lname;

SELECT author_lname, COUNT(*), SUM(pages)
FROM books
GROUP BY author_lname;

-- AVG operator
-- Calculate average released year across all books

SELECT AVG(released_year)
FROM books;

SELECT AVG(pages)
FROM books;

-- Calculate avg. stock quantity for books released in the same year

SELECT released_year, AVG(stock_quantity) AS 'avg stock', COUNT(*)
FROM books
GROUP BY (released_year)

-- Calculate standard deviation of stock quantity
--N.B - In MYSQL, it is STD.
-- N.B Standard deviation is a measure of dispersion from the center.

SELECT STDEV(stock_quantity) AS [standard deviation], 
AVG(stock_quantity) AS [mean]
FROM books

-- AGG Functions Exercises

SELECT COUNT(*) 'number of books'
FROM books

SELECT released_year, COUNT(*) 'number of books'
FROM books
GROUP BY released_year;

SELECT SUM(stock_quantity)
FROM books;

SELECT AVG(released_year), CONCAT(author_fname, ' ', author_lname)
FROM books
GROUP BY author_lname, author_fname;


SELECT TOP 1 MAX(pages), CONCAT(author_fname, ' ', author_lname)
FROM books
GROUP BY author_lname, author_fname
ORDER BY 1 DESC;

-- OR using sub query

SELECT CONCAT(author_fname, ' ', author_lname) AS Author, pages 
FROM books
WHERE pages = (SELECT(MAX(pages)) FROM books);


SELECT released_year AS 'year', COUNT(*) AS '# books', AVG(pages) AS 'avg pages'
FROM books
GROUP BY released_year 
ORDER BY released_year ASC;

-- Revisiting Data Types

-- CHAR vs. VARCHAR

-- CHAR has a fixed length
-- CHAR is faster for fixed length text.
--The length of a CHAR column is fixed to the 
--length that you declare when you create the table. 
--The length can be any value from 0 to 255. 
--When CHAR values are stored, they are right-padded 
--with spaces to the specified length. When CHAR 
--values are retrieved, trailing spaces are removed 
--unless the PAD_CHAR_TO_FULL_LENGTH SQL mode is enabled.

CREATE TABLE cities (abbr CHAR(2));
INSERT INTO cities (abbr) VALUES ('NY');

 -- INT, TINYINT, BIGINT

 CREATE TABLE babies (num_babies TINYINT);
 INSERT INTO babies (num_babies) VALUES (3);

 -- DECIMALS
 -- The first number indicates the total number of digits, and the second argument indicates how many digits after the decimal).
 
 CREATE TABLE products ( price DECIMAL(5,2));
 INSERT INTO products (price) VALUES (46.566);
 SELECT * FROM products;

-- FLOAT & REAL
-- N.B Decimals is more precise but float and real uses less memory.
-- N.B. For high precision, it is best to use decimals.

CREATE TABLE nums (x FLOAT, y REAL);
INSERT INTO nums (x,y) VALUES (1.1234567899999999, 1.1234567899999999);
SELECT * FROM nums;

-- DATES and TIMES

-- DATE = Values With a Date But No Time. 'YYYY-MM-DD' Format
-- TIME = Values With a Time But No Date. 'HH:MM:SS' Format
-- DATETIME = Values With a Date AND Time. 'YYYY-MM-DD HH:MM:SS' Format

CREATE TABLE

CREATE TABLE people (
	name VARCHAR(100),
    birthdate DATE,
    birthtime TIME,
    birthdt DATETIME
);
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Elton', '2000-12-25', '11:00:00', '2000-12-25 11:00:00');
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Lulu', '1985-04-11', '9:45:10', '1985-04-11 9:45:10');
 
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Juan', '2020-08-15', '23:59:00', '2020-08-15 23:59:00');

SELECT* 
FROM people;

-- CURDATE, CURRENT_TIMESTAMP OR GETDATE() (CURTIME in MySQL), & NOW

SELECT CURRENT_TIMESTAMP

SELECT GETDATE()

SELECT SYSDATETIME()

-- To get date only
SELECT CAST(GETDATE() AS DATE) AS Date -- In MySQL, you can use CURDATE()

-- To get time
SELECT CAST(GETDATE() AS TIME) AS Time -- In MySQL, you can use CURTIME()

-- To get datetime
SELECT CAST(GETDATE() AS DATETIME) AS Now -- In MySQL, you can use CURTIME()

--

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Hazel', CAST(GETDATE() AS DATE), 
		CAST(GETDATE() AS TIME), 
		CAST(GETDATE() AS DATETIME));

SELECT *
FROM people;

-- In MySQL, the code is much more efficient:
SELECT CURTIME();
SELECT CURDATE();
SELECT NOW();

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Hazel', CURDATE(), CURTIME(), NOW());

-- Date Functions

SELECT birthdate, DAY(birthdate) FROM people;

SELECT birthdate, DAY(birthdate), MONTH(birthdate), YEAR(birthdate)  FROM people;

-- N.B. DAYOFWEEK (which returns index number of day of week) does not work in SQL SERVER.
SELECT birthdate, DAY(birthdate), MONTH(birthdate), YEAR(birthdate)
-- DAYOFWEEK(birthdate),
-- DAYOFYEAR(birthdat),
-- MONTHNAME(birthdate),
FROM people;

-- TIME Functions
-- N.B These do not work in SQL Server (only in MYSQL)

SELECT name, birthtime, HOUR(birthtime) 
FROM people;

SELECT name, birthtime, MINUTES(birthtime) 
FROM people;

SELECT name, birthtime, SECOND(birthtime) 
FROM people;

SELECT DATE(birthdt) 
FROM people;

SELECT TIME(birthdt) 
FROM people;

-- Formatting Dates
-- Changing datetime stamps into this format: 'April 11 1985'
-- N.B This does not work in SQL Server

SELECT CONCAT(
			MONTHNAME(birthdate), ' ',
			DAY(birthdate), ' ',
			YEAR(birthdate)
			)
FROM people;

SELECT birthdate, DATE_FORMAT(birthdate, '%b') FROM people; -- In MySQL
SELECT birthdate, DATE_FORMAT(birthdate, '%a %b %D') FROM people;  -- In MySQL
SELECT birthdt, DATE_FORMAT(birthdt, '%H:%i') FROM people;  -- In MySQL
SELECT birthdt, DATE_FORMAT(birthdt, 'BORN ON: %r') FROM people;  -- In MySQL

-- Date Maths

SELECT birthdate, DATEDIFF(day, birthdate, CAST(GETDATE() AS DATE)) AS 'number of days since birth'
FROM people;

-- In MYSQL it is easier:

--SELECT birthdate, DATEDIFF(CURDATE(), birthdate) 
--FROM people;

-- Adding DATE_ADD in MYSQL

SELECT DATE_ADD(CURDATE(), INTERVAL 1 YEAR);
SELECT DATE_ADD(CURDATE(), INTERVAL 1 MONTH);
SELECT DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- In My SQL Server:

SELECT DATEADD(year, 1, CAST(GETDATE() AS DATE))
SELECT DATEADD(month, 1, CAST(GETDATE() AS DATE))
SELECT DATEADD(month, -1, CAST(GETDATE() AS DATE))

-- Using TIMEDIFF in MySQL

--SELECT TIMEDIFF(CURDATE(), '07:00:00') 

SELECT DATEDIFF(hour, '07:00:00', CAST(GETDATE() AS TIME))
SELECT DATEDIFF(minute, '07:00:00', CAST(GETDATE() AS TIME))
SELECT DATEDIFF(second, '07:00:00', CAST(GETDATE() AS TIME))

-- Extracting the year from the birthdate in 21 years time.

SELECT name, birthdate, YEAR(DATEADD(year, 21, birthdate)) AS [+21 years], 
CONCAT(name, ' will be 21 in ', 
YEAR(DATEADD(year, 21, birthdate)))
FROM people;

-- TIMESTAMPS
-- TIMESTAMPS take less memory than DATETIME

SELECT CURRENT_TIMESTAMP

SELECT TIMESTAMP('2022-11-23 18:26:59') -- In MYSQL

--  DEFAULT & ON UPDATE TIMESTAMPS

CREATE TABLE captions (
  text VARCHAR(150),
  created_at DATETIME default CURRENT_TIMESTAMP
);

CREATE TABLE captions2 (
  text VARCHAR(150),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME UPDATE CURRENT_TIMESTAMP
);

INSERT INTO captions2 (text) VALUES ('i love life!');

SELECT *
FROM captions2;
UPDATE captions2 SET text= 'i love life!!!!';

SELECT *
FROM captions2;

-- In MYSQL

CREATE TABLE captions (
  text VARCHAR(150),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
CREATE TABLE captions2 (
  text VARCHAR(150),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Data Types Exercises 

CREATE TABLE inventory (
item_name VARCHAR(50),
price FLOAT, 
quantity INT)

-- What is the difference between DATETIME and TIMESTAMP?

--The TIMESTAMP type in MySQL is often used to track changes to records such as keeping track of the last modified time of a record.
--This is possible by setting a column to auto-update.
--The reason the TIMESTAMP type is suited for this is because everything is stored in UTC (Coordinated Universal Time), which allows for tracing back to a single point in time.
--The DATETIME type does not necessarily allow us to trace back to a single point in time as we do not necessarily know the timezone for the DATETIME value.
--However, the advantage of the DATETIME type is that the supported range of values '1000-01-01 00:00:00' to '9999-12-31 23:59:59' is much larger than that of TIMESTAMP '1970-01-01 00:00:01' UTC to '2038-01-09 03:14:07' UTC.
--This makes it more suited for storing date and time information that is likely to fall outside the range of TIMESTAMP (e.g. storage of Date of Birth information).

-- Print out the current time then date

SELECT CAST(GETDATE() AS TIME) AS Time -- In MySQL, you can use CURTIME()

SELECT CAST(GETDATE() AS TIME) AS Date -- In MySQL, you can use CURDATE()

-- Print out the current day of the week as a number

SELECT DATEPART(WEEKDAY, GETDATE())

--Print out the current day of the week as a name

SELECT DATENAME(WEEKDAY, GETDATE())

-- Print our current day and time using format mm/dd/yyyy

SELECT CONVERT(varchar, GETDATE(), 101)

-- Print out day and time in a bespoke format

SELECT FORMAT (getdate(), 'MMMM dd\r\d \a\t hh:mm\p\m') as date


-- SOLUTIONS CODE (For MYSQL)

-- What's a good use case for CHAR?
 
-- Used for text that we know has a fixed length, e.g., State abbreviations, 
-- abbreviated company names, etc.
 
CREATE TABLE inventory (
    item_name VARCHAR(100),
    price DECIMAL(8,2),
    quantity INT
);
 
-- What's the difference between DATETIME and TIMESTAMP?
 
-- They both store datetime information, but there's a difference in the range, 
-- TIMESTAMP has a smaller range. TIMESTAMP also takes up less space. 
-- TIMESTAMP is used for things like meta-data about when something is created
-- or updated.
 
 
SELECT CURTIME();
 
SELECT CURDATE();
 
SELECT DAYOFWEEK(CURDATE());
SELECT DAYOFWEEK(NOW());
SELECT DATE_FORMAT(NOW(), '%w') + 1;
 
SELECT DAYNAME(NOW());
SELECT DATE_FORMAT(NOW(), '%W');
 
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y');
 
SELECT DATE_FORMAT(NOW(), '%M %D at %h:%i');
 
CREATE TABLE tweets(
    content VARCHAR(140),
    username VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW()
);
 
INSERT INTO tweets (content, username) VALUES('this is my first tweet', 'coltscat');
SELECT * FROM tweets;
 
INSERT INTO tweets (content, username) VALUES('this is my second tweet', 'coltscat');
SELECT * FROM tweets;

-- Comparison & Logical Operators

-- Not equal

SELECT title, author_lname 
FROM books
WHERE author_lname != 'Gaiman'

SELECT * FROM books
WHERE released_year != 2017;

-- Not Like

SELECT * FROM books
WHERE title NOT LIKE '%e%';

-- Greater than

SELECT * FROM books
WHERE released_year > 2005;
 
SELECT * FROM books
WHERE pages > 500;

-- Less than or equal to

SELECT * FROM books
WHERE pages < 200;
 
SELECT * FROM books
WHERE released_year < 2000;
 
SELECT * FROM books
WHERE released_year <= 1985;

-- Logical AND

SELECT title, author_lname, released_year FROM books
WHERE released_year > 2010
AND author_lname = 'Eggers';
 
SELECT title, author_lname, released_year FROM books
WHERE released_year > 2010
AND author_lname = 'Eggers'
AND title LIKE '%novel%';

SELECT * FROM books
WHERE author_lname = 'Lahiri'
AND released_year > 2000;
 
SELECT * FROM books
WHERE pages >= 100 
AND pages <= 200;
 

-- Logical OR

SELECT title, pages FROM books 
WHERE CHAR_LENGTH(title) > 30
AND pages > 500;

SELECT * FROM books 
WHERE author_lname = 'Eggers'
OR author_lname = 'Chabon';
 
SELECT title, author_lname FROM books
WHERE author_lname='Eggers' AND
released_year > 2010;
 
SELECT title, author_lname, released_year FROM books
WHERE author_lname='Eggers' OR
released_year > 2010;
 
SELECT title, pages FROM books
WHERE pages < 200 
OR title LIKE '%stories%';

SELECT title, author_lname FROM books
WHERE author_lname LIKE 'C%'
OR author_lname LIKE 'S%';

SELECT title, author_lname
FROM books WHERE SUBSTRING(author_lname, 1, 1) in ('C', 'S');

-- Between

SELECT * FROM books
WHERE pages BETWEEN 100 and 200;

SELECT *
FROM books
WHERE released_year BETWEEN 2004 AND 2015;

--OR

SELECT *
FROM books
WHERE released_year >= 2004 
AND released_year <= 2015;

-- Comparing Dates (In MySQL only)

SELECT * FROM people WHERE birthtime 
BETWEEN CAST('12:00:00' AS TIME) 
AND CAST('16:00:00' AS TIME);

SELECT * FROM people WHERE HOUR(birthtime)
BETWEEN 12 AND 16;

-- The IN operator

SELECT title, author_lname FROM books
WHERE author_lname = 'Carver' 
OR author_lname = 'Lahiri'
OR author_lname = 'Smith';
 
SELECT title, author_lname FROM books
WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');
 
SELECT title, author_lname FROM books
WHERE author_lname NOT IN ('Carver', 'Lahiri', 'Smith');

-- Modulo to get back only odd numbers

SELECT title, released_year FROM books
WHERE released_year >= 2000 
AND released_year % 2 = 1;

-- Modulo to get back only even numbers

SELECT title, released_year FROM books
WHERE released_year >= 2000 
AND released_year % 2 = 1;

-- CASE STATEMENTS

SELECT title, author_lname,
CASE
    WHEN title LIKE '%stories%' THEN 'Short Stories'
    WHEN title = 'Just Kids' THEN 'Memoir' 
    WHEN title = 'A Heartbreaking Work of Staggering Genius' THEN 'Long book'
    ELSE 'Novel'
END AS type
FROM books;

SELECT author_fname, author_lname,
	CASE
        WHEN COUNT(*) = 1 THEN '1 book'
        ELSE CONCAT(COUNT(*), ' books')
	END AS count
FROM books
WHERE author_lname IS NOT NULL
GROUP BY author_fname, author_lname;

-- IS NULL values

SELECT * 
FROM books 
WHERE author_lname IS NOT NULL;

SELECT * 
FROM books 
WHERE title IS NULL;

DELETE 
FROM books
WHERE title IS NULL;

-- Exercises

SELECT *
FROM books
WHERE released_year < 1980;

SELECT *
FROM books
WHERE author_lname IN ('Eggers', 'Chabon')

SELECT *
FROM books
WHERE author_lname = 'Lahiri' 
AND released_year > 2000;

SELECT *
FROM books
WHERE pages BETWEEN 100 AND 200;

SELECT *
FROM books
WHERE SUBSTRING(author_lname, 1, 1) IN ('C', 'S');

SELECT title, author_lname,
	CASE
	WHEN title = 'Just Kids' THEN 'Memoir'
	WHEN title = 'A Heartbreaking Work of Staggering Genius' THEN 'Memoir'
	WHEN title LIKE '%Stories%' THEN 'Short Stories'
	ELSE 'Novel'
	END AS 'TYPE'
FROM books;

SELECT author_fname, author_lname,
	CASE
	WHEN COUNT(*) = 1 THEN '1 book'
	ELSE CONCAT(COUNT(*), ' books')
	END AS COUNT
FROM books
WHERE author_lname IS NOT NULL
GROUP BY author_fname, author_lname;

-- UNIQUE Constraint

CREATE TABLE contacts (
	name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE
);
 
INSERT INTO contacts (name, phone)
VALUES ('billybob', '8781213455');
 
-- This insert would result in an error:
INSERT INTO contacts (name, phone)
VALUES ('billybob', '8781213455');

-- CHECK Constraints

CREATE TABLE users (
	username VARCHAR(20) NOT NULL,
    age INT CHECK (age > 0)
);
DROP TABLE users;

CREATE TABLE palindromes (
  word VARCHAR(100) CHECK(REVERSE(word) = word)
)

INSERT INTO palindromes (word)
VALUES ('mom');

INSERT INTO palindromes (word)
VALUES ('sos');

SELECT *
FROM palindromes;
DROP TABLE palindromes;

-- Named Constraints

CREATE TABLE users2 (
    username VARCHAR(20) NOT NULL,
    age INT,
    CONSTRAINT age_not_negative CHECK (age >= 0)
);
 
CREATE TABLE palindromes2 (
  word VARCHAR(100),
  CONSTRAINT word_is_palindrome CHECK(REVERSE(word) = word)
);

-- Multiple column Constraints
CREATE TABLE houses (
  purchase_price INT NOT NULL,
  sale_price INT NOT NULL,
  CONSTRAINT sprice_gt_pprice CHECK(sale_price >= purchase_price)
);

CREATE TABLE companies (
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    CONSTRAINT name_address UNIQUE (name , address)
);

 
INSERT INTO companies (name, address) 
VALUES ('luigis pies', '123 spruce'),
		('blackbird auto', '123 spruce');

SELECT* 
FROM companies;

--ALTER TABLE: Adding Columns

ALTER TABLE companies
ADD phone VARCHAR(15);

ALTER TABLE companies
ADD employee_count INT NOT NULL DEFAULT 0;

-- ALTER TABLE: Dropping Columns

ALTER TABLE companies
DROP COLUMN phone;

--ALTER TABLE: Renaming tables

RENAME TABLE companies TO suppliers; (--In MySQL)

--OR

ALTER TABLE suppliers RENAME TO companies;  (--In MySQL)

USE book_shop;
GO
EXEC sp_rename 'companies', 'suppliers';

SELECT*
FROM suppliers;

ALTER TABLE suppliers
RENAME COLUMN name TO company_name (--In MYSQL)


-- Rename column in SQL Server
-- EXEC sp_RENAME 'TableName.OldColumnName' , 'NewColumnName', 'COLUMN'
EXEC sp_rename 'suppliers.name', 'company.name', 'COLUMN';

-- ALTER TABLE: Modifying Columns

ALTER TABLE suppliers
MODIFY company.name VARCHAR(100); (--In MySQL)

CREATE TABLE houses (
purchase_price INT NOT NULL,
sale_price INT NOT NULL)
;

INSERT INTO houses
VALUES(10000,15000);

SELECT*
FROM houses;

-- Turn INT into string

ALTER TABLE houses 
ALTER COLUMN sale_price VARCHAR(100) NULL;  
EXEC sp_help houses;

ALTER TABLE houses 
ALTER COLUMN sale_price VARCHAR(250) NOT NULL DEFAULT 'unknown';  
EXEC sp_help houses;

-- Modifying columns using CHANGE

ALTER TABLE houses
CHANGE sale_price saleprice2 VARCHAR(50); (--In MySQL only)

-- ALTER TABLE: Constraints
ALTER TABLE houses 
ADD CONSTRAINT positive_pprice CHECK (purchase_price >= 0);

INSERT INTO houses (purchase_price)
VALUES (112345);

-- One to Many & Joins
-- Relationships Basics
-- One to many relationships 
-- E.g. one customer can make many orders, but each of these orders can only have one customer.
-- Primary key's are always unique / there cannot be duplicates

--  Working with FOREIGN KEY

CREATE TABLE customers (
    id INT PRIMARY KEY IDENTITY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE orders (
    id INT PRIMARY KEY IDENTITY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016-02-10', 99.99, 1),
       ('2017-11-11', 35.50, 1),
       ('2014-12-12', 800.67, 2),
       ('2015-01-03', 12.50, 2),
       ('1999-04-11', 450.25, 5);

SELECT *
FROM customers;

SELECT *
FROM orders;

-- CROSS JOINS

SELECT id FROM customers WHERE last_name = 'George';

SELECT * FROM orders WHERE customer_id = 1;
 
SELECT * FROM orders 
WHERE customer_id = (SELECT id FROM  customers WHERE last_name = 'George')

-- To perform a  cross join:
SELECT * FROM customers, orders;

-- Inner joins

SELECT * FROM customers
JOIN orders
	ON customers.id = orders.customer_id;

-- With aliases + Creating a CTE to then extract year from new 'first_order' column

WITH #temp AS 

	(SELECT c.first_name, c.last_name, o.order_date, o.amount
, AVG(ROUND(amount,2)) OVER (PARTITION BY last_name) AS avg_spending
, SUM(ROUND(amount,2)) OVER (PARTITION BY last_name) AS agg_spending
, MIN(order_date) OVER(PARTITION BY last_name) AS first_order
FROM customers c
JOIN orders o
	ON c.id = o.customer_id
	)

SELECT *, YEAR(first_order) as 'year', MONTH(first_order) as 'month', DAY(first_order) as 'day'
FROM #temp


-- Changing the order does not matter - the only difference is the column order changes.
SELECT * FROM orders
JOIN customers
	ON customers.id = orders.customer_id;

-- N.B Join function is the same as Inner join

-- Inner joins with group by
SELECT 
    first_name, last_name, SUM(amount) AS total
FROM
    customers
        JOIN
    orders ON orders.customer_id = customers.id
GROUP BY first_name , last_name
ORDER BY total;

-- Left join
-- Select everything from a left table along with any matching records in the right table
-- E.g. We keep every row in the customer table, and only take the matching orders data from the orders table. 
-- What is the purpose of the left join? Do we have any users who have not placed any order / inactive users? Then use a left join which
-- will show NULL values for users/customers who have not placed an order.
-- E.g. 

SELECT 
    first_name, last_name, order_date, amount
FROM
    customers
        LEFT JOIN
    orders ON orders.customer_id = customers.id;


SELECT 
    order_date, amount, first_name, last_name
FROM
    orders
        LEFT JOIN
    customers ON orders.customer_id = customers.id;

-- LEFT JOIN with group by

SELECT first_name, last_name, amount, COUNT(*) AS 'num. of null orders' FROM customers
	LEFT JOIN orders
	ON customers.id = orders.customer_id
WHERE amount IS NULL
GROUP BY first_name, last_name, amount

-- Filter by customers which did not make an order
SELECT CONCAT(first_name, ' ', last_name) AS 'Inactive customers' FROM customers
	LEFT JOIN orders
	ON customers.id = orders.customer_id
WHERE amount IS NULL

-- To turn null values into 0:
-- Add this line of code: ISNULL(SUM(amount), 0) OR use COALESCE commandline
-- Add FLOOR() function to remove decimal places

WITH #temp AS
			(
			SELECT first_name, last_name, FLOOR(ISNULL(SUM(amount),0)) AS money_spent FROM customers
	LEFT JOIN orders
	ON customers.id = orders.customer_id
GROUP BY first_name, last_name
			)

SELECT *, MAX(money_spent) OVER () AS 'max spent' FROM #temp
ORDER BY money_spent DESC;

-- RIGHT JOIN
-- Select everything from B (right table) along with any matching records in A (left table)

SELECT 
    first_name, last_name, order_date, amount
FROM
    customers
        RIGHT JOIN
    orders ON customers.id = orders.customer_id;

-- On DELETE Cascade

DELETE FROM customers WHERE last_name LIKE '__or__'

-- Returns the following error: Msg 547, Level 16, State 0, Line 1961
--The DELETE statement conflicted with the REFERENCE constraint "FK__orders__customer__6383C8BA". 
--The conflict occurred in database "UDEMY", table "dbo.orders", column 'customer_id'.


CREATE TABLE customers (
    id INT PRIMARY KEY IDENTITY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE orders (
    id INT PRIMARY KEY IDENTITY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- ON DELETE CASCADE says that on the FOREIGN KEY which references customers(id) if id of a given customer is deleted from
-- one table, it will delete every row from orders which has that customer id.
-- Let's try again to delete 'Steele' from the customer (which will also remove rows from orders table associated with 'Steele')

DELETE FROM customers WHERE last_name = 'Steele'

-- Cross join to see if Steele has been removed from both tables

SELECT *
FROM customers, orders;

-- It worked!

-- Joins Exercises

CREATE TABLE students
		(id TINYINT PRIMARY KEY IDENTITY,
		first_name VARCHAR(50)
		);

CREATE TABLE papers
		(title VARCHAR(50),
		grade TINYINT,
		student_id TINYINT,
		FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE)
		;
		
INSERT INTO students (first_name) VALUES 
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');
 
INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

SELECT*
FROM students;

SELECT*
FROM papers;

SELECT s.first_name, p.title, p.grade
FROM students s
	JOIN papers p
	ON s.id = p.student_id
ORDER BY p.grade DESC;

SELECT s.first_name, p.title, p.grade
FROM students s
	LEFT JOIN papers p
	ON s.id = p.student_id;

SELECT s.first_name, ISNULL(p.title, 'MISSING'), COALESCE(p.grade, 0)
FROM students s
	LEFT JOIN papers p
	ON s.id = p.student_id;

SELECT s.first_name, FORMAT(AVG(p.grade),'0.0000') 'average'
FROM students s
	LEFT JOIN papers p
	ON s.id = p.student_id
GROUP BY s.first_name
ORDER BY 2 DESC;


WITH #temp AS(
SELECT s.first_name, CAST(ISNULL(AVG(p.grade),0) AS DECIMAL(7,4)) AS 'average'
FROM students s
	LEFT JOIN papers p
	ON s.id = p.student_id
GROUP BY s.first_name)

SELECT *, CASE 
	WHEN average <= 75 THEN 'failing'
	ELSE 'passing'
	END AS 'passing_status'
FROM #temp
ORDER BY average DESC

-- OR --

SELECT 
    first_name,
    ISNULL(AVG(grade), 0) AS average,
    CASE
        WHEN ISNULL(AVG(grade), 0) >= 75 THEN 'passing'
        ELSE 'failing'
    END AS passing_status
FROM
    students
        LEFT JOIN
    papers ON students.id = papers.student_id
GROUP BY first_name
ORDER BY average DESC;

-- MANY 2 MANY
-- E.g. books can have many authors and viceversa


CREATE TABLE reviewers (
    id INT PRIMARY KEY IDENTITY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE series (
    id INT PRIMARY KEY IDENTITY,
    title VARCHAR(100),
    released_year SMALLINT,
    genre VARCHAR(100)
);

CREATE TABLE reviews (
    id INT PRIMARY KEY IDENTITY,
    rating DECIMAL(2 , 1 ),
    series_id INT,
    reviewer_id INT,
    FOREIGN KEY (series_id)
        REFERENCES series (id), 
    FOREIGN KEY (reviewer_id)
        REFERENCES reviewers (id) ON DELETE CASCADE
);
 

INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ('Bob''s Burgers', 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ('Breaking Bad', 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ('Fargo', 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
 
 
INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
 
INSERT INTO reviews(series_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);

SELECT TOP 15 s.title, r.rating
FROM series s
	JOIN reviews r
	ON s.id = r.series_id;


SELECT *
FROM series s
	JOIN reviews r
	ON s.id = r.series_id;


SELECT s.title, ROUND(AVG(rating), 2) AS avg_rating
FROM series s
	JOIN reviews r
	ON s.id = r.series_id
GROUP BY s.title
ORDER BY avg_rating;

SELECT TOP 15 r2.first_name, r2.last_name, r1.rating
FROM reviewers r2
	JOIN reviews r1
	ON r2.id = r1.reviewer_id
ORDER BY r2.last_name DESC;

SELECT s.title, r.rating AS unreviewed_series 
FROM series s
	LEFT JOIN reviews r
	ON s.id = r.series_id
WHERE r.rating IS NULL;

-- OR-- 

SELECT s.title, r.rating AS unreviewed_series 
FROM reviews r
	RIGHT JOIN series s
	ON s.id = r.series_id
WHERE r.rating IS NULL;

SELECT s.genre, ROUND(AVG(rating), 2) AS avg_rating 
FROM series s
	JOIN reviews r
	ON s.id=r.series_id
GROUP BY genre;


SELECT r2.first_name, r2.last_name, COUNT(rating) AS 'count', ISNULL(MIN(r1.rating),0) AS 'min', ISNULL(MAX(r1.rating),0) AS 'max', ISNULL(AVG(r1.rating),0) AS 'average',
	CASE
		WHEN COUNT(rating) >= 10 THEN 'POWERUSER'
		WHEN COUNT(rating) > 0 THEN 'ACTIVE'
		ELSE 'INACTIVE'
	END AS 'STATUS'
FROM reviewers r2
	LEFT JOIN reviews r1
	ON r2.id = r1.reviewer_id
GROUP BY r2.first_name, r2.last_name;


-- USING IF (n.b - only works in MySQL)

SELECT 
    first_name,
    last_name,
    COUNT(rating) AS count,
    ISNULL(MIN(rating), 0) AS min,
    ISNULL(MAX(rating), 0) AS max,
    ROUND(ISNULL(AVG(rating), 0), 2) AS average,
    IF(COUNT(rating) > 0,
        'ACTIVE',
        'INACTIVE') AS status
FROM
    reviewers
        LEFT JOIN
    reviews ON reviewers.id = reviews.reviewer_id
GROUP BY first_name , last_name;

SELECT s.title, r1.rating, CONCAT(r2.first_name, ' ', r2.last_name) AS 'reviewer'
FROM series s
	INNER JOIN reviews r1
	ON s.id = r1.series_id
	INNER JOIN reviewers r2
	ON r1.reviewer_id = r2.id;


-- MySQL Views
-- A VIEW in SQL Server is like a virtual table that contains data from one or multiple tables. 

CREATE VIEW full_reviews AS 

SELECT 
    title, released_year, genre, rating, first_name, last_name
FROM
    reviews
        JOIN
    series ON series.id = reviews.series_id
        JOIN
    reviewers ON reviewers.id = reviews.reviewer_id;


SELECT * FROM full_reviews 
WHERE genre = 'Animation';

SELECT * FROM full_reviews 
WHERE title like 'Ar%';

SELECT genre, AVG(rating) FROM full_reviews
GROUP BY genre;

-- Updateable Views
--N.B-- You cannot DELETE rows in a virtual table.
-- N.b. Generally, you cannot update/delete rows in views virtual tables.
-- Sometimes, however, you can insert values into a virtutal table (see below) in cases when \
-- aggregate functions, disctinct, group by, union, certain joins, and subqueries are not used.

CREATE VIEW ordered_series AS 
SELECT * FROM series ORDER BY released_year OFFSET 0 ROWS;

SELECT * FROM ordered_series

INSERT INTO ordered_series (title, released_year, genre)
VALUES ('The Great', 2020, 'Comedy');

SELECT * FROM ordered_series;

DELETE FROM ordered_series 
WHERE title = 'The Great';

SELECT * FROM ordered_series;

-- Replacing/altering views 
-- If VIEW already exists, you should use the ALTER function (in MySQL, we use REPLACE), if VIEW does not exist, use CREATE.


ALTER VIEW ordered_series AS 
SELECT * FROM series ORDER BY released_year DESC OFFSET 0 ROWS;

DROP VIEW ordered_series;
SELECT * FROM ordered_series;

-- HAVING clauses - used for filtering groups in conjunction with groupby

SELECT released_year, AVG(rating) AS [avg_rating by year]
FROM full_reviews
GROUP BY released_year
HAVING released_year BETWEEN 1963 AND 2000;


SELECT 
    title, 
    AVG(rating),
    COUNT(rating) AS review_count
FROM full_reviews 
GROUP BY title HAVING COUNT(rating) > 1;

-- Groupby WITH ROLLUP

SELECT AVG(rating)
FROM full_reviews

SELECT AVG(rating)
FROM full_reviews
GROUP BY title;

SELECT AVG(rating)
FROM full_reviews
GROUP BY title WITH ROLLUP; 

SELECT title,
COUNT(rating)
FROM full_reviews
GROUP BY title WITH ROLLUP; 

-- Rollup adds a summary statistic for the whole column. In other words, we have avg. ratings for 
-- every title and on the last row, we have the avg. for all the films

SELECT released_year, genre, AVG(rating)
FROM full_reviews
GROUP BY released_year, genre;

SELECT released_year, genre, AVG(rating)
FROM full_reviews
GROUP BY released_year, genre WITH ROLLUP; 

--Each one of these nulls represent a summary statistic. 
-- First row is avg. rating for 'Drama' genre films in 1963, the second row represents avg.rating for all films in 1963.
-- The final two rows represent summary statistics for avg.rating irrespective of year or genre and is the highest level summary statistic.

-- SQL Modes Basics (for MySqL only)

-- To View Modes:
SELECT @@GLOBAL.sql_mode;
SELECT @@SESSION.sql_mode;
 
-- To Set Them:
SET GLOBAL sql_mode = 'modes';
SET SESSION sql_mode = 'modes';

-- Window functions
-- N.B. Windows functions perform aggregate operations on groups of rows, but they produce a result FOR EACH ROW.

-- Using OVER()


CREATE TABLE employees (
    emp_no INT PRIMARY KEY IDENTITY,
    department VARCHAR(20),
    salary INT
);

INSERT INTO employees (department, salary) VALUES
('engineering', 80000),
('engineering', 69000),
('engineering', 70000),
('engineering', 103000),
('engineering', 67000),
('engineering', 89000),
('engineering', 91000),
('sales', 59000),
('sales', 70000),
('sales', 159000),
('sales', 72000),
('sales', 60000),
('sales', 61000),
('sales', 61000),
('customer service', 38000),
('customer service', 45000),
('customer service', 61000),
('customer service', 40000),
('customer service', 31000),
('customer service', 56000),
('customer service', 55000);

-- The over clause constructs a window. When it's empty, the window will include all records.
SELECT emp_no, department, salary, AVG(salary) OVER() FROM employees;

SELECT 
    emp_no, 
    department, 
    salary, 
    MIN(salary) OVER(),
    MAX(salary) OVER()
FROM employees;

-- PARTITION by
-- Inside of the over(), use Partition by to form rows into groups of rows

SELECT 
    emp_no, 
    department, 
    salary, 
    AVG(salary) OVER(PARTITION BY department) AS dept_avg,
    AVG(salary) OVER() AS company_avg
FROM employees;

SELECT 
    emp_no, 
    department, 
    salary, 
    COUNT(*) OVER(PARTITION BY department) as dept_count
FROM employees;

SELECT 
    emp_no, 
    department, 
    salary, 
    SUM(salary) OVER(PARTITION BY department) AS dept_payroll,
    SUM(salary) OVER() AS total_payroll
FROM employees;

-- ORDER BY inside of OVER()
-- USE ORDER BY inside of OVER() clause to re-order rows within each window.

SELECT 
    emp_no, 
    department, 
    salary, 
    SUM(salary) OVER(PARTITION BY department ORDER BY salary DESC) AS rolling_dept_salary,
    SUM(salary) OVER(PARTITION BY department) AS total_dept_salary
FROM employees;

SELECT 
    emp_no, 
    department, 
    salary, 
    MIN(salary) OVER(PARTITION BY department ORDER BY salary DESC) as rolling_min
FROM employees;

-- RANK()
-- DENSE_RANK & ROW_NUMBER()
-- N.B RANK() is exclusively a window function

SELECT 
    emp_no, 
    department, 
    salary,
    ROW_NUMBER() OVER(PARTITION BY department ORDER BY SALARY DESC) as dept_row_number, -- Numbered rows according to salaries from highest to lowest grouped by department.
    RANK() OVER(PARTITION BY department ORDER BY SALARY DESC) as dept_salary_rank, -- Same as row_number() 
    RANK() OVER(ORDER BY salary DESC) as overall_rank, -- Salaries are ranked from 1-n in descending order. 
    DENSE_RANK() OVER(ORDER BY salary DESC) as overall_dense_rank, -- Salaries are ranked from 1-n in descending order but numbers are sequential w/o gaps in the order.
    ROW_NUMBER() OVER(ORDER BY salary DESC) as overall_num  -- Numbered rows according to salaries from highest to lowest.
FROM employees ORDER BY overall_rank;

-- NTILE 

SELECT 
    emp_no, 
    department, 
    salary,
    NTILE(4) OVER(PARTITION BY department ORDER BY salary DESC) AS dept_salary_quartile,
	NTILE(4) OVER(ORDER BY salary DESC) AS salary_quartile
FROM employees

-- FIRST VALUE

SELECT 
    emp_no, 
    department, 
    salary,
    FIRST_VALUE(emp_no) OVER(PARTITION BY department ORDER BY salary DESC) as highest_paid_dept,
    FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC) as highest_paid_overall
FROM employees;

-- LEAD and LAG

SELECT 
    emp_no, 
    department, 
    salary,
    salary - LAG(salary) OVER(ORDER BY salary DESC) as salary_diff
FROM employees;

SELECT 
    emp_no, 
    department, 
    salary,
    salary - LAG(salary) OVER(PARTITION BY department ORDER BY salary DESC) as dept_salary_diff
FROM employees;