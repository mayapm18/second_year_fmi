## **1. T-SQL Language Basics**
- **T-SQL = Microsoft's implementation of SQL** (ANSI/ISO standard)
- **Declarative language** - You describe *what* you want, not *how* to get it
- **Three categories of SQL statements:**
  1. **DML** (Data Manipulation Language) - `SELECT, INSERT, UPDATE, DELETE`
  2. **DDL** (Data Definition Language) - `CREATE, ALTER, DROP`
  3. **DCL** (Data Control Language) - `GRANT, REVOKE, DENY`

## **2. T-SQL Language Elements (Key Examples)**
- **Predicates:** `IN, BETWEEN, LIKE`
- **Comparison Operators:** `=, <, >, >=, <=, !=`
- **Logical Operators:** `AND, OR, NOT` (Order: `NOT` → `AND` → `OR`)
- **Arithmetic Operators:** `+, -, *, /, %` (Modulo)
- **Concatenation:** `+` for strings
- **Comments:**
  - Single line: `-- comment`
  - Block: `/* comment */`
- **Batch Separator:** `GO` (not a T-SQL command, used by SSMS)

## **3. Functions Categories (Know Examples)**
- **String:** `SUBSTRING, LEFT, RIGHT, LEN, REPLACE, UPPER/LOWER`
- **Date/Time:** `GETDATE, YEAR, MONTH, DAY, DATEADD, DATEDIFF`
- **Aggregate:** `SUM, MIN, MAX, AVG, COUNT`
- **Mathematical:** `ROUND, POWER, ABS, CEILING, FLOOR`

## **4. Variables**
- **Local variables** start with `@` (e.g., `@MyVar`)
- **System functions** start with `@@` (e.g., `@@ERROR`)
- **Declare and initialize:** `DECLARE @var INT = 5;`
- **Scope:** Variables are local to the batch

## **5. Set Theory & SQL Server**
- **Set = Collection of distinct objects**
- **Members must be unique** (enforced by keys)
- **No defined order** in sets (use `ORDER BY` for sorting)
- **Think in sets, not rows** - Process whole sets at once
- **Avoid cursors/loops** when possible

## **6. Predicate Logic**
- **Predicate = Boolean expression** (TRUE, FALSE, or UNKNOWN)
- **Three-valued logic:** Must account for `NULL` (UNKNOWN)
- **Used in:** `WHERE, HAVING, CASE, JOIN ON`, subqueries, constraints

## **7. LOGICAL ORDER OF OPERATIONS (CRITICAL!)**
**Execution order ≠ Written order:**
1. **FROM** - Identify source tables
2. **WHERE** - Filter rows
3. **GROUP BY** - Group rows
4. **HAVING** - Filter groups
5. **SELECT** - Choose columns (aliases created here)
6. **ORDER BY** - Sort results

**Key Implications:**
- Can't use column aliases from SELECT in WHERE/GROUP BY/HAVING
- GROUP BY happens before SELECT, so only grouped columns/aggregates in SELECT
- ORDER BY is the only place to guarantee sort order

## **8. Writing SELECT Statements Process**
1. Determine **FROM** (tables)
2. Add **WHERE** (row filters)
3. Add **GROUP BY** (if grouping)
4. Add **HAVING** (if filtering groups)
5. Write **SELECT** (choose columns)
6. Add **ORDER BY** (if sorting needed)

---

### **Most Likely Quiz Questions:**
1. **"What is the execution order of SELECT statement clauses?"** (FROM→WHERE→GROUP BY→HAVING→SELECT→ORDER BY)
2. **"Which category does SELECT belong to?"** (DML)
3. **"True/False: You can use a column alias from SELECT in the WHERE clause."** (False)
4. **"What are the three results of predicate logic in SQL?"** (TRUE, FALSE, UNKNOWN)
5. **"What operator is used for string concatenation?"** (`+`)
6. **"Why must you use ORDER BY to sort results?"** (Sets have no inherent order)
7. **"How do you declare a local variable?"** (`DECLARE @var INT;`)

**Study Priority:** Logical order of operations, T-SQL categories (DML/DDL/DCL), Set theory principles, Three-valued logic.
