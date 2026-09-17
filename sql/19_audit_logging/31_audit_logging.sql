-- Audit Logging


-- Query 1 (Records changes made to the database)
CREATE TABLE audit_log (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(100) NOT NULL,
    record_id INT,
    action_type ENUM(
        'INSERT',
        'UPDATE',
        'DELETE'
    ) NOT NULL,
    action_description TEXT,
    action_time TIMESTAMP
        DEFAULT CURRENT_TIMESTAMP
);



-- Query 2 (Displays the audit history)
SELECT
    log_id,
    table_name,
    record_id,
    action_type,
    action_description,
    action_time
FROM audit_log
ORDER BY action_time DESC;