-- Subqueries


-- Query 1 (Displays books above average price)
SELECT
    title,
    price
FROM books
WHERE price > (
    SELECT AVG(price)
    FROM books
);


-- Query 2 (Displays most expensive books)
SELECT
    title,
    price
FROM books
WHERE price = (
    SELECT MAX(price)
    FROM books
);



-- Query 3 (Displays members who have borrowed books)
SELECT
    member_id,
    first_name,
    last_name
FROM members
WHERE member_id IN (
    SELECT member_id
    FROM loans
);


-- Query 4 (Displays books which were never borrowed)
SELECT
    book_id,
    title
FROM books
WHERE book_id NOT IN (
    SELECT bc.book_id
    FROM book_copies bc
    JOIN loans l
        ON bc.copy_id = l.copy_id
);

