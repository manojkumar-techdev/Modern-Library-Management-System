-- Views

-- Query 1 (Displays book catalogue view)

CREATE VIEW book_catalog AS
SELECT
    b.book_id,
    b.title,
    b.isbn,
    a.author_name,
    p.publisher_name,
    c.category_name,
    b.publication_year,
    b.price,
    b.total_copies,
    b.available_copies
FROM books b
JOIN authors a
    ON b.author_id = a.author_id
LEFT JOIN publishers p
    ON b.publisher_id = p.publisher_id
JOIN categories c
    ON b.category_id = c.category_id;

SELECT *
FROM book_catalog;



    
-- Query 1 (Displays loan report view)

CREATE VIEW loan_report AS
SELECT
    l.loan_id,
    b.title,
    bc.barcode,

    CONCAT(
        m.first_name,
        ' ',
        m.last_name
    ) AS member_name,

    CONCAT(
        lib.first_name,
        ' ',
        lib.last_name
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




-- Query 1 (Displays available inventory view)
CREATE VIEW available_inventory AS
SELECT
    bc.copy_id,
    bc.barcode,
    b.title,
    bc.shelf_location,
    bc.condition_status
FROM book_copies bc
JOIN books b
    ON bc.book_id = b.book_id
WHERE bc.availability_status = 'Available';