## **1. Aggregate Functions Basics**
- **Operate on multiple rows** to return a single (scalar) value
- **Common functions:** 
  - `SUM()` - Total of numeric values
  - `AVG()` - Average of numeric values
  - `MIN()` - Smallest value (numbers, dates, strings)
  - `MAX()` - Largest value (numbers, dates, strings)
  - `COUNT()` - Number of rows (`COUNT(*)`) or non-NULL values (`COUNT(column)`)
  - `COUNT_BIG()` - Same as COUNT but returns `bigint` for large results
- **Ignore NULLs** (except `COUNT(*)` which counts all rows including NULLs)
- **Return no column name** by default - use aliases

## **2. DISTINCT with Aggregates**
- `COUNT(DISTINCT column)` - Counts unique non-NULL values
- `SUM(DISTINCT column)` - Sums unique values only
- **Different from SELECT DISTINCT:** Aggregates eliminate duplicate values, not rows
- **Example:** `COUNT(DISTINCT custid)` counts unique customers

## **3. NULL Handling in Aggregates**
- **NULLs are ignored** in SUM, AVG, MIN, MAX, COUNT(column)
- **`COUNT(*)` includes NULLs** (counts all rows)
- **AVG vs SUM/COUNT* difference:**
  - `AVG(column)` = `SUM(column)/COUNT(column)` (ignores NULLs)
  - `SUM(column)/COUNT(*)` includes NULL rows in denominator
- **Replace NULLs before aggregating:** `AVG(COALESCE(column, 0))`

## **4. GROUP BY Clause**
- **Groups rows** based on unique combinations of specified columns
- **Syntax:** `GROUP BY column1, column2, ...`
- **Logical processing order:**
  1. FROM
  2. WHERE (filters rows)
  3. GROUP BY (creates groups)
  4. HAVING (filters groups)
  5. SELECT
  6. ORDER BY
- **After GROUP BY, detail rows are "lost"** - only groups exist

## **5. SELECT with GROUP BY Rules**
- **Columns in SELECT must be either:**
  1. In GROUP BY clause, OR
  2. Input to an aggregate function
- **Error example:** 
  ```sql
  SELECT empid, orderdate, COUNT(*)  -- ERROR: orderdate not in GROUP BY
  FROM Sales.Orders
  GROUP BY empid;
  ```
- **Correct:**
  ```sql
  SELECT empid, YEAR(orderdate), COUNT(*)
  FROM Sales.Orders
  GROUP BY empid, YEAR(orderdate);
  ```

## **6. HAVING Clause**
- **Filters groups** (WHERE filters rows)
- **Used after GROUP BY**, before SELECT
- **Can use aggregate functions:** `HAVING COUNT(*) > 10`
- **Cannot use column aliases** from SELECT (processed before SELECT)
- **WHERE vs HAVING:**
  - **WHERE:** Filters individual rows BEFORE grouping
  - **HAVING:** Filters groups AFTER grouping
- **Can use both in same query**

## **7. Common Patterns & Examples**
**Count unique customers per year:**
```sql
SELECT YEAR(orderdate), COUNT(DISTINCT custid)
FROM Sales.Orders
GROUP BY YEAR(orderdate);
```

**Products with average price > 20:**
```sql
SELECT productid, AVG(unitprice) AS avgprice
FROM Sales.OrderDetails
GROUP BY productid
HAVING AVG(unitprice) > 20;
```

**Total sales per customer with > 25 orders:**
```sql
SELECT custid, SUM(qty * unitprice) AS totalsales
FROM Sales.Orders o
JOIN Sales.OrderDetails d ON o.orderid = d.orderid
GROUP BY custid
HAVING COUNT(DISTINCT o.orderid) > 25;
```

## **8. COUNT() Variations**
- `COUNT(*)` - Counts all rows (including NULLs)
- `COUNT(column)` - Counts non-NULL values in column
- `COUNT(1)` or `COUNT('x')` - Same as COUNT(*) (counts all rows)
- `COUNT(DISTINCT column)` - Counts unique non-NULL values

## **9. Important Notes**
- **Aggregates cannot be nested:** `SUM(AVG(column))` is invalid
- **Multiple aggregates in same SELECT are OK:** `SELECT SUM(), AVG(), COUNT()`
- **Use DISTINCT carefully:** `SUM(DISTINCT price)` sums unique prices only
- **GROUP BY multiple columns:** Creates groups for each unique combination

---

### **Most Likely Quiz Questions:**
1. **"Which aggregate function includes NULL values in its calculation?"** (`COUNT(*)`)
2. **"What error occurs if a column in SELECT isn't in GROUP BY or an aggregate?"** (Msg 8120)
3. **"What's the difference between WHERE and HAVING?"** (WHERE filters rows, HAVING filters groups)
4. **"How do you count unique customers in orders?"** (`COUNT(DISTINCT custid)`)
5. **"What does AVG() return if a column has NULL values?"** (Average of non-NULL values only)
6. **"True/False: You can use a column alias from SELECT in the HAVING clause."** (False)
7. **"Which comes first logically: WHERE or GROUP BY?"** (WHERE → GROUP BY)

**Study Priority:** GROUP BY rules, WHERE vs HAVING, NULL behavior in aggregates, COUNT variations.