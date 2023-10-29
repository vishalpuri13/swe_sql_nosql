USE BOOKSTORE;

/*Image 10  Books with Author Details*/
SELECT books.book_title AS BOOK_NAME, authors.first_name AS AUTH_FIRSTNAME,authors.last_name AS AUTH_LASTNAME
 FROM books
 JOIN authors ON books.author_id = authors.author_id;


/*Image 11 Quarterly Sales*/
SET @totSale :=0;
SELECT T1.QUARTER_OF_YEAR,
         T1.BOOKS_SOLD, @totSale := @totSale + T1.BOOKS_SOLD AS "CUMULATIVE_BOOKS_SOLD" 
         FROM (
                SELECT IF(GROUPING(MONTH(sale_date)) = 1, 'Q1', MONTH(sale_date)) AS QUARTER_OF_YEAR, 
                        COUNT(ISBN) AS BOOKS_SOLD
                        FROM sales_q1 GROUP BY MONTH(sale_date) WITH ROLLUP
                UNION
                SELECT IF(GROUPING(MONTH(sale_date)) = 1, 'Q2', MONTH(sale_date)) AS QUARTER_OF_YEAR, 
                        COUNT(ISBN) AS BOOKS_SOLD
                        FROM sales_q2 GROUP BY MONTH(sale_date) WITH ROLLUP
                UNION
                SELECT IF(GROUPING(MONTH(sale_date)) = 1, 'Q3', MONTH(sale_date)) AS QUARTER_OF_YEAR, 
                        COUNT(ISBN) AS BOOKS_SOLD
                        FROM sales_q3 GROUP BY MONTH(sale_date) WITH ROLLUP
                UNION
                SELECT IF(GROUPING(MONTH(sale_date)) = 1, 'Q4', MONTH(sale_date)) AS QUARTER_OF_YEAR, 
                        COUNT(ISBN) AS BOOKS_SOLD
                        FROM sales_q4 GROUP BY MONTH(sale_date) WITH ROLLUP)
         AS T1 WHERE T1.QUARTER_OF_YEAR LIKE 'Q%';
         
         
/*Image 12*/      
SET @totSale :=0;
SET @totBooks :=0;
SELECT T1.MONTH_OF_YEAR,
         T1.BOOKS_SOLD, @totBooks := @totBooks + T1.BOOKS_SOLD AS "CUMULATIVE_BOOKS_SOLD", T1.SALE_VALUE, @totSale := @totSale + T1.SALE_VALUE AS "CUMULATIVE_SALE_VALUE" 
         FROM (
                 SELECT MONTH(sales_q1.sale_date) AS MONTH_OF_YEAR,COUNT(sales_q1.ISBN) AS BOOKS_SOLD, SUM(edition.PRICE) AS SALE_VALUE
                         FROM edition
                         JOIN sales_q1 ON edition.ISBN = sales_q1.ISBN
                         GROUP BY MONTH(sales_q1.sale_date)
                UNION
                SELECT MONTH(sales_q2.sale_date) AS MONTH_OF_YEAR,COUNT(sales_q2.ISBN) AS BOOKS_SOLD, SUM(edition.PRICE) AS SALE_VALUE
                         FROM edition
                         JOIN sales_q2 ON edition.ISBN = sales_q2.ISBN
                         GROUP BY MONTH(sales_q2.sale_date)
                UNION
                SELECT MONTH(sales_q3.sale_date) AS MONTH_OF_YEAR,COUNT(sales_q3.ISBN) AS BOOKS_SOLD, SUM(edition.PRICE) AS SALE_VALUE
                         FROM edition
                         JOIN sales_q3 ON edition.ISBN = sales_q3.ISBN
                         GROUP BY MONTH(sales_q3.sale_date)
                UNION
                SELECT MONTH(sales_q4.sale_date) AS MONTH_OF_YEAR,COUNT(sales_q4.ISBN) AS BOOKS_SOLD, SUM(edition.PRICE) AS SALE_VALUE
                         FROM edition
                         JOIN sales_q4 ON edition.ISBN = sales_q4.ISBN
                         GROUP BY MONTH(sales_q4.sale_date))
        AS T1 ;

    
    
 /*Image 13 Bestsellers Books & Authors */
 SELECT T1.BOOK_ID, T1.BOOK_NAME,T1.AUTHOR_NAME, sum(T1.BOOKS_SOLD) AS BOOKS_SOLD,SUM(T1.SALE_VALUE) AS SALE_VALUE 
            FROM(
 
                 SELECT books.book_id AS BOOK_ID, books.book_title AS BOOK_Name, CONCAT(authors.first_name,' ',authors.last_name) AS AUTHOR_NAME, 
                 COUNT(sales_q1.ISBN) AS BOOKS_SOLD, SUM(edition.PRICE) AS SALE_VALUE
                 FROM edition
                 JOIN sales_q1 ON edition.ISBN = sales_q1.ISBN
                 JOIN books ON edition.book_id = books.book_id
                 JOIN authors ON books.author_id = authors.author_id
                 GROUP BY edition.book_id
                 
                 UNION
                 
                 SELECT books.book_id AS BOOK_ID, books.book_title AS BOOK_Name, CONCAT(authors.first_name,' ',authors.last_name)AS AUTHOR_NAME, 
                 COUNT(sales_q2.ISBN) AS BOOKS_SOLD, SUM(edition.PRICE) AS SALE_VALUE
                 FROM edition
                 JOIN sales_q2 ON edition.ISBN = sales_q2.ISBN
                 JOIN books ON edition.book_id = books.book_id
                 JOIN authors ON books.author_id = authors.author_id
                 GROUP BY edition.book_id
                 
                 UNION
                 
                 SELECT books.book_id AS BOOK_ID, books.book_title AS BOOK_Name, CONCAT(authors.first_name,' ',authors.last_name)AS AUTHOR_NAME, 
                 COUNT(sales_q3.ISBN) AS BOOKS_SOLD, SUM(edition.PRICE) AS SALE_VALUE
                 FROM edition
                 JOIN sales_q3 ON edition.ISBN = sales_q3.ISBN
                 JOIN books ON edition.book_id = books.book_id
                 JOIN authors ON books.author_id = authors.author_id
                 GROUP BY edition.book_id
                 
                 UNION
                 
                 SELECT books.book_id AS BOOK_ID, books.book_title AS BOOK_Name, CONCAT(authors.first_name,' ',authors.last_name)AS AUTHOR_NAME, 
                 COUNT(sales_q4.ISBN) AS BOOKS_SOLD, SUM(edition.PRICE) AS SALE_VALUE
                 FROM edition
                 JOIN sales_q4 ON edition.ISBN = sales_q4.ISBN
                 JOIN books ON edition.book_id = books.book_id
                 JOIN authors ON books.author_id = authors.author_id
                 GROUP BY edition.book_id
                 ) 
            AS T1 GROUP BY T1.BOOK_ID ORDER BY T1.SALE_VALUE DESC LIMIT 15;
            
            
/*Image 14 Highest 5 Ratings */
SELECT T1.BOOK_ID,T1.BOOK_NAME, T1.AUTHOR_NAME,T1.RATING, T1.REVIEW_COUNT
        FROM (
                SELECT books.book_id AS BOOK_ID,books.book_title AS BOOK_NAME, CONCAT(authors.first_name,' ',authors.last_name)AS AUTHOR_NAME,
                IF(GROUPING(ratings.rating)=1, 'Given Book-Total Ratings', ratings.rating) AS RATING,
                COUNT(ratings.review_id) AS REVIEW_COUNT
                FROM ratings
                JOIN books ON ratings.book_id = books.book_id
                JOIN authors ON authors.author_id = books.author_id
                GROUP BY books.book_id, ratings.rating WITH ROLLUP 
                HAVING books.book_id  IS NOT NULL
                ORDER BY book_id, REVIEW_COUNT DESC
             ) 
        AS T1
        WHERE T1.RATING = 5
        ORDER BY T1.REVIEW_COUNT DESC
        LIMIT 10;
        


