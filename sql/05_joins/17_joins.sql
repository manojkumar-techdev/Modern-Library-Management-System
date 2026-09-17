-- Joins



-- Query 1 (Inner join)
-- Shows books with Author, Publisher, and Category
SELECT
    b.book_id,
    b.title,
    a.author_name,
    p.publisher_name,
    c.category_name
FROM books b
INNER JOIN authors a
    ON b.author_id = a.author_id
INNER JOIN publishers p
    ON b.publisher_id = p.publisher_id
INNER JOIN categories c
    ON b.category_id = c.category_id;
    
    

-- Query 2 (Left Join)
-- Shows authors even when they have no books.
SELECT
    a.author_id,
    a.author_name,
    b.title
FROM authors a
LEFT JOIN books b
    ON a.author_id = b.author_id
ORDER BY a.author_name;



-- Query 3 (Right Join)
-- Show publishers and their books
SELECT
    b.title,
    p.publisher_name
FROM books b
RIGHT JOIN publishers p
    ON b.publisher_id = p.publisher_id;
    
    

-- Query 4 (Right Join)
-- Combines 5 tables to produce a complete loan report
SELECT
    l.loan_id,
    b.title,
    bc.barcode,
    CONCAT(
        m.first_name, ' ', m.last_name
    ) AS member_name,
    CONCAT(
        lib.first_name, ' ', lib.last_name
    ) AS librarian_name,
    l.issue_date,
    l.due_date,
    l.return_date,
    l.status
FROM loans l
JOIN book_copies bc
    ON l.copy_id = bc.copy_id
JOIN books b
    ON bc.book_id = b.book_id
JOIN members m
    ON l.member_id = m.member_id
JOIN librarians lib
    ON l.librarian_id = lib.librarian_id;