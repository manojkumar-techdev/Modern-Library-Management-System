-- Basic Queries



-- Query 1 (Displays all books)
SELECT *
FROM books;



-- Query 2 (Displays books costing more than 20)
SELECT
    title,
    price
FROM books
WHERE price > 20;



-- Query 3 (Searches book by title)
SELECT *
FROM books
WHERE title LIKE '%Great%';



-- Query 4 (Sorts book by title)
SELECT
    title,
    price
FROM books
ORDER BY price DESC;



-- Query 5 (Displays active members)
SELECT *
FROM members
WHERE status = 'Active';



-- Query 6 (Displays avialabe copies)
SELECT
    bc.barcode,
    b.title,
    bc.shelf_location
FROM book_copies bc
JOIN books b
    ON bc.book_id = b.book_id
WHERE bc.availability_status = 'Available';


# Query -- 7
-- CREATE: Add a new library member
INSERT INTO members
(first_name, last_name, email, phone, address, membership_date, status)
VALUES
('John', 'Smith', 'john.smith@library.com',
 '491900000001', 'Berlin, Germany', '2026-09-17', 'Active');
 
 
# Query -- 8
-- READ: Displays a specific member
SELECT *
FROM members
WHERE email = 'john.smith@library.com';



-- Query -- 9
-- UPDATE: Change the member's phone number
UPDATE members
SET phone = '491900000999'
WHERE email = 'john.smith@library.com';


-- Query -- 10
-- DELETE: Remove the member
DELETE FROM members
WHERE email = 'john.smith@library.com';



INSERT INTO members
(first_name, last_name, email, phone, address, membership_date, status)
VALUES
('John', 'Smith', 'john.smith@library.com',
'491900000001', 'Berlin, Germany', '2026-09-17', 'Active');