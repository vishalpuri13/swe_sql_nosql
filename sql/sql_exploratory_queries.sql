USE bookstore;

/*Count number of entries in each table*/
SELECT COUNT(*) AS AUTHOR_COUNT FROM AUTHORS;
SELECT COUNT(*) AS BOOK_COUNT FROM BOOKS;
SELECT COUNT(*) AS PUBLISHER_COUNT FROM PUBLISHER;
SELECT COUNT(*) AS RATINGS_COUNT FROM RATINGS;
SELECT COUNT(*) AS CHECKOUT_COUNT FROM CHECKOUTS;
SELECT COUNT(*) AS EDITION_COUNT FROM EDITION;
SELECT COUNT(*) AS INFORMATION_ENTRY_COUNT FROM INFORMATION;
SELECT COUNT(*) AS BOOKS_SOLD_Q1 FROM SALES_Q1;
SELECT COUNT(*) AS BOOKS_SOLD_Q2 FROM SALES_Q2;
SELECT COUNT(*) AS BOOKS_SOLD_Q3 FROM SALES_Q3;
SELECT COUNT(*) AS BOOKS_SOLD_Q4 FROM SALES_Q4;



/*Analysing Tables based on Subdivisions*/
/*IMAGE 1*/
SELECT IF(GROUPING(rating) = 1, 'TOTAL', rating) AS BOOK_RATINGS, COUNT(*) AS REVIEW_COUNT FROM ratings GROUP BY rating WITH ROLLUP;

/*IMAGE 2*/
SELECT IF(GROUPING(country_residence) = 1, 'TOTAL', country_residence) AS COUNTRY_OF_RESIDENCE, COUNT(*) AS AUTHOR_COUNT FROM authors GROUP BY country_residence WITH ROLLUP;


/*IMAGE 3*/
SELECT IF(GROUPING(genre) = 1, 'TOTAL', genre) AS BOOK_GENRE, COUNT(*) AS BOOK_COUNT FROM information GROUP BY genre WITH ROLLUP;


/*IMAGE 4*/
SELECT IF(GROUPING(checkout_month) = 1, 'TOTAL', checkout_month) AS MONTH_OF_YEAR, SUM(checkout_count) AS TOTAL_CHECKOUTS FROM checkouts GROUP BY checkout_month WITH ROLLUP;


/*IMAGE 5*/
SELECT  IF(GROUPING(book_id) = 1, 'Total', book_id) AS BOOK_ID, SUM(checkout_count) AS YEARLY_CHECKOUTS FROM checkouts GROUP BY book_id WITH ROLLUP;


/*IMAGE 6*/
SELECT IF(GROUPING(format) = 1, 'All_Formats', format) AS FORMAT, COUNT(*) AS BOOKS_COUNT FROM edition GROUP BY format WITH ROLLUP;


/*IMAGE 7*/
SELECT IF(GROUPING(book_id) = 1, 'All Books', book_id) AS BOOK_ID, 
        IF(GROUPING(rating) = 1, 'Total_Reviews', rating) AS RATING,
        COUNT(*) AS REVIEW_COUNT FROM RATINGS GROUP BY book_id,rating WITH ROLLUP;
        
SELECT COUNT(DISTINCT(reviewer_id)) AS REVIEWERS_COUNT FROM ratings;


/*IMAGE 8*/
SELECT MONTH(sale_date) AS MONTH_OF_YEAR, DAYOFWEEK(sale_date) AS DAY_OF_WEEK,COUNT(ISBN) AS BOOKS_SOLD
        FROM sales_q1 GROUP BY DAYOFWEEK(sale_date), MONTH(sale_date) ORDER BY MONTH(sale_date), DAYOFWEEK(sale_date);
        

SELECT MONTH(sale_date) AS MONTH_OF_YEAR, DAYOFWEEK(sale_date) AS DAY_OF_WEEK,COUNT(ISBN) AS BOOKS_SOLD
        FROM sales_q2 GROUP BY DAYOFWEEK(sale_date), MONTH(sale_date) ORDER BY MONTH(sale_date), DAYOFWEEK(sale_date);
        
        

SELECT MONTH(sale_date) AS MONTH_OF_YEAR, DAYOFWEEK(sale_date) AS DAY_OF_WEEK,COUNT(ISBN) AS BOOKS_SOLD
        FROM sales_q3 GROUP BY DAYOFWEEK(sale_date), MONTH(sale_date) ORDER BY MONTH(sale_date), DAYOFWEEK(sale_date);
        

SELECT MONTH(sale_date) AS MONTH_OF_YEAR, DAYOFWEEK(sale_date) AS DAY_OF_WEEK,COUNT(ISBN) AS BOOKS_SOLD
        FROM sales_q4 GROUP BY DAYOFWEEK(sale_date), MONTH(sale_date) ORDER BY MONTH(sale_date), DAYOFWEEK(sale_date);
       
       
/*Image 9*/      
SELECT IF(GROUPING(MONTH(sale_date)) = 1, 'Quarterly Sales', MONTH(sale_date)) AS MONTH_OF_YEAR, 
        IF(GROUPING(DAYOFWEEK(sale_date)) = 1, 'Monthly Sales', DAYOFWEEK(sale_date)) AS DAY_OF_WEEK,COUNT(ISBN) AS BOOKS_SOLD
        FROM sales_q4 GROUP BY DAYOFWEEK(sale_date), MONTH(sale_date) WITH ROLLUP;
        
        







