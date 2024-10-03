
# Natural Language SQL Project

### Purpose of the Database

My database models vendor and product data for a marketplace application, which includes vendors, their products, customer ratings, and orders.

### Schema

![Schema](schema.png)

---

## Query I thought it did well on

**Question**: Which vendors have the highest rating?

**GPT SQL Response**:
```sql
SELECT Vendors.VendorID, Vendors.VendorName, MAX(Ratings.RatingValue) as MaxRating
FROM Vendors 
INNER JOIN Ratings ON Vendors.VendorID = Ratings.VendorID
GROUP BY Vendors.VendorID, Vendors.VendorName
ORDER BY MaxRating DESC;
```

**Friendly Response**: The vendors with the highest rating are Panadería El Salvador, El Rincón del Café, and Pura Vida Tienda, all with a perfect score of 5.0. Following them are Mercado Flores and McDonald's, both with a rating of 4.0.

## Question that it tripped up on

**Question**: Which vendors sell products priced over $20?

**GPT SQL Response**:
```sql
SELECT Vendors.VendorName FROM Vendors JOIN Products ON Vendors.VendorID = Products.VendorID WHERE Products.ProductPrice > 20;
```

SQL Result: []

**Friendly Response**: Unfortunately, there are currently no vendors selling products priced over $20.

While the SQL was correct, the response was empty because no data matched the query. GPT correctly identified the issue but gave a generic response.

---

## Multi-shot Query Example

**Question**: What products are sold in Antigua Guatemala?

**GPT SQL Response**:
```sql
SELECT ProductName FROM Products WHERE VendorID IN (SELECT VendorID FROM Vendors WHERE VendorLocation = 'Antigua Guatemala');
```

SQL Result: [('Espresso',), ('Café Latte',)]

**Friendly Response**: In Antigua Guatemala, you can find products such as Espresso and Café Latte.

---

## 6 Additional Examples with Prompt Strategies

### 1. Strategy: Zero-shot

**Question**: Which vendors are located in Guatemala City?

**SQL Response**:
```sql
SELECT VendorName FROM Vendors WHERE VendorLocation = 'Guatemala City';
```

SQL Result: [('Panadería El Salvador',), ('McDonalds',)]

**Friendly Response**: The vendors located in Guatemala City are Panadería El Salvador and McDonalds.

---

### 2. Strategy: Single-domain multi-shot

**Question**: Which customers gave a 5-star rating?

**SQL Response**:
```sql
SELECT CustomerName FROM Ratings WHERE RatingValue = 5;
```

SQL Result: [('Jane Smith',), ('Maria López',), ('Ana Pérez',)]

**Friendly Response**: The customers who gave a 5-star rating are Jane Smith, Maria López, and Ana Pérez.

---

### 3. Strategy: Zero-shot

**Question**: What products are sold by vendors in Antigua Guatemala?

**SQL Response**:
```sql
SELECT Products.ProductName FROM Products
INNER JOIN Vendors ON Products.VendorID = Vendors.VendorID
WHERE Vendors.VendorLocation = 'Antigua Guatemala';
```

SQL Result: [('Espresso',), ('Café Latte',)]

**Friendly Response**: Products sold in Antigua Guatemala include Espresso and Café Latte.

---

### 4. Strategy: Double-shot

**Question**: Which vendors have products priced above $20?

**SQL Response**:
```sql
SELECT Vendors.VendorName FROM Vendors 
JOIN Products ON Vendors.VendorID = Products.VendorID 
WHERE Products.ProductPrice > 20;
```

SQL Result: []

**Friendly Response**: Currently, no vendors have products priced above $20.

---

### 5. Strategy: Single-shot

**Question**: What is the most expensive product sold by vendors?

**SQL Response**:
```sql
SELECT ProductName, MAX(ProductPrice) FROM Products;
```

SQL Result: [('Deluxe Coffee', 25.0)]

**Friendly Response**: The most expensive product sold by vendors is Deluxe Coffee, priced at $25.00.

---

### 6. Strategy: Multi-shot

**Question**: List all vendors and their products.

**SQL Response**:
```sql
SELECT Vendors.VendorName, Products.ProductName FROM Vendors 
INNER JOIN Products ON Vendors.VendorID = Products.VendorID;
```

SQL Result: [('Panadería El Salvador', 'Bread'), ('McDonalds', 'Big Mac')]

**Friendly Response**: Vendors and their products include Panadería El Salvador selling Bread, and McDonalds selling Big Mac.

---

## Conclusion

My findings show that for queries with well-structured joins, GPT-4 does well in generating SQL queries and interpreting the results. However, for cases where no data is returned, GPT tends to give generic responses. This could be improved with better prompting strategies.
