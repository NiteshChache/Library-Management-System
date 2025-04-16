create database Library;
use Library;

create table Books(
    BookID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255),
    PublishedYear INT);
    
CREATE TABLE Members(
    MemberID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE);

CREATE TABLE Borrowing(
    BorrowID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    BorrowDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID));
    
    INSERT INTO Books (BookID, Title, Author, PublishedYear) VALUES
(1, 'Vyakti Ani Valli', 'PU LA DESHPANDE', 2016),
(2, 'Yayati', 'V S Khandekar', 1959),
(3, 'Shyamchi Aai', 'Sane Guruji', 1936),
(4, 'Shriman Yogi', 'Ranjeet Desai', 1968),
(5, 'Kosala', 'Bhalchandra Nemade', 1963);

INSERT INTO Members (MemberID, Name, Email) VALUES
(1, 'Sumit', 'sumit@gmail.com'),
(2, 'Yash', 'yash@gmail.com'),
(3, 'Manish', 'manish@gmail.com'),
(4, 'Dhiraj', 'dhiraj@gmail.com'),
(5, 'Haresh', 'haresh@gmail.com');

INSERT INTO Borrowing (BorrowID, BookID, MemberID, BorrowDate, ReturnDate) VALUES
(1, 1, 1, '2025-01-01', '2025-01-05'),
(2, 2, 2, '2024-12-05', '2025-12-10'),
(3, 3, 3, '2025-01-03', '2025-01-07'),
(4, 4, 4, '2025-01-02', '2025-01-18'),
(5, 5, 1, '2025-02-05', '2025-02-15');

# 1.Retrieve all books and their borrowers (LEFT JOIN)
SELECT B.BookID, B.Title, M.Name AS Borrower
FROM Books B
LEFT JOIN Borrowing Br ON B.BookID = Br.BookID
LEFT JOIN Members M ON Br.MemberID = M.MemberID;

# 2.Find members who haven’t borrowed any books
SELECT M.MemberID, M.Name
FROM Members M
LEFT JOIN Borrowing Br ON M.MemberID = Br.MemberID
WHERE Br.BorrowID IS NULL;

# 3.Display books that have been borrowed (RIGHT JOIN)
SELECT B.BookID, B.Title, M.Name AS Borrower
FROM Books B
RIGHT JOIN Borrowing Br ON B.BookID = Br.BookID
RIGHT JOIN Members M ON Br.MemberID = M.MemberID;

# 4.Count the number of books borrowed by each member
SELECT M.MemberID, M.Name, COUNT(Br.BorrowID) AS BooksBorrowed
FROM Members M
LEFT JOIN Borrowing Br ON M.MemberID = Br.MemberID
GROUP BY M.MemberID, M.Name;

# 5.List books that are not currently borrowed (FULL JOIN)
SELECT B.BookID, B.Title
FROM Books B
LEFT JOIN Borrowing Br ON B.BookID = Br.BookID
WHERE Br.BorrowID IS NULL;

# 6.Find members who borrowed books in February 2025
SELECT M.MemberID, M.Name
FROM Members M
JOIN Borrowing Br ON M.MemberID = Br.MemberID
WHERE MONTH(Br.BorrowDate) = 2 AND YEAR(Br.BorrowDate) = 2025;

# 7.Retrieve details of books borrowed the most times
SELECT B.BookID, B.Title, COUNT(Br.BorrowID) AS BorrowCount
FROM Books B
JOIN Borrowing Br ON B.BookID = Br.BookID
GROUP BY B.BookID, B.Title
ORDER BY BorrowCount DESC
LIMIT 2;


drop database library;

select * from Members;




