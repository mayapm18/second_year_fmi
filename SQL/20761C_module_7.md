## **1. INSERT Statement**
- **Three main forms:**
  1. **INSERT VALUES:** `INSERT INTO Table (cols) VALUES (values), (more values)...`
  2. **INSERT SELECT:** `INSERT INTO Table (cols) SELECT cols FROM Source`
  3. **INSERT EXEC:** `INSERT INTO Table (cols) EXEC StoredProcedure`

- **Column list is optional but recommended** (safer)
- **Multiple rows:** Use comma-separated value sets: `VALUES (1,2), (3,4), (5,6)`
- **Default values:** Use `DEFAULT` keyword or omit column from list
- **NULL values:** Use `NULL` keyword for nullable columns

## **2. SELECT INTO**
- **Creates a new table** based on SELECT results
- **Syntax:** `SELECT cols INTO NewTable FROM Source`
- **Copies:** Column names, data types, NULL settings
- **Does NOT copy:** Constraints, indexes, triggers
- **Use case:** Quick table creation for testing/export

## **3. UPDATE Statement**
- **Modifies existing rows**
- **Syntax:** `UPDATE Table SET col1 = value1, col2 = value2 WHERE condition`
- **ALWAYS use WHERE clause** (unless intentionally updating all rows)
- **Compound operators:** `unitprice *= 1.04` (increase by 4%)
- **Multiple columns:** Comma-separated assignments

## **4. DELETE Statement**
- **Removes entire rows**
- **Syntax:** `DELETE FROM Table WHERE condition`
- **ALWAYS use WHERE clause** (unless intentionally deleting all rows)
- **Can use IN operator:** `WHERE contactname IN ('Name1', 'Name2')`

## **5. TRUNCATE TABLE**
- **Removes ALL rows** quickly
- **Minimal logging** (faster than DELETE)
- **Resets identity counter** to seed value
- **Cannot use WHERE clause**
- **Cannot truncate tables with FOREIGN KEY constraints** (must drop constraints first)

## **6. MERGE Statement (Upsert)**
- **Combines INSERT, UPDATE, DELETE** in one statement
- **Matches source and target** using ON clause
- **Three main clauses:**
  1. `WHEN MATCHED THEN UPDATE SET ...`
  2. `WHEN NOT MATCHED BY TARGET THEN INSERT ...`
  3. `WHEN NOT MATCHED BY SOURCE THEN DELETE ...`
- **Use case:** Synchronizing two tables

**Basic MERGE syntax:**
```sql
MERGE INTO TargetTable AS T
USING SourceTable AS S
ON T.Key = S.Key
WHEN MATCHED THEN 
    UPDATE SET T.col = S.col
WHEN NOT MATCHED THEN
    INSERT (cols) VALUES (S.cols);
```

## **7. IDENTITY Property**
- **Auto-incrementing column**
- **One per table only**
- **Syntax:** `col INT IDENTITY(seed, increment)`
- **Seed:** Starting value (default 1)
- **Increment:** Step value (default 1)
- **INSERT behavior:** Omit IDENTITY column from INSERT statement
- **Retrieve last value:** 
  - `SCOPE_IDENTITY()` - Current session and scope
  - `@@IDENTITY` - Current session only (less safe)
  - `IDENT_CURRENT('Table')` - For specific table
- **Manual insert:** `SET IDENTITY_INSERT TableName ON` (then OFF after)

## **8. SEQUENCE Objects (SQL Server 2012+)**
- **Independent database object** (not tied to a table)
- **Reusable across multiple tables**
- **Create:** `CREATE SEQUENCE SeqName AS INT START WITH 1 INCREMENT BY 1`
- **Get next value:** `NEXT VALUE FOR SeqName`
- **Advantages over IDENTITY:** More flexible, can be shared

## **9. OUTPUT Clause**
- **Returns affected rows** from INSERT/UPDATE/DELETE/MERGE
- **Useful for auditing/logging**
- **Access deleted/inserted virtual tables:**
  - `INSERTED.*` - New values (INSERT/UPDATE)
  - `DELETED.*` - Old values (DELETE/UPDATE)
- **Example:** `DELETE FROM Table OUTPUT DELETED.* WHERE ...`

## **10. Critical Best Practices**
- **ALWAYS test UPDATE/DELETE with SELECT first**
- **ALWAYS use WHERE clause** with UPDATE/DELETE (unless intentional)
- **Use transactions** for multiple operations: `BEGIN TRANSACTION ... COMMIT`
- **Consider using OUTPUT clause** for verification
- **IDENTITY columns:** Use SCOPE_IDENTITY() not @@IDENTITY

---

### **Most Likely Quiz Questions:**
1. **"What happens if you omit the WHERE clause in an UPDATE statement?"** (Updates ALL rows)
2. **"How do you insert multiple rows with one INSERT statement?"** (Multiple value sets: `VALUES (...), (...), (...)`)
3. **"What's the difference between DELETE and TRUNCATE?"** (TRUNCATE is faster, resets identity, no WHERE, minimal logging)
4. **"Which function returns the last identity value within the current scope?"** (SCOPE_IDENTITY())
5. **"How do you manually insert a value into an IDENTITY column?"** (`SET IDENTITY_INSERT TableName ON`)
6. **"What does MERGE do?"** (Combines INSERT/UPDATE/DELETE based on source-target comparison)
7. **"How do you create a table from a SELECT query?"** (`SELECT * INTO NewTable FROM Source`)

**Study Priority:** INSERT variations, UPDATE/DELETE with WHERE, IDENTITY vs SEQUENCE, MERGE concept.