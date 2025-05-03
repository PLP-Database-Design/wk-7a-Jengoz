/* Question 1 Achieving 1NF (First Normal Form) */
-- Step 1: Create the original non-1NF table --
CREATE TABLE ProductDetail(
OrderID INT,
CustomerName VARCHAR (100),
products VARCHAR (255)
);

-- Step 2: Insert sample data into ProductDetail --
INSERT INTO ProductDetail(OrderID,CustomerName,products)
VALUES
(101,'John Doe','Laptop,Mouse'),
(102,'Jane Smith','Tablet,keyboard,Mouse'),
(103,'Emly Clark','Phone');

-- Step 3: Create normalized Orders table --
CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerName VARCHAR(100)
);

CREATE TABLE OrderProducts (
OrderID INT,
Product VARCHAR(100),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 5: Insert unique orders --
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM ProductDetail;

-- Step 6: Simulate 1NF split manually --
INSERT INTO OrderProducts (OrderID, Product) VALUES
(101, 'Laptop'),
(101, 'Mouse'),
(102, 'Tablet'),
(102, 'Keyboard'),
(102, 'Mouse'),
(103, 'Phone');


/* Question 2 Achieving 2NF (Second Normal Form) */
-- Step 1: Create the original 1NF table --
CREATE TABLE OrderDetailsRaw (
OrderID INT,
CustomerName VARCHAR(100),
Product VARCHAR(100),
Quantity INT
);

-- Step 2: Insert sample data into OrderDetailsRaw --
INSERT INTO OrderDetailsRaw (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Step 3: Create the normalized tables --
CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerName VARCHAR(100)
);

CREATE TABLE OrderDetails (
OrderID INT,
Product VARCHAR(100),
Quantity INT,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- step 4: Populate Orders & OrderDetails tables --
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetailsRaw;

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName FROM OrderDetailsRaw;

