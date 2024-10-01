-- Insert data into Vendors table
INSERT INTO Vendors (VendorName, VendorDescription, VendorPhoneNumber, VendorCategory, VendorLocation)
VALUES 
    ('Panadería El Salvador', 'A traditional bakery known for its freshly baked bread and pastries.', '8765432110', 'Bakery', 'Guatemala City'),
    ('El Rincón del Café', 'A specialty coffee shop known for its Guatemalan coffee beans and friendly service.', '8765432111', 'Café', 'Antigua Guatemala'),
    ('Mercado Flores', 'A bustling market offering fresh flowers, plants, and gardening supplies.', '8765432112', 'Florist', 'Flores'),
    ('McDonalds', 'Craving something delicious? Visit McDonalds and enjoy our famous Big Mac!', '8765432113', 'Fast Food', 'Guatemala City'),
    ('Pura Vida Tienda', 'A gift shop offering Costa Rican handicrafts, souvenirs, and local artisan products.', '8765432114', 'Handicrafts', 'San José');

-- Insert data into Products table
INSERT INTO Products (ProductName, ProductPrice, ProductImage, VendorID)
VALUES 
    ('Sweet Bread', 2.99, 'sweet_bread.jpg', 1),
    ('French Bread', 1.50, 'french_bread.jpg', 1),
    ('Espresso', 2.75, 'espresso.jpg', 2),
    ('Sunflowers', 8.50, 'sunflowers.jpg', 3),
    ('French Fries', 2.50, 'french_fries.jpg', 4),
    ('Hand-painted Mug', 12.00, 'hand_painted_mug.jpg', 5),
    ('Café Latte', 3.50, 'cafe_latte.jpg', 2),
    ('Rose Bouquet', 10.00, 'rose_bouquet.jpg', 3),
    ('Big Mac', 5.99, 'big_mac.jpg', 4),
    ('Handmade Pottery', 15.00, 'handmade_pottery.jpg', 5);

-- Insert data into Ratings table
INSERT INTO Ratings (VendorID, CustomerName, RatingValue, RatingDate)
VALUES 
    (1, 'John Doe', 4.5, '2024-09-23'),
    (2, 'Jane Smith', 5.0, '2024-09-20'),
    (3, 'Carlos García', 4.0, '2024-09-22'),
    (4, 'Luis Hernandez', 3.5, '2024-09-19'),
    (5, 'Maria López', 5.0, '2024-09-18'),
    (1, 'Ana Pérez', 5.0, '2024-09-25'),
    (2, 'Pedro González', 4.5, '2024-09-21'),
    (3, 'Sara Díaz', 3.5, '2024-09-20'),
    (4, 'Daniel Ramírez', 4.0, '2024-09-15'),
    (5, 'Sofia Martínez', 4.8, '2024-09-17');

-- Insert data into Orders table
INSERT INTO Orders (VendorID, ProductID, Quantity, OrderDate)
VALUES 
    (1, 1, 2, '2024-09-24'),
    (2, 2, 1, '2024-09-23'),
    (3, 3, 3, '2024-09-22'),
    (4, 4, 1, '2024-09-21'),
    (5, 5, 2, '2024-09-20'),
    (1, 6, 4, '2024-09-25'),
    (2, 7, 2, '2024-09-21'),
    (3, 8, 5, '2024-09-20'),
    (4, 9, 2, '2024-09-19'),
    (5, 10, 1, '2024-09-18');
