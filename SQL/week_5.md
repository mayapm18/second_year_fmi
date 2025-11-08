### How to sort data:
````ORDER BY Clause ````

ASC and DESC
ORDER BY <use column names>, <column aliases>. <ASC|DESC>, Реда на колоната в SELECT - число

````WHERE```
- използваме истинските имена на колоните, а не синонимите 
Ако ползваме от ```FROM`` синоними, няма проблем да  с еползват тези има и в WHERE

----------------

````TOP ```` = ````SELEct` ``
Here’s a concise **Markdown summary** of the two presentations extracted from the uploaded HTML files:

---

# Module 05 — Sorting and Filtering Data

### Overview

In this module, you learn how to enhance a query to limit the number of rows returned and control the order in which they are displayed.

### Main Topics

* Sorting Data
* Filtering Data with Predicates
* Filtering Data with `TOP` and `OFFSET-FETCH`
* Working with Unknown Values (`NULL`)

### Key Concepts

#### Sorting Data

* Use `ORDER BY` to sort query results.
* Default order is ascending (`ASC`); use `DESC` for descending.
* You can sort by multiple columns.

#### Filtering Data with Predicates

* `WHERE` clause restricts rows returned by a query.
* Common predicates:

  * `=`, `>`, `<`, `>=`, `<=`, `<>`
  * `BETWEEN`, `IN`, `LIKE`, `IS NULL`
* Combine predicates with `AND`, `OR`, and `NOT`.

#### Filtering with `TOP` and `OFFSET-FETCH`

* `TOP (n)` limits the number of returned rows.
* Example:

  ```sql
  SELECT TOP 5 * FROM Sales ORDER BY Amount DESC;
  ```
* `OFFSET-FETCH` provides pagination:

  ```sql
  SELECT * FROM Sales ORDER BY Date
  OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY;
  ```

#### Working with Unknown Values

* `NULL` means “unknown or missing data.”
* Comparisons with `NULL` return `UNKNOWN`.
* Use `IS NULL` or `IS NOT NULL` instead of `=`.

### Lab Review Question

* What is the difference between filtering using the `TOP` option and using the `WHERE` clause?

### Key Takeaways

* `ORDER BY` defines sort order of query results.
* `WHERE` filters rows based on conditions.
* `TOP` and `OFFSET-FETCH` limit and page results.
* Handle `NULL` values carefully — they do not equal anything, even another `NULL`.

---

# Module 06 — Working with SQL Server Data Types

### Overview

To write effective T-SQL queries, you must understand how SQL Server stores different data types. This affects comparisons, conversions, and data manipulation.

### Main Topics

* Introducing SQL Server Data Types
* Working with Character Data
* Working with Date and Time Data

### Learning Objectives

After completing this module, you will be able to:

* Describe SQL Server data types, type precedence, and conversions.
* Work with character data using built-in functions.
* Work with date and time data using temporal functions.

### Key Concepts

#### SQL Server Data Types

* **Numeric types:** `int`, `decimal`, `float`, etc.
* **Character types:** `char`, `varchar`, `nchar`, `nvarchar`.
* **Date/time types:** `date`, `datetime`, `datetime2`, `time`.
* **Other types:** `bit`, `binary`, `varbinary`, `uniqueidentifier`.

#### Type Precedence and Conversion

* SQL Server automatically converts data when types differ.
* Explicit conversion:

  * `CAST(expression AS data_type)`
  * `CONVERT(data_type, expression [, style])`
* Implicit conversions may cause performance issues.

#### Working with Character Data

Common functions:

* `LEN()`, `LEFT()`, `RIGHT()`, `SUBSTRING()`, `REPLACE()`, `UPPER()`, `LOWER()`, `LTRIM()`, `RTRIM()`.
  Example:

```sql
SELECT UPPER(FirstName), LEN(LastName) FROM Employees;
```

#### Working with Date and Time Data

* Functions:

  * `GETDATE()`, `SYSDATETIME()` — current system date/time.
  * `DATEADD()`, `DATEDIFF()`, `DATEPART()`, `YEAR()`, `MONTH()`, `DAY()`.
* Example:

```sql
SELECT DATEADD(day, 7, GETDATE()) AS NextWeek;
```

### Lab Result

After completing the lab, you should understand how to use character and date/time functions in T-SQL.

### Module Review

You have learned to:

* Describe SQL Server data types, precedence, and conversions.
* Work with character-based and date/time data.

### Key Takeaways

* Choose appropriate data types for accuracy and performance.
* Use explicit conversion to control type behavior.
* Master string and date functions for real-world data manipulation.

---

Would you like me to generate this as a downloadable `.md` file (`Module05-06-summary.md`)?
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
