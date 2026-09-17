-- Triggers


-- Query 1 (prevent a library book copy from being borrowed when it is not available)
DELIMITER //
CREATE TRIGGER before_loan_insert
BEFORE INSERT ON loans
FOR EACH ROW
BEGIN

    DECLARE v_status VARCHAR(20);

    SELECT availability_status
    INTO v_status
    FROM book_copies
    WHERE copy_id = NEW.copy_id;

    IF v_status <> 'Available' THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'This book copy is not available for borrowing';

    END IF;

END //
DELIMITER ;


-- Query 2 (Marks copy as borrowed)

DELIMITER //
CREATE TRIGGER after_loan_insert
AFTER INSERT ON loans
FOR EACH ROW
BEGIN

    UPDATE book_copies
    SET availability_status = 'Borrowed'
    WHERE copy_id = NEW.copy_id;

    UPDATE books b
    JOIN book_copies bc
        ON b.book_id = bc.book_id
    SET b.available_copies =
        GREATEST(
            b.available_copies - 1,
            0
        )
    WHERE bc.copy_id = NEW.copy_id;

END //
DELIMITER ;

-- Query 3 (Automatically updates the library inventory when a borrowed book is returned)

DELIMITER //
CREATE TRIGGER after_loan_return
AFTER UPDATE ON loans
FOR EACH ROW
BEGIN

    IF OLD.status <> 'Returned'
       AND NEW.status = 'Returned' THEN

        UPDATE book_copies
        SET availability_status = 'Available'
        WHERE copy_id = NEW.copy_id;

        UPDATE books b
        JOIN book_copies bc
            ON b.book_id = bc.book_id
        SET b.available_copies =
            LEAST(
                b.available_copies + 1,
                b.total_copies
            )
        WHERE bc.copy_id = NEW.copy_id;

    END IF;

END //
DELIMITER ;


-- Query 4 (Automatically automatically determines whether a fine is unpaid, partially paid, or paid)

DELIMITER //
CREATE TRIGGER after_payment_insert
AFTER INSERT ON payments
FOR EACH ROW
BEGIN

    DECLARE v_fine_amount DECIMAL(10,2);
    DECLARE v_paid_amount DECIMAL(10,2);

    SELECT fine_amount
    INTO v_fine_amount
    FROM fines
    WHERE fine_id = NEW.fine_id;

    SELECT COALESCE(SUM(amount), 0)
    INTO v_paid_amount
    FROM payments
    WHERE fine_id = NEW.fine_id;

    UPDATE fines
    SET payment_status =
        CASE
            WHEN v_paid_amount >= v_fine_amount
                THEN 'Paid'

            WHEN v_paid_amount > 0
                THEN 'Partially Paid'

            ELSE 'Unpaid'
        END
    WHERE fine_id = NEW.fine_id;

END //
DELIMITER ;
