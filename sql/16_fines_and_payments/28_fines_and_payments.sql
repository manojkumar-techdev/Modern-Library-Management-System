-- Fines and Payments


-- Query 1 (Displays outstanding fines)
SELECT
    f.fine_id,

    CONCAT(
        m.first_name,
        ' ',
        m.last_name
    ) AS member_name,

    f.fine_amount,
    f.fine_reason,
    f.fine_date,
    f.payment_status

FROM fines f

JOIN members m
    ON f.member_id = m.member_id

WHERE f.payment_status <> 'Paid'

ORDER BY f.fine_amount DESC;





-- Query 2 (Displays fine collection report)
SELECT

    COALESCE(
        SUM(fine_amount),
        0
    ) AS total_fines,

    COALESCE(
        SUM(
            CASE
                WHEN payment_status = 'Paid'
                THEN fine_amount
                ELSE 0
            END
        ),
        0
    ) AS paid_fines,

    COALESCE(
        SUM(
            CASE
                WHEN payment_status <> 'Paid'
                THEN fine_amount
                ELSE 0
            END
        ),
        0
    ) AS unpaid_fines

FROM fines;