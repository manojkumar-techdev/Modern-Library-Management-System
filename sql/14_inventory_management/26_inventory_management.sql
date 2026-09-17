-- Inventory Management


-- Query 1 (Displays inventory summary)
SELECT
    b.book_id,
    b.title,
    b.total_copies,
    b.available_copies,

    b.total_copies
    - b.available_copies AS borrowed_copies

FROM books b
ORDER BY b.title;


-- Query 2 (Displays available physical copies)
SELECT
    bc.barcode,
    b.title,
    bc.shelf_location,
    bc.condition_status
FROM book_copies bc
JOIN books b
    ON bc.book_id = b.book_id
WHERE bc.availability_status = 'Available';



-- Query 3 (Displays borrowed physical copies)
SELECT
    bc.barcode,
    b.title,
    bc.shelf_location
FROM book_copies bc
JOIN books b
    ON bc.book_id = b.book_id
WHERE bc.availability_status = 'Borrowed';
