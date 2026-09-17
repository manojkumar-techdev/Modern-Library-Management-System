# Modern-Library-Management-System
Advanced Databases M605 - MySQL Project



📘 Introduction 

The project demands a design and implementation of a detailed and automated database system that can apply either SQL and/or NoSQL technologies. The main purpose of the given project is to create a modern system including hybrid mode effectively which can handle structured, semi-structured and unstructured data to fulfill the real-world design aims. 

A large number of domains can be freely opted and designed for a business or system of personal choice which can be beneficial for current world problems. The project has to follow the modern database management system including creating database, data insertion and implementation of queries and commands for performance-based optimal results.



Entity Relationship Diagram

<img width="1850" height="1300" alt="ER" src="https://github.com/user-attachments/assets/f5ef15e4-c9f9-453e-86af-9def0f7a19c5" />


Modern-Library-Management-System/
│
├── README.md
│
├── sql/
│   │
│   ├── 01_setup/
│   │   └── 00_created_database.sql
│   │
│   ├── 02_schema/
│   │   ├── 01_created_tables.sql
│   │   ├── 02_created_publishers.sql
│   │   ├── 03_create_categories.sql
│   │   ├── 04_create_books.sql
│   │   ├── 05_create_members.sql
│   │   ├── 06_create_librarians.sql
│   │   ├── 07_create_book_copies.sql
│   │   ├── 08_create_loans.sql
│   │   ├── 09_create_reservations.sql
│   │   
│   │   
│   │   
│   │  
│   │
│   ├── 02_data/
│   │   ├── 01_insert_authors.sql
│   │   ├── 02_insert_publishers.sql
│   │   ├── 03_insert_categories.sql
│   │   ├── 04_insert_books.sql
│   │   ├── 05_insert_members.sql
│   │   ├── 06_insert_librarians.sql
│   │   ├── 07_insert_book_copies.sql
│   │   ├── 08_insert_loans.sql
│   │   ├── 09_insert_reservations.sql
│   │   ├── 10_insert_fines.sql
│   │   ├── 11_insert_payments.sql
│   │   ├── 12_insert_reviews.sql
│   │   └── 13_insert_library_events.sql
│   │
│   ├── 03_views/
│   │   └── library_dashboard_view.sql
│   │
│   ├── 04_procedures/
│   │   └── search_books.sql
│   │
│   ├── 05_functions/
│   │   ├── calculate_fine.sql
│   │   ├── get_member_total_payments.sql
│   │   └── get_book_review_count.sql
│   │
│   ├── 06_triggers/
│   │   ├── before_loan_insert.sql
│   │   ├── after_loan_insert.sql
│   │   └── after_payment_insert.sql
│   │
│   ├── 07_indexes/
│   │   └── create_indexes.sql
│   │
│   ├── 08_transactions/
│   │   └── record_payment.sql
│   │
│   ├── 09_reports/
│   │   ├── library_summary.sql
│   │   ├── available_books.sql
│   │   ├── unpaid_fines.sql
│   │   └── upcoming_events.sql
│   │
│   └── 10_tests/
│       ├── test_books.sql
│       ├── test_loans.sql
│       ├── test_payments.sql
│       └── test_constraints.sql
│
└── docs/
    ├── database_design.md
    ├── entity_relationship_diagram.png
    └── project_report.pdf


