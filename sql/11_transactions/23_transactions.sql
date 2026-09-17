-- Transactions



# -- Query 1 (Start Transaction)
-- (Begins a transaction, which groups one or more SQL operations into a single unit)
-- Example Query (This transaction records a $5.00 card payment)

START TRANSACTION;
INSERT INTO payments (
    fine_id,
    member_id,
    amount,
    payment_method,
    transaction_reference
)
VALUES (
    5,
    5,
    5.00,
    'Card',
    'TXN-20260915-005'
);
COMMIT;




# -- Query 2 (Commit)
-- (Permanently saves all changes made during the current transaction)
-- Example Query (Borrows a book copy)

START TRANSACTION;
INSERT INTO loans (
    copy_id,
    member_id,
    librarian_id,
    issue_date,
    due_date,
    status
)
VALUES (
    6,
    1,
    1,
    CURDATE(),
    DATE_ADD(CURDATE(), INTERVAL 14 DAY),
    'Issued'
);
COMMIT;




# -- Query 3 (Roll back) 
-- (Cancels changes made during a transaction and restore the database to the state it had before the transaction started)

START TRANSACTION;

UPDATE members
SET status = 'Suspended'
WHERE member_id = 1;

UPDATE books
SET price = price + 100
WHERE book_id = 1;

ROLLBACK;




# -- Query 4 (Savepoint)
-- Query 1 (creates a temporary checkpoint inside a transaction) 


START TRANSACTION;

UPDATE members
SET status = 'Active'
WHERE member_id = 10;

SAVEPOINT member_update;

UPDATE books
SET price = price + 5
WHERE book_id = 10;

ROLLBACK TO SAVEPOINT member_update;

COMMIT;


