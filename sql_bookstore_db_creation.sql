CREATE DATABASE IF NOT EXISTS bookstore;

USE bookstore;


CREATE TABLE IF NOT EXISTS authors (
    author_id VARCHAR(5) CHARACTER SET utf8,
    first_name VARCHAR(15) CHARACTER SET utf8,
    last_name VARCHAR(15) CHARACTER SET utf8,
    birthday DATE,
    country_residence VARCHAR(14) CHARACTER SET utf8,
    writing_hours_per_day NUMERIC(4, 2),
    CONSTRAINT pk_authors PRIMARY KEY (author_id)
);

CREATE TABLE IF NOT EXISTS publisher (
    publisher_id VARCHAR(3) CHARACTER SET utf8,
    publisher_name VARCHAR(22) CHARACTER SET utf8,
    city VARCHAR(13) CHARACTER SET utf8,
    province VARCHAR(10) CHARACTER SET utf8,
    country VARCHAR(11) CHARACTER SET utf8,
    year_established INTEGER,
    marketing_spend INTEGER,
    CONSTRAINT pk_publisher PRIMARY KEY (publisher_id)
);



CREATE TABLE IF NOT EXISTS books (
     book_id VARCHAR(5) CHARACTER SET utf8,
     book_title VARCHAR(55) CHARACTER SET utf8,
     author_id VARCHAR(5) CHARACTER SET utf8,
     CONSTRAINT pk_books PRIMARY KEY (book_id),
     CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors (author_id)
);

CREATE TABLE IF NOT EXISTS edition (
     ISBN VARCHAR(17) CHARACTER SET utf8,
    book_id VARCHAR(5) CHARACTER SET utf8,
    format VARCHAR(21) CHARACTER SET utf8,
    publisher_id VARCHAR(3) CHARACTER SET utf8,
    publication_date DATE,
    pages INT,
    print_run_size_inthousands INT,
    price NUMERIC(4, 2),
    CONSTRAINT pk_edition PRIMARY KEY (ISBN),
    CONSTRAINT fk_publisher FOREIGN KEY (publisher_id) REFERENCES publisher (publisher_id)
);

CREATE TABLE IF NOT EXISTS Ratings (
        book_id VARCHAR(5) CHARACTER SET utf8,
        rating INTEGER,
        reviewer_id INTEGER,
        review_id  INTEGER,
        CONSTRAINT pk_ratings PRIMARY KEY (review_id),
        CONSTRAINT fk_books FOREIGN KEY (book_id) REFERENCES books (book_id)
);

CREATE TABLE IF NOT EXISTS information (
    book_id1 VARCHAR(2) CHARACTER SET utf8,
    book_id2 INTEGER,
    genre VARCHAR(13) CHARACTER SET utf8,
    series_id VARCHAR(6) CHARACTER SET utf8,
    volume_number INT,
    staff_comment VARCHAR(908) CHARACTER SET utf8,
    CONSTRAINT pk_information PRIMARY KEY (book_id1,book_id2)
);

CREATE TABLE IF NOT EXISTS checkouts (
    book_id VARCHAR(5) CHARACTER SET utf8,
    checkout_month INT,
    checkout_count INT
);

CREATE TABLE IF NOT EXISTS sales_q1 (
        sale_date DATE,
        ISBN VARCHAR(17) CHARACTER SET utf8,
        order_id VARCHAR(15)
);


CREATE TABLE IF NOT EXISTS sales_q2 (
        sale_date DATE,
        ISBN VARCHAR(17) CHARACTER SET utf8,
        order_id VARCHAR(15)
);


CREATE TABLE IF NOT EXISTS sales_q3 (
        sale_date DATE,
        ISBN VARCHAR(17) CHARACTER SET utf8,
        order_id VARCHAR(15)
);


CREATE TABLE IF NOT EXISTS sales_q4 (
        sale_date DATE,
        ISBN VARCHAR(17) CHARACTER SET utf8,
        order_id VARCHAR(15)
);
