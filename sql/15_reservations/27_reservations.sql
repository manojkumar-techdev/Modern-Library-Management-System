-- Reservations


-- Query 1 (Displays pending reservations)
SELECT
    r.reservation_id,
    b.title,

    CONCAT(
        m.first_name,
        ' ',
        m.last_name
    ) AS member_name,

    r.reservation_date,
    r.expiry_date,
    r.status

FROM reservations r

JOIN books b
    ON r.book_id = b.book_id

JOIN members m
    ON r.member_id = m.member_id

WHERE r.status = 'Pending'

ORDER BY r.reservation_date;


-- Query 2 (Displays created reservations)
INSERT INTO reservations
(
    book_id,
    member_id,
    reservation_date,
    expiry_date,
    status
)
VALUES
(
    7,
    2,
    CURDATE(),
    DATE_ADD(
        CURDATE(),
        INTERVAL 7 DAY
    ),
    'Pending'
);