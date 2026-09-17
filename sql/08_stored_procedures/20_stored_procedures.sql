-- Stored Procedures


-- Query 1 (Searches for books containing Great in the title or author name)
-- DROP PROCEDURE IF EXISTS SearchBook(Runs the query again if SearchBooks Procedure already exists.
-- If DROP PROCEDURE not used, MySQL shows that procedure already exists.
DROP PROCEDURE IF EXISTS SearchBooks;
DELIMITER //

CREATE PROCEDURE SearchBooks(
    IN p_keyword VARCHAR(100)
)
BEGIN
    SELECT
        b.book_id,
        b.title,
        a.author_name,
        b.price,
        b.available_copies
    FROM books b
    JOIN authors a
        ON b.author_id = a.author_id
    WHERE b.title LIKE CONCAT('%', p_keyword, '%')
       OR a.author_name LIKE CONCAT('%', p_keyword, '%');
END //

DELIMITER ;

CALL SearchBooks('Harry');



-- Query 2 (Returns all loans belonging to specific member_id)
DROP PROCEDURE IF EXISTS GetMemberLoans;
DELIMITER //
CREATE PROCEDURE GetMemberLoans(
    IN p_member_id INT
)
BEGIN

    SELECT
        l.loan_id,
        b.title,
        l.issue_date,
        l.due_date,
        l.return_date,
        l.status
    FROM loans l
    JOIN book_copies bc
        ON l.copy_id = bc.copy_id
    JOIN books b
        ON bc.book_id = b.book_id
    WHERE l.member_id = p_member_id
    ORDER BY l.issue_date DESC;

END //
DELIMITER ;