         ----------CREATE TABLES--------
 
  CREATE TABLE BOOKS(
     Book_ID SERIAL PRIMARY KEY,
     Title VARCHAR(100),
     Author VARCHAR(100),
     Genre VARCHAR(50),
     Published_Year INT,
     Price NUMERIC(10,2),
     Stock INT
);

 SELECT * FROM BOOKS;



 CREATE TABLE Customers(
    Customer_id SERIAL PRIMARY KEY,
	NAME VARCHAR(100),
	Email VARCHAR(100),
	Phone VARCHAR(15),
	City VARCHAR(50),
	Country VARCHAR (150)
	
);

  SELECT * FROM CUSTOMERS;




 CREATE TABLE ORDERS(
    Order_id SERIAL PRIMARY KEY,
	Customer_id INT REFERENCES Customers(customer_id),
	Book_id INT REFERENCES Books(Book_id),
	Order_DATE DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2)

 );

   SELECT * FROM ORDERS;


--IMPORT DATA INTO BOOKS TABLE

copy BOOKS(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
FROM 'C:/Users/samsung/Downloads/Books.csv'
DELIMITER ',' CSV HEADER;


 SELECT * FROM BOOKS;

---IMPORT DATA INTO CUSTOMERS TABLE

copy Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'C:/Users/samsung/Downloads/Customers.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM CUSTOMERS;

-- IMPORT DATA INTO ORDERS TABLE
COPY Orders(Order_id, Customer_id, Book_ID, Order_Date, Quantity, Total_Amount)
 FROM 'C:\Users\samsung\Documents\EMPLOYEE DATA\Orders.csv'
 DELIMITER ',' CSV HEADER;

SELECT * FROM ORDERS;

--1) RETRIEVE ALL BOOKS IN THE "FICTION" GENRE:

  SELECT* FROM BOOKS
  WHERE GENRE='Fiction';

--2) FIND BOOKS PUBLISHED AFTER THE YEAR 1950:
   SELECT * FROM BOOKS
   WHERE PUBLISHED_YEAR>1950;

--3) LIST ALL THE CUSTOMERS FROM THE CANADA:
    SELECT * FROM CUSTOMERS
	WHERE Country='Canada';

-- 4) SHOW ORDER PLACED IN NOVEMBER 2023:
    SELECT * FROM ORDERS
	WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

--5) RETRIEVE THE TOTAL STOCK OF BOOKS AVAILABALE:

   SELECT SUM(stock) AS Total_Stock
   from books;

--6) FIND THE DETAILS OF THE MOST EXPENSIVE BOOK:
    SELECT * FROM BOOKS 
	ORDER BY Price  DESC LIMIT 1;
     

--7) SHOW ALL CUSTOMERS WHO ORDERED MORE THAN 1 QUANTITY OF A BOOK: 
	SELECT * FROM orders
	WHERE quantity>1;
	
--8) RETRIEVE ALL ORDERS WHERE THE TOTAL AMOUNT EXCEEDS $20:
    SELECT * FROM ORDERS
	WHERE TOTAL_AMOUNT>20;

	
--9) LIST ALL GENRES AVAILABLE IN THE BOOKS TABLE:

  SELECT DISTINCT genre FROM BOOKS;

--10) FIND THE BOOKS WITH THE LOWEST STOCK:

   SELECT * FROM BOOKS
   ORDER BY STOCK ASC LIMIT 1;

--11) CALCULATE THE TOTAL REVENUE GENERATED FROM ALL ORDERS:

    SELECT SUM(total_amount) AS REVENUE
	FROM ORDERS;
	
   
------------ADVANCED QUESTIONS--------

--1) RETRIEVE THE TOTAL NUMBER OF BOOKS SOLD FOR EACH GENRE

   SELECT b.GENRE, SUM(o.QUANTITY) AS TOTAL_BOOKS_SOLD
   FROM ORDERS o
   JOIN Books b ON O.Book_id=b.Book_id
   GROUP BY b.Genre;

--2) FIND THE AVERAGE PRICE OF BOOKS IN THE "FANTASY" GENRE:
   SELECT AVG(Price) AS AVERAGE_PRICE
   FROM BOOKS
   WHERE Genre='Fantasy';

--3) LIST THE CUSTOMERS WHO HAVE PLACED AT LEAST 2 ORDERS:
     
   SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
   FROM orders o
   JOIN customers c ON o.customer_id=c.customer_id
   GROUP BY o.customer_id, c.name
   HAVING COUNT(Order_id) >=2;

--4) FIND THE MOST FREQUENTLY ORDERED BOOK NAME:
     
	SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
	FROM orders o
	JOIN books b ON o.book_iD=b.book_id
	GROUP BY o.book_id, b.title
	ORDER BY ORDER_COUNT DESC LIMIT 1;
   
--5) SHOW THE TOP 3 MOST EXPENSIVE BOOKS OF 'FANATSY' GENRE.
     
    SELECT * FROM BOOKS
	WHERE GENRE='Fantasy'
	ORDER BY PRICE DESC LIMIT 3;

--6) RETRIEVE THE TOTAL QUANTITY OF BOOKS SOLD BY EACH AUTHOR.

    SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
	FROM orders o
	JOIN books b ON o.book_id=b.book_id
	GROUP BY b.author;

--7) LIST THE CITIES WHERE CUSTOMERS WHO SPENT OVER $30 ARE LOCATED
 
    SELECT DISTINCT c.city, total_amount
	FROM orders o
	JOIN customers c ON o.customer_id=c.customer_id
	WHERE o.total_amount>30;


--8) FIND THE CUSTOMER WHO SPENT THE MOST ON ORDERS.

    SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
	FROM orders o
	JOIN customers c ON o.customer_id=c.customer_id
	GROUP BY c.customer_id, c.name
	ORDER BY Total_spent DESC LIMIT 1;


--9) Calculate the stock remaining after fulfilling all orders.

   SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,
   b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_quantity
   FROM books b
   LEFT JOIN orders o ON b.book_id=o.book_id
   GROUP BY b.book_id
   ORDER BY b.book_id; 



   ----------THANKYOU FOR READING-------





