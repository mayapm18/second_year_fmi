
## **1. SELECT Statement Basics**
- **FROM clause** specifies the table/view
- **SELECT clause** specifies columns to return
- **Best practice:** Use explicit column lists instead of `SELECT *`
- **Always terminate statements with semicolon `;`**
- **Delimit names** with square brackets if they contain special characters/spaces: `[Sales Order Details]`

## **2. DISTINCT Clause**
- **Removes duplicate rows** from result set
- **Operates on ALL columns** in SELECT list, not just the first
- **Default is `SELECT ALL`** (implicit)
- **Returns only unique combinations** of the selected columns
- **Use when you need unique values** (e.g., list of unique countries)

## **3. Column Aliases (3 Methods)**
1. **`AS` keyword (recommended):** `SELECT column AS alias`
2. **Equals sign:** `SELECT alias = column`
3. **Space separator (not recommended):** `SELECT column alias`

**Critical Warning:** Missing commas create accidental aliases!
- Wrong: `SELECT city country` → `city` gets alias `country`
- Right: `SELECT city, country`

## **4. Table Aliases**
- **Created in FROM clause:** `FROM Table AS T`
- **Can omit AS:** `FROM Table T`
- **Useful for readability** and essential for joins (next module)
- **Reference columns with alias:** `T.columnname`

## **5. Logical Processing Order Impact**
**Column aliases created in SELECT are NOT visible to:**
- **WHERE clause** - Will cause "Invalid column name" error
- **HAVING clause** - Same error
- **GROUP BY clause** - Same error

**Column aliases ARE visible to:**
- **ORDER BY clause** - Can use alias name

**Example of error:**
```sql
SELECT qty AS quantity 
FROM Sales.OrderDetails 
WHERE quantity > 10; -- ERROR!
```

**Correct approach:** Repeat expression
```sql
SELECT YEAR(orderdate) AS orderyear 
FROM Sales.Orders 
WHERE YEAR(orderdate) = 2008;
```

## **6. CASE Expressions**
- **Returns scalar (single) value**
- **Two forms:**
  1. **Simple CASE:** Compare one value to list
  2. **Searched CASE:** Evaluate Boolean expressions

**Simple CASE syntax:**
```sql
CASE categoryid
    WHEN 1 THEN 'Beverages'
    WHEN 2 THEN 'Condiments'
    ELSE 'Other'
END AS categoryname
```

**Rules:**
- **Returns first match** (no multiple matches)
- **If no match + no ELSE → returns NULL**
- **Requires alias** (appears as calculated column)

## **7. Calculations in SELECT**
- **Use arithmetic operators:** `+, -, *, /, %`
- **Scalar functions work:** `YEAR(orderdate)`
- **Calculated columns need aliases:**
  ```sql
  SELECT unitprice, qty, (unitprice * qty) AS total
  ```

---

### **Most Likely Quiz Questions:**
1. **"Why should you avoid SELECT * in production?"** (Performance, breaks if table structure changes)
2. **"Which clause can use a column alias from SELECT?"** (ORDER BY only)
3. **"What happens if you omit comma between column names?"** (Creates accidental alias)
4. **"How does DISTINCT work with multiple columns?"** (Unique combinations of all selected columns)
5. **"What does CASE return if no match and no ELSE?"** (NULL)
6. **"True/False: You can reference a table alias in the WHERE clause."** (True - table aliases are fine, column aliases are not)
7. **"What is the recommended way to create a column alias?"** (Using AS keyword)

**Study Priority:** DISTINCT behavior, alias visibility rules, CASE expression structure, avoiding `SELECT *`.