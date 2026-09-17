-- Query 1 (Create table for "AUTHORS")

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(150) NOT NULL,
    nationality VARCHAR(100),
    birth_date DATE
);


-- Query 2 (Create table for "PUBLISHERS")
CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    publisher_name VARCHAR(150) NOT NULL UNIQUE,
    country VARCHAR(100),
    email VARCHAR(150)
);


-- Query 3 (Create table for "CATEGORIES")
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);


-- Query 4 (Create table for "BOOKS")
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    author_id INT NOT NULL,
    publisher_id INT,
    category_id INT NOT NULL,
    publication_year YEAR,
    price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,

    CONSTRAINT fk_books_author
        FOREIGN KEY (author_id)
        REFERENCES authors(author_id),

    CONSTRAINT fk_books_publisher
        FOREIGN KEY (publisher_id)
        REFERENCES publishers(publisher_id),

    CONSTRAINT fk_books_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id),

    CONSTRAINT chk_book_price
        CHECK (price >= 0),

    CONSTRAINT chk_total_copies
        CHECK (total_copies > 0),

    CONSTRAINT chk_available_copies
        CHECK (
            available_copies >= 0
            AND available_copies <= total_copies
        )
);



-- Query 5 (Create table for "MEMBERS")
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(30),
    address VARCHAR(255),
    membership_date DATE NOT NULL,
    status ENUM(
        'Active',
        'Inactive',
        'Suspended'
    ) DEFAULT 'Active'
);




-- Query 6 (Create table for "LIBRARIANS")
CREATE TABLE librarians (
    librarian_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(30),
    hire_date DATE NOT NULL,
    position VARCHAR(100),
    status ENUM(
        'Active',
        'Inactive'
    ) DEFAULT 'Active'
);


-- Query 7 (Create table for "BOOK COPIES")
CREATE TABLE book_copies (
    copy_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    barcode VARCHAR(50) NOT NULL UNIQUE,
    shelf_location VARCHAR(100),
    condition_status ENUM(
        'Excellent',
        'Good',
        'Fair',
        'Damaged',
        'Lost'
    ) DEFAULT 'Good',

    availability_status ENUM(
        'Available',
        'Borrowed',
        'Reserved',
        'Lost',
        'Maintenance'
    ) DEFAULT 'Available',

    CONSTRAINT fk_copies_book
        FOREIGN KEY (book_id)
        REFERENCES books(book_id)
);



-- Query 8 (Create table for "LOANS")
CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    copy_id INT NOT NULL,
    member_id INT NOT NULL,
    librarian_id INT NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,

    status ENUM(
        'Issued',
        'Returned',
        'Overdue'
    ) DEFAULT 'Issued',

    CONSTRAINT fk_loans_copy
        FOREIGN KEY (copy_id)
        REFERENCES book_copies(copy_id),

    CONSTRAINT fk_loans_member
        FOREIGN KEY (member_id)
        REFERENCES members(member_id),

    CONSTRAINT fk_loans_librarian
        FOREIGN KEY (librarian_id)
        REFERENCES librarians(librarian_id),

    CONSTRAINT chk_loan_dates
        CHECK (due_date >= issue_date),

    CONSTRAINT chk_return_date
        CHECK (
            return_date IS NULL
            OR return_date >= issue_date
        )
);




-- Query 9 (Create table for "RESERVATIONS")
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    reservation_date DATE NOT NULL,
    expiry_date DATE,

    status ENUM(
        'Pending',
        'Fulfilled',
        'Cancelled',
        'Expired'
    ) DEFAULT 'Pending',

    CONSTRAINT fk_reservation_book
        FOREIGN KEY (book_id)
        REFERENCES books(book_id),

    CONSTRAINT fk_reservation_member
        FOREIGN KEY (member_id)
        REFERENCES members(member_id),

    CONSTRAINT chk_reservation_dates
        CHECK (
            expiry_date IS NULL
            OR expiry_date >= reservation_date
        )
);




-- Query 10 (Create table for "FINES")
CREATE TABLE fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    member_id INT NOT NULL,
    fine_amount DECIMAL(10,2) NOT NULL,
    fine_reason VARCHAR(255),
    fine_date DATE NOT NULL,

    payment_status ENUM(
        'Unpaid',
        'Partially Paid',
        'Paid'
    ) DEFAULT 'Unpaid',

    CONSTRAINT fk_fines_loan
        FOREIGN KEY (loan_id)
        REFERENCES loans(loan_id),

    CONSTRAINT fk_fines_member
        FOREIGN KEY (member_id)
        REFERENCES members(member_id),

    CONSTRAINT chk_fine_amount
        CHECK (fine_amount >= 0)
);



-- Query 11 (Create table for "PAYMENTS")
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    fine_id INT NOT NULL,
    member_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    payment_method ENUM(
        'Cash',
        'Card',
        'Online',
        'Bank Transfer'
    ) NOT NULL,

    transaction_reference VARCHAR(100),

    CONSTRAINT fk_payments_fine
        FOREIGN KEY (fine_id)
        REFERENCES fines(fine_id),

    CONSTRAINT fk_payments_member
        FOREIGN KEY (member_id)
        REFERENCES members(member_id),

    CONSTRAINT chk_payment_amount
        CHECK (amount > 0)
);



-- Query 12 (Create table for "REVIEWS")
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    rating INT NOT NULL,
    review_text TEXT,
    review_date DATE NOT NULL DEFAULT (CURRENT_DATE),

    CONSTRAINT fk_reviews_book
        FOREIGN KEY (book_id)
        REFERENCES books(book_id),

    CONSTRAINT fk_reviews_member
        FOREIGN KEY (member_id)
        REFERENCES members(member_id),

    CONSTRAINT chk_rating
        CHECK (rating BETWEEN 1 AND 5),

    CONSTRAINT uq_book_member_review
        UNIQUE (book_id, member_id)
);



-- Query 13 (Create table for "LIBRARY EVENTS")
CREATE TABLE library_events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(200) NOT NULL,
    description TEXT,
    event_date DATE NOT NULL,
    start_time TIME,
    end_time TIME,
    capacity INT NOT NULL DEFAULT 20,
    organizer VARCHAR(150),

    CONSTRAINT chk_event_capacity
        CHECK (capacity > 0),

    CONSTRAINT chk_event_time
        CHECK (
            start_time IS NULL
            OR end_time IS NULL
            OR end_time > start_time
        )
);