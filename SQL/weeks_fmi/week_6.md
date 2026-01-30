# Module 7 – Using DML to Modify Data

### Overview

* DML (Data Manipulation Language) in T-SQL lets you **add, change, or remove** data in tables.
* Commands:

  * `INSERT` – adds new rows.
  * `UPDATE` – modifies existing rows.
  * `DELETE` – removes rows.
  * `TRUNCATE` – quickly deletes all rows from a table.
* You can generate automatic values using:

  * `IDENTITY` property (auto-increment per table)
  * `SEQUENCE` object (reusable across tables)
* `MERGE` command can synchronize data between tables.
(преди `MERGE` са се писали `IF`-фове

### Objectives

After this module, you should be able to:

* Write T-SQL statements to **insert**, **update**, and **delete** rows.
* Use `MERGE` to modify data based on another table.
* Use `IDENTITY` or `SEQUENCE` for automatic number generation.

### Key Takeaways

* DML operations change data, not structure.
* `TRUNCATE` is faster than `DELETE` but can’t use conditions.
* Always check results (for example, with `OUTPUT`).

---

# Module 9 – Grouping and Aggregating Data

## IDENTITY

### @@IDENTITY
- Returns last IDENTITY value **in the current session**.  
- Can return value from a **trigger** (not always safe).

### SCOPE_IDENTITY()
- Returns last IDENTITY value **in the current scope** (same procedure or statement).  
- **Safer**, ignores triggers.

### IDENT_CURRENT('tablename')
- Returns last IDENTITY value **for a specific table**,  
  regardless of session or scope.

| Function | Scope | Trigger Safe | Notes |
|-----------|--------|--------------|-------|
| `@@IDENTITY` | Session | ❌ | May include trigger values |
| `SCOPE_IDENTITY()` | Current scope | ✅ | Recommended |
| `IDENT_CURRENT('table')` | Table (global) | ❌ | Shows latest value for table |

### Overview

* Used to **summarize** data with aggregate functions.
* Key clauses:

  * `GROUP BY` – divides results into groups.
  * `HAVING` – filters grouped results.

### Aggregate Functions

* Common built-ins: `SUM`, `AVG`, `COUNT`, `MIN`, `MAX`.
* Can use `DISTINCT` to ignore duplicates.
* Handles `NULL` values carefully (ignored in most aggregates).

### Objectives

After this module, you should be able to:

* List built-in aggregate functions in SQL Server.
* Write queries that summarize data using `GROUP BY`.
* Filter grouped results using `HAVING`.
* Understand how `GROUP BY` removes detail rows.

### Key Takeaways

* Aggregation happens **after** filtering with `WHERE`.
* `HAVING` works like `WHERE` but for groups.
* You cannot mix detailed and aggregated data without extra logic.
