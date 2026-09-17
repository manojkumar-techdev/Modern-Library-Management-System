-- Reports


-- Query 1 (Displays libray dashboard)
SELECT

    (
        SELECT COUNT(*)
        FROM books
    ) AS total_titles,

    (
        SELECT COUNT(*)
        FROM book_copies
    ) AS physical_copies,

    (
        SELECT COUNT(*)
        FROM book_copies
        WHERE availability_status = 'Available'
    ) AS available_copies,

    (
        SELECT COUNT(*)
        FROM book_copies
        WHERE availability_status = 'Borrowed'
    ) AS borrowed_copies,

    (
        SELECT COUNT(*)
        FROM members
        WHERE status = 'Active'
    ) AS active_members,

    (
        SELECT COUNT(*)
        FROM loans
        WHERE status = 'Issued'
    ) AS active_loans,

    (
        SELECT COUNT(*)
        FROM loans
        WHERE status = 'Overdue'
    ) AS overdue_loans,

    (
        SELECT COALESCE(
            SUM(fine_amount), 0
        )
        FROM fines
        WHERE payment_status <> 'Paid'
    ) AS unpaid_fines;
    
    
    
-- Query 2 (Displays overdue books)    
SELECT
    l.loan_id,
    b.title,
    CONCAT(
        m.first_name,
        ' ',
        m.last_name
    ) AS member_name,
    l.due_date,

    DATEDIFF(
        CURDATE(),
        l.due_date
    ) AS days_overdue

FROM loans l

JOIN book_copies bc
    ON l.copy_id = bc.copy_id

JOIN books b
    ON bc.book_id = b.book_id

JOIN members m
    ON l.member_id = m.member_id

WHERE l.status = 'Overdue'

ORDER BY days_overdue DESC;