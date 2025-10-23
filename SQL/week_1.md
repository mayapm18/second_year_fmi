# 🧠 SQL SERVER NOTES

*Hyper-V Manager*

Password : 019-work, Pa55w.rd, RSMT2018

------------------------
## SUM UP
* **Database Structure:** `.mdf`, `.ndf`, `.ldf` files store data and logs.  
* **SQL Commands:** DML (`SELECT`, `INSERT`, `UPDATE`, `DELETE`), DDL (`CREATE`, `ALTER`, `DROP`).  
* **Constraints & Keys:** `PRIMARY`, `FOREIGN`, `UNIQUE`, `CHECK`, `NOT NULL` ensure data integrity.  
* **Normalization:** Use 1NF–5NF to remove redundancy and maintain consistency.  
* **Administration:** Manage permissions (`GRANT`, `REVOKE`, `DENY`) and perform backups (Full, Diff, Log).

---

## 1️⃣ Understanding Core Database Concepts

- **Database** → organized data collection  
- **Files:**
  - `.mdf` → main data  
  - `.ndf` → optional secondary  
  - `.ldf` → log (transactions)
- **DBMS (Database Management System)** → manages data, users, security  
  - Examples: SQL Server, Oracle, MySQL
- **Types of Databases:**
  - Relational (tables, SQL)
  - NoSQL (non-relational)
  - Distributed / Cloud / Data Warehouse
- **Constraints:**
  - `PRIMARY KEY` → unique row
  - `FOREIGN KEY` → link between tables
  - `UNIQUE` → no duplicates
  - `CHECK` → must meet condition
  - `DEFAULT` → default value
  - `NOT NULL` → cannot be empty
- **SQL Languages:**
  - **DML** → `SELECT`, `INSERT`, `UPDATE`, `DELETE`
  - **DDL** → `CREATE`, `ALTER`, `DROP`

---

## 2️⃣ Creating Database Objects

- **Data Types:**
  - Numeric → `INT`, `FLOAT`, `DECIMAL`
  - Text → `CHAR`, `VARCHAR`, `NCHAR`, `NVARCHAR`
  - Date/Time → `DATE`, `DATETIME`, `TIME`
  - Other → `BIT`, `BINARY`, `UNIQUEIDENTIFIER`
- **Conversions:**
  - Implicit → auto
  - Explicit → `CAST()` / `CONVERT()`
- **Views:**
  - Virtual tables
  - Based on `SELECT`
  - Simplify queries, improve security
- **Stored Procedures:**
  - Saved SQL code block
  - `CREATE PROCEDURE name AS ...`
  - Reusable + faster execution
- **SQL Injection:**
  - Malicious SQL input
  - Prevent → parameters, validation, stored procedures

---

## 3️⃣ Manipulating Data

### 🔹 Queries
- `SELECT ... FROM ... WHERE ...`
- Combine conditions → `AND`, `OR`, `NOT`
- Filtering:
  - `BETWEEN`, `IN`, `LIKE`
  - `UNION / UNION ALL` → combine results
  - `EXCEPT / INTERSECT` → compare results

### 🔹 JOINs
- `INNER JOIN` → only matching rows
- `LEFT JOIN` → all left + matches
- `RIGHT JOIN` → all right + matches
- `FULL OUTER JOIN` → all rows (matched + unmatched)

### 🔹 DML Commands
- `INSERT INTO table VALUES (...)`
- `UPDATE table SET col = val WHERE cond`
- `DELETE FROM table WHERE cond`
- `TRUNCATE TABLE` → delete all rows (keeps structure)
- `DROP TABLE` → delete table completely

**Referential Integrity:**  
→ keeps foreign key links valid (no orphan records)

---

## 4️⃣ Understanding Data Storage

### 🔹 Normalization 
= process of organizing data in a database  
→ Goal: eliminate redundancy, avoid anomalies, and ensure data integrity 

| Normal Form | Rule | Removes |
|--------------|------|----------|
| 1NF | No repeating groups | duplicate columns |
| 2NF | Fully depends on PK | partial dependencies |
| 3NF | No non-key dependencies | transitive deps |
| 4NF | Isolate multi-values | multi-valued deps |
| 5NF | Isolate semantic relations | complex deps |

### 🔹 Keys
- **Primary Key** → unique row ID  
- **Foreign Key** → link to another table  
- **Composite Key** → multiple columns as key  
---

## 5️⃣ Administrating a Database

### 🔹 Permissions
- `GRANT` → allow  
- `REVOKE` → remove  
- `DENY` → block  

### 🔹 Backups & Restores
- **Full Backup** → entire DB  
- **Differential** → since last full backup  
- **Transaction Log Backup** → since last log backup  
- **Partial / File Backups** → specific files or filegroups  
- **Restore** → recover data  

