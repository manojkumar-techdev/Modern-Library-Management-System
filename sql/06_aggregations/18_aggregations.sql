-- Aggregations



-- Query 1 (Displays total number of titles)
SELECT COUNT(*) AS total_titles
FROM books;



-- Query 2 (Displays total physical copies)
SELECT SUM(total_copies) AS total_copies
FROM books;



-- Query 3 (Displays available copies)
SELECT SUM(available_copies) AS available_copies
FROM books;



-- Query 4 (Displays average book price)
SELECT ROUND(AVG(price), 2) AS average_price
FROM books;



-- Query 5 (Displays highest price)
SELECT MAX(price) AS highest_price
FROM books;



-- Query 6 (Displays lowest price)
SELECT MIN(price) AS lowest_price
FROM books;


-- Query 7 (Displays books per category)
SELECT
    c.category_name,
    COUNT(b.book_id) AS total_books
FROM categories c
LEFT JOIN books b
    ON c.category_id = b.category_id
GROUP BY
    c.category_id,
    c.category_name
ORDER BY total_books DESC;



-- Query 8 (Displays most active members)
SELECT
    m.member_id,
    CONCAT(
        m.first_name, ' ', m.last_name
    ) AS member_name,
    COUNT(l.loan_id) AS total_loans
FROM members m
LEFT JOIN loans l
    ON m.member_id = l.member_id
GROUP BY
    m.member_id,
    m.first_name,
    m.last_name
ORDER BY total_loans DESC;