-- Indexes


-- Query 1 (Creates an Index on Book Titles)
CREATE INDEX idx_books_title
ON books(title);


-- Query 2 (Creates an Index on Author ID)
CREATE INDEX idx_books_author
ON books(author_id);


-- Query 3 (Creates an Index on Category ID)
CREATE INDEX idx_books_category
ON books(category_id);


-- Query 4 (Creates an Index on Book Copies)
CREATE INDEX idx_copies_book
ON book_copies(book_id);


-- Query 5 (Creates an Index on Available Status)
CREATE INDEX idx_copies_status
ON book_copies(availability_status);


-- Query 6 (Creates an Index on Member ID)
CREATE INDEX idx_loans_member
ON loans(member_id);


-- Query 7 (Creates an Index on Loan Status)
CREATE INDEX idx_loans_status
ON loans(status);


-- Query 8 (Creates an Index on Due Date)
CREATE INDEX idx_loans_due_date
ON loans(due_date);


-- Query 9 (Creates an Index on Reservation Member ID)
CREATE INDEX idx_reservations_member
ON reservations(member_id);