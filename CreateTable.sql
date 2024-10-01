-- Create Vendors table
CREATE TABLE IF NOT EXISTS Vendors (
    VendorID INTEGER PRIMARY KEY AUTOINCREMENT,
    VendorName TEXT NOT NULL,
    VendorDescription TEXT,
    VendorPhoneNumber TEXT,
    VendorCategory TEXT,
    VendorLocation TEXT
);

-- Create Products table with foreign key reference to Vendors
CREATE TABLE IF NOT EXISTS Products (
    ProductID INTEGER PRIMARY KEY AUTOINCREMENT,
    ProductName TEXT NOT NULL,
    ProductPrice REAL NOT NULL,
    ProductImage TEXT,
    VendorID INTEGER,
    FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID)
);

-- Create Ratings table with foreign key reference to Vendors
CREATE TABLE IF NOT EXISTS Ratings (
    RatingID INTEGER PRIMARY KEY AUTOINCREMENT,
    VendorID INTEGER,
    CustomerName TEXT NOT NULL,
    RatingValue REAL NOT NULL,
    RatingDate DATE NOT NULL,
    FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID)
);

-- Create Orders table with foreign key references to Vendors and Products
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INTEGER PRIMARY KEY AUTOINCREMENT,
    VendorID INTEGER,
    ProductID INTEGER,
    Quantity INTEGER NOT NULL,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
