## Module 17: Implementing Error Handling

### Key Takeaways

* Understand how T-SQL error handling works.
* Learn traditional error handling approaches.
* Implement structured exception handling with TRY/CATCH.
* Use THROW to raise errors.
* Know how errors propagate and how SQL Server reacts.

### Potential Questions

* What are the benefits of using TRY/CATCH in T-SQL?
* How does THROW differ from RAISERROR?
* What are common misconceptions about T-SQL error handling?
* What happens inside a CATCH block and what functions can you use?

---

## Module 18: Implementing Transactions

### Key Takeaways

* Understand the concept of transactions and how they differ from batches.
* Learn transaction control: BEGIN TRAN, COMMIT, ROLLBACK.
* Use SET XACT_ABORT to handle errors automatically.
* Use TRY/CATCH with transactions to ensure rollback on failure.
* Understand nested transactions and savepoints.

### Potential Questions

* What is the difference between batches and transactions?
* What does SET XACT_ABORT do, and when should you use it?
* Why is TRY/CATCH recommended for transactional code?
* What happens when an error occurs inside a transaction?
* How do you roll back only part of a transaction using savepoints?

---

### Module 17: Implementing Error Handling — Detailed Breakdown

#### 1. How T-SQL Errors Work

* SQL Server categorizes errors: syntax errors, run-time errors, constraint violations, deadlocks.
* Some errors terminate the batch; others do not.
* TRY/CATCH works only for run-time errors, not compile errors.

#### 2. TRY/CATCH Structure

* TRY block contains the code to execute.
* CATCH block runs only if an error occurs inside TRY.
* Inside CATCH, you can use built‑in functions such as:

  * `ERROR_MESSAGE()`
  * `ERROR_LINE()`
  * `ERROR_NUMBER()`
  * `ERROR_PROCEDURE()`
  * `ERROR_SEVERITY()`
  * `ERROR_STATE()`
* Errors detected in CATCH do **not** automatically rethrow; you must explicitly use THROW.

#### 3. THROW vs RAISERROR

* `THROW` (newer):

  * Always stops execution.
  * Requires an error number ≥ 50000.
  * Automatically sets severity to 16.
  * Simpler syntax.
* `RAISERROR` (older):

  * More flexible (custom severity & state).
  * Deprecated in new development.

#### 4. Traditional Error Handling Issues

* Code before TRY/CATCH required checking `@@ERROR` after each statement.
* Harder to maintain.
* Missed errors if not checked immediately.

#### 5. Structured Exception Handling

* Recommended for all modern T‑SQL coding.
* Use THROW inside CATCH for proper error propagation.

---

### Module 18: Implementing Transactions — Detailed Breakdown

#### 1. What Is a Transaction?

A transaction is a sequence of operations that must be treated as a single logical unit, ensuring:

* **Atomicity**: all succeed or none do.
* **Consistency**: data integrity is maintained.
* **Isolation**: operations do not interfere with each other.
* **Durability**: committed changes persist.

#### 2. Batches vs Transactions

* A **batch** is a group of T‑SQL statements sent to SQL Server as one unit.
* A **transaction** defines rules for whether work succeeds or must be rolled back.
* Batches may contain multiple transactions.

#### 3. Transaction Control Statements (TCL)

* `BEGIN TRAN` — starts a new transaction.
* `COMMIT TRAN` — saves all changes.
* `ROLLBACK TRAN` — undoes all changes since BEGIN.
* `SAVE TRAN SavePointName` — creates a savepoint so you can roll back partially.

#### 4. Error Handling With Transactions

Recommended pattern:

```
BEGIN TRY
    BEGIN TRAN

    -- SQL statements

    COMMIT TRAN
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN

    THROW
END CATCH
```

#### 5. XACT_ABORT

* When enabled, **any run‑time error causes an automatic rollback**.
* Useful for:

  * Distributed transactions
  * Bulk inserts
  * Scenarios where partial commits must be avoided

#### 6. Nested Transactions

* SQL Server uses a counter (`@@TRANCOUNT`).
* Only the **outermost** COMMIT actually commits.
* Any ROLLBACK rolls back the entire transaction stack.

#### 7. Common Transaction Pitfalls

* Forgetting to check `@@TRANCOUNT` before committing or rolling back.
* Using nested transactions incorrectly.
* Not rethrowing errors inside CATCH.
* Relying on TRY/CATCH for compile‑time errors (they won't be caught).

---

## Additional Potential Questions

## Answers to Potential Questions

### Module 17 – Error Handling

1. What types of errors can a TRY/CATCH block handle, and what types can it not handle?
2. What happens if an error occurs before the TRY block begins?
3. Explain the difference between THROW and RAISERROR.
4. What information can you extract using ERROR_MESSAGE(), ERROR_LINE(), and ERROR_NUMBER()?
5. Why is it important to rethrow an error inside the CATCH block?
6. What are common mistakes developers make when using TRY/CATCH?
7. How does SQL Server behave when severity levels differ in raised errors?
8. What role does @@ERROR play in legacy error handling?

### Module 18 – Transactions

1. Explain the ACID properties of a transaction.
2. What is the difference between a batch and a transaction?
3. What does SET XACT_ABORT ON do, and when should it be used?
4. How do nested transactions work in SQL Server?
5. What happens when you call ROLLBACK inside a nested transaction?
6. How does SQL Server use @@TRANCOUNT, and why is it important in error handling?
7. When should you use SAVE TRAN, and what problems does it solve?
8. Why must COMMIT always be in the TRY block and ROLLBACK always in the CATCH block?
9. Describe a scenario where partial commits could cause data corruption.

If you want, I can add **answers**, **practice exercises**, or turn these into a **mock exam**.

### Module 17 – Error Handling (Answers)

1. **TRY/CATCH handles run‑time errors** (e.g., constraint violations). It does **not** handle compile-time errors, parse errors, or batch-aborting errors that occur before TRY executes.
2. If an error occurs **before** entering TRY, the CATCH block is never reached; SQL Server stops execution.
3. **THROW** is modern, simpler, always stops execution, and rethrows with original error context. **RAISERROR** is older, allows custom severity/state, but is deprecated.
4. `ERROR_MESSAGE()` returns the text of the error; `ERROR_LINE()` shows where it occurred; `ERROR_NUMBER()` returns the error code.
5. Rethrowing ensures the calling procedure or application knows an error happened and can react properly.
6. Common mistakes: missing THROW in CATCH, assuming all errors are caught, not checking transaction state, mixing RAISERROR and THROW improperly.
7. Severity affects how SQL Server responds—low severity errors continue, while high severity errors can terminate connections or batches.
8. `@@ERROR` stores the error number *after each statement*, requiring manual checks—harder to maintain than TRY/CATCH.

### Module 18 – Transactions (Answers)

1. **ACID**: Atomicity (all or nothing), Consistency (valid state), Isolation (no interference), Durability (permanent after commit).
2. A **batch** is a group of commands sent together; a **transaction** defines whether those commands succeed or fail as a unit.
3. `SET XACT_ABORT ON` makes SQL Server automatically roll back the transaction on *any* run-time error—useful for preventing partial updates.
4. SQL Server uses a counter for nested transactions. Each `BEGIN TRAN` increases it, each `COMMIT` decreases it; only the outermost commit actually commits.
5. A `ROLLBACK` in a nested transaction rolls back the **entire** transaction chain, not just the inner portion.
6. `@@TRANCOUNT` tracks the transaction depth; it's vital for knowing whether a commit or rollback is valid at a given time.
7. SAVE TRAN creates a **savepoint**, allowing partial rollback—useful in complex procedures where part of a transaction may fail.
8. COMMIT must be in TRY to prevent committing when errors occur; ROLLBACK must be in CATCH to ensure cleanup after failure.
9. Example: Deducting inventory from one table and inserting into another—if the insert fails but the deduction succeeds, inventory is corrupted unless a transaction rolls back both.
----------------------------

# Cheat Sheet: Modules 17 & 18 (Error Handling + Transactions)

## 🚨 Module 17 — Error Handling Cheat Sheet

### **TRY/CATCH Basics**

```
BEGIN TRY
   -- code
END TRY
BEGIN CATCH
   -- error handling
END CATCH
```

### **What TRY/CATCH DOES catch:**

* Runtime errors (e.g., constraint violations)
* Foreign key issues
* Divide-by-zero
* Deadlocks (caught in CATCH after retry)

### ❌ **What TRY/CATCH does NOT catch:**

* Syntax errors
* Compile-time errors
* Missing objects
* Batch-aborting errors before TRY executes

### **Error Functions inside CATCH:**

* `ERROR_MESSAGE()` – text of the error
* `ERROR_LINE()` – line where error occurred
* `ERROR_NUMBER()` – error code
* `ERROR_PROCEDURE()` – stored procedure name
* `ERROR_SEVERITY()`
* `ERROR_STATE()`

### **THROW (recommended)**

```
THROW;            -- rethrow original error
THROW 50001, 'Error message', 1;   -- custom error
```

* Simpler than RAISERROR
* Automatically stops execution
* Always severity 16

### **RAISERROR (legacy)**

* More flexible (custom severity), but deprecated.

---

## 🔄 Module 18 — Transactions Cheat Sheet

### **Basic Transaction Pattern**

```
BEGIN TRY
    BEGIN TRAN

    -- work

    COMMIT TRAN
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRAN;
    THROW;
END CATCH
```

### **Key Concepts**

* **Atomicity** — all or nothing
* **Consistency** — data integrity preserved
* **Isolation** — transactions do not affect each other
* **Durability** — committed changes stay

### **Transaction Commands**

* `BEGIN TRAN` – start
* `COMMIT` – save everything
* `ROLLBACK` – undo everything
* `SAVE TRAN SavePoint` – partial rollback

### **SET XACT_ABORT ON**

* Automatically rolls back on *any* runtime error
* Good for: bulk operations, distributed transactions

```
SET XACT_ABORT ON;
```

### **Nested Transactions**

* SQL Server tracks depth via `@@TRANCOUNT`
* Only outermost COMMIT writes to disk
* ANY ROLLBACK undoes *everything*

### **SAVEPOINT Example**

```
BEGIN TRAN
INSERT ...
SAVE TRAN step1
UPDATE ...
ROLLBACK TRAN step1
COMMIT
```

---

## ⚡ Quick Rules to Remember

### Error Handling Rules

✔ THROW inside CATCH to propagate errors
✔ TRY/CATCH only catches runtime errors
✔ RAISERROR is old; THROW is preferred
✔ Error functions only work **inside CATCH**

### Transaction Rules

✔ Always COMMIT in TRY
✔ Always ROLLBACK in CATCH
✔ Check @@TRANCOUNT before committing
✔ SET XACT_ABORT ON prevents partial updates

