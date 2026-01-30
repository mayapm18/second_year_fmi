## **1. Join Fundamentals**
- **FROM clause creates a virtual table** that subsequent clauses (WHERE, SELECT) consume
- **Cartesian product** = Every row from Table1 combined with every row from Table2
- **Three main join types:** INNER, OUTER (LEFT/RIGHT/FULL), CROSS
- **Always use table aliases** for readability and to avoid ambiguity

## **2. INNER JOIN**
- **Returns only matching rows** from both tables
- **Syntax:** `FROM T1 INNER JOIN T2 ON T1.col = T2.col`  
  (INNER keyword optional: `JOIN` defaults to INNER)
- **Order of tables doesn't matter** (commutative)
- **Composite join:** Multiple conditions: `ON T1.col1 = T2.col1 AND T1.col2 = T2.col2`
- **Multiple tables:** Chain JOINs: `T1 JOIN T2 ON ... JOIN T3 ON ...`

## **3. OUTER JOIN**
- **Preserves all rows from one table** + matching rows from other
- **LEFT OUTER JOIN:** All rows from left table + matches from right (NULLs for non-matches)
- **RIGHT OUTER JOIN:** All rows from right table + matches from left
- **FULL OUTER JOIN:** All rows from both tables (NULLs where no match)
- **Table order matters** (determines LEFT vs RIGHT)
- **Find non-matches:** Add `WHERE T2.col IS NULL`

**Example: Customers without orders**
```sql
SELECT c.custid, c.companyname
FROM Sales.Customers AS c
LEFT OUTER JOIN Sales.Orders AS o ON c.custid = o.custid
WHERE o.orderid IS NULL;
```

## **4. CROSS JOIN**
- **Cartesian product** - All possible combinations
- **No ON clause** (no matching condition)
- **Use cases:** Generate test data, create number tables, combine all options
- **Syntax:** `FROM T1 CROSS JOIN T2` or SQL-89: `FROM T1, T2`

## **5. SELF JOIN**
- **Join a table to itself**
- **Requires table aliases** (must differentiate instances)
- **Use cases:** Employee-manager relationships, comparing rows within same table
- **Example: Employees with managers**
```sql
SELECT e.empid, e.lastname AS emp, m.lastname AS mgr
FROM HR.Employees AS e
INNER JOIN HR.Employees AS m ON e.mgrid = m.empid;
```

## **6. Syntax Versions (CRITICAL)**
- **ANSI SQL-92 (PREFERRED):** `FROM T1 JOIN T2 ON condition`
- **ANSI SQL-89 (Avoid):** `FROM T1, T2 WHERE condition`
- **Why SQL-92 is better:**
  - Clear separation of join logic (ON) from filtering (WHERE)
  - Harder to accidentally create Cartesian products
  - Required for OUTER JOINs
  - ON clause missing = syntax error

## **7. Logical Processing Order (Remember)**
1. **FROM** (creates virtual table with joins)
2. **WHERE** (filters rows)
3. **GROUP BY** 
4. **HAVING**
5. **SELECT** 
6. **ORDER BY**

**Implication:** Table aliases defined in FROM are visible everywhere; column aliases from SELECT are only visible in ORDER BY.

---

### **Most Likely Quiz Questions:**
1. **"What type of join returns all rows from the left table and matching rows from the right?"** (LEFT OUTER JOIN)
2. **"Which syntax is recommended for joins and why?"** (ANSI SQL-92 - clearer, prevents accidental Cartesian products)
3. **"How do you find customers who have never placed an order?"** (LEFT JOIN + WHERE Orders.orderid IS NULL)
4. **"What is the result of a CROSS JOIN between a 5-row table and a 10-row table?"** (50 rows - Cartesian product)
5. **"True/False: INNER JOIN and LEFT OUTER JOIN return the same results if all rows match."** (True)
6. **"When is a self join necessary?"** (When comparing rows within the same table, like employee-manager)
7. **"What happens if you omit the ON clause in an INNER JOIN?"** (Syntax error in SQL-92; Cartesian product in SQL-89)

**Study Priority:** INNER vs OUTER JOIN differences, SQL-92 syntax, self joins, finding non-matches with NULL check.
