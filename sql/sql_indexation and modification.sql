USE BOOKSTORE;

CREATE INDEX review_idx ON ratings(review_id);


UPDATE edition SET price = 9.99 WHERE book_id = "TO369";


DELETE FROM ratings WHERE rating < 3;
