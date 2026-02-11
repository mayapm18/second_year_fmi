## **Module 1: Introduction to Microsoft SQL Server**
- Basic architecture of SQL Server (client-server model)
- System databases: master, model, msdb, tempDb, resource
- SQL Server editions: Enterprise, Standard, Business Intelligence, Express
- SQL Server Management Studio (SSMS) usage
- Connecting to SQL Server instances

## **Module 2: Introduction to T-SQL Querying**
- T-SQL language elements: predicates, operators, functions, variables, expressions
- Categories of T-SQL statements: DML, DDL, DCL
- Set theory concepts in SQL Server
- Predicate logic and three-valued logic (true, false, unknown)
- **Logical order of operations in SELECT statements** (FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY)

## **Module 3: Writing SELECT Queries**
- SELECT statement structure
- Using DISTINCT to eliminate duplicates
- Column and table aliases (using AS keyword)
- Simple CASE expressions
- Best practices: always use semicolons, use AS for aliases

## **Module 4: Querying Multiple Tables**
- Types of joins: INNER, OUTER (LEFT/RIGHT/FULL), CROSS, SELF
- Cartesian products
- ANSI SQL-92 vs SQL-89 syntax (prefer JOIN/ON syntax)
- Multiple-table joins
- Using table aliases (required for self joins)

## **Module 7: Using DML to Modify Data**
- INSERT statement forms: VALUES, SELECT, EXEC
- SELECT INTO vs INSERT SELECT
- UPDATE statement with SET and WHERE clauses
- DELETE vs TRUNCATE
- MERGE statement (insert, update, delete in one operation)
- IDENTITY property and SEQUENCE objects

## **Module 9: Grouping and Aggregating Data**
- Aggregate functions: SUM, AVG, MIN, MAX, COUNT, COUNT_BIG
- Using DISTINCT with aggregate functions
- Handling NULLs in aggregate functions
- GROUP BY clause usage
- **Difference between WHERE and HAVING clauses**
- Logical processing with GROUP BY

## **Module 17: Implementing Error Handling**
- @@ERROR vs TRY/CATCH blocks
- RAISERROR vs THROW statements
- Error handling functions: ERROR_NUMBER(), ERROR_MESSAGE(), etc.
- Catchable vs non-catchable errors
- Creating custom error messages

## **Module 18: Implementing Transactions**
- Transactions vs batches
- Transaction control: BEGIN TRANSACTION, COMMIT, ROLLBACK
- Autocommit vs explicit transactions
- Using XACT_STATE() function
- SET XACT_ABORT ON/OFF behavior
- Nested transactions behavior

## **Key Concepts to Focus On:**
1. **Logical query processing order** - understand this thoroughly
2. **JOIN types and their differences** - when to use each type
3. **Aggregate functions with GROUP BY** - especially column requirements
4. **Error handling approaches** - @@ERROR limitations vs TRY/CATCH
5. **Transaction management** - COMMIT vs ROLLBACK scenarios
6. **NULL handling** - in predicates, joins, and aggregates

## **Common Exam Topics:**
- Identifying errors in T-SQL code
- Predicting query results based on logical processing order
- Choosing appropriate JOIN types for scenarios
- Understanding transaction behavior with errors
- Proper use of aggregate functions with GROUP BY

**Best Practice:** Review the "Module Review and Takeaways" sections at the end of each module for review questions and key points.
