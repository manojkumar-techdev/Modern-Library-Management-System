-- Stored Functions


-- Query 1 (Calculates fine and charges 2.00 per overdue day)
DELIMITER //
CREATE FUNCTION CalculateFine(
    p_due_date DATE,
    p_return_date DATE
)
RETURNS DECIMAL(10,2)
NOT DETERMINISTIC
BEGIN

    DECLARE v_late_days INT;

    IF p_return_date IS NULL THEN

        SET v_late_days =
            DATEDIFF(CURDATE(), p_due_date);

    ELSE

        SET v_late_days =
            DATEDIFF(p_return_date, p_due_date);

    END IF;

    IF v_late_days <= 0 THEN
        RETURN 0.00;
    END IF;

    RETURN v_late_days * 2.00;

END //
DELIMITER ;

SELECT
    loan_id,
    due_date,
    return_date,
    CalculateFine(
        due_date,
        return_date
    ) AS calculated_fine
FROM loans;



-- Query 2 (Dispalys total payments made by a member)
DELIMITER //
CREATE FUNCTION GetMemberTotalPayments(
    p_member_id INT
)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT COALESCE(SUM(amount), 0.00)
    INTO v_total
    FROM payments
    WHERE member_id = p_member_id;

    RETURN v_total;
END //
DELIMITER ;

-- Use function applying SELECT command
SELECT GetMemberTotalPayments(1) AS total_payments;



-- Query 3 (Counts reviews of a book)
DELIMITER //
CREATE FUNCTION GetBookReviewCount(
    p_book_id INT
)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_count INT;

    SELECT COUNT(*)
    INTO v_count
    FROM reviews
    WHERE book_id = p_book_id;

    RETURN v_count;
END //
DELIMITER ;

-- Use function applying SELECT command
SELECT GetBookReviewCount(1) AS review_count;