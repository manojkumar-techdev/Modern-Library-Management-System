-- Library Events

-- Query 1 (Displays upcoming events)
SELECT
    event_id,
    event_name,
    description,
    event_date,
    start_time,
    end_time,
    capacity,
    organizer
FROM library_events
WHERE event_date >= CURDATE()
ORDER BY event_date, start_time;



-- Query 2 (Displays addedevents)
INSERT INTO library_events
(
    event_name,
    description,
    event_date,
    start_time,
    end_time,
    capacity,
    organizer
)
VALUES
(
    'Technology Workshop',
    'Introduction to modern digital technologies',
    '2026-06-10',
    '11:00:00',
    '14:00:00',
    60,
    'Technology Department'
);