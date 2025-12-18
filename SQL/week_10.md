# SQL Server Architecture, Scheduling, and Waits – Key Notes

## 1. **SQL Server Components and SQLOS**
- **SQLOS** (SQL Server Operating System):
  - Provides OS-level functions to SQL Server (memory management, scheduling, I/O, locking, etc.).
  - Allows SQL Server to use **non-preemptive scheduling** (cooperative multitasking).
  - Collects performance metrics exposed via **Dynamic Management Views (DMVs)**.

- **Database Engine Layers**:
  - **Query Execution Layer** (Relational Engine): Parsing, optimization, execution.
  - **Storage Engine Layer**: Data storage, caching, transaction management.
  - **SQLOS Layer**: Low-level resource management.

- **Connection Protocols**:
  - Shared Memory, Named Pipes, TCP/IP.
  - Application layer uses **Tabular Data Stream (TDS)**.

---

## 2. **CPU Architecture – SMP vs. NUMA**
- **SMP (Symmetric Multiprocessing)**:
  - All CPUs share same memory bus.
  - Scales poorly beyond ~8 CPUs.
- **NUMA (Non-Uniform Memory Access)**:
  - Groups CPUs into nodes with local memory.
  - Remote memory access slower than local.
  - SQLOS is NUMA-aware; tries to keep tasks and memory within same node.

---

## 3. **Query Life Cycle**
1. **Parsing & Binding** – Syntax check, parse tree.
2. **Plan Compilation** – Optimization, plan caching.
3. **Query Execution** – Storage engine retrieves data.
4. **Result Generation** – Results sent to client via TDS.

---

## 4. **Scheduling in SQL Server**
- **Preemptive vs. Non-Preemptive**:
  - Windows uses **preemptive scheduling** (priority-based).
  - SQL Server uses **non-preemptive (cooperative) scheduling** via **SQLOS Scheduler (SOS)**.
  - **Quantum** = 4 ms (max continuous CPU time before yielding).

- **SQLOS Scheduler (SOS)**:
  - One scheduler per CPU core.
  - Maintains lists:
    - **Worker List** – Available workers (threads/fibers).
    - **Runnable List** – Workers ready to run (FIFO queue).
    - **Waiter List** – Workers waiting for resources.
    - **I/O List** – Outstanding I/O requests.
    - **Timer List** – Time-based waits.

- **Worker States**:
  - **Running** – Executing on CPU.
  - **Suspended** – Waiting for resource (in Waiter List).
  - **Runnable** – Ready to run, waiting for CPU (in Runnable List).

---

## 5. **Monitoring Engine Behavior**
- **Activity Monitor** – Built-in SSMS tool for real-time monitoring.
- **Performance Monitor (PerfMon)** – Windows tool for performance counters.
- **Dynamic Management Views (DMVs)** – Internal SQL Server state info.
  - `sys.dm_exec_*` – Query execution.
  - `sys.dm_os_*` – SQLOS operations.
  - `sys.dm_tran_*` – Transactions.
  - `sys.dm_io_*` – I/O activity.
  - `sys.dm_db_*` – Database objects.

---

## 6. **Waits and Queues**
- **Wait Types**:
  - **Resource Waits** – Waiting for a resource (I/O, lock, latch).
  - **Signal Waits** – Waiting for CPU time (Runnable state).

- **Key DMVs for Waits**:
  - `sys.dm_os_wait_stats` – Cumulative wait stats since server start.
  - `sys.dm_os_waiting_tasks` – Currently waiting tasks.
  - `sys.dm_exec_session_wait_stats` (SQL Server 2016+) – Waits per session.

- **Formula**:
  ```
  Resource Wait Time = wait_time_ms - signal_wait_time_ms
  ```

---

## 7. **Common Wait Types and Troubleshooting**
| Wait Type | Indicates | Possible Causes | Solutions |
|-----------|-----------|-----------------|-----------|
| **LCK_M_*** | Waiting for a lock | Blocking, lock escalation | Optimize queries, review isolation levels, indexing |
| **PAGELATCH_*** | Waiting for in-memory page latch | Hot pages, allocation contention | Partitioning, adjust tempdb files, review indexing |
| **PAGEIOLATCH_*** | Waiting for page I/O | Slow disk, poor queries | Faster storage, optimize queries/indexes |
| **CXPACKET** | Parallel query task synchronization | Uneven work distribution, outdated stats | Update stats, adjust MAXDOP, cost threshold |
| **WRITELOG** | Waiting for log flush | Slow log disk, many small transactions | Faster log storage, batch transactions |
| **SOS_SCHEDULER_YIELD** | Worker yielded CPU after quantum | CPU pressure | Optimize CPU-intensive queries |

---

## 8. **Best Practices**
- **Establish a baseline** for wait statistics and compare over time.
- **Monitor regularly** using DMVs and PerfMon.
- **Understand wait types** before jumping to conclusions.
- **Use Activity Monitor** for quick health checks.
- **Keep statistics updated** to help query optimizer.
- **Consider NUMA** when scaling to many CPUs.

---

## 9. **Useful Commands**
```sql
-- Clear wait stats
DBCC SQLPERF('sys.dm_os_wait_stats', CLEAR);

-- View wait stats
SELECT * FROM sys.dm_os_wait_stats ORDER BY wait_time_ms DESC;

-- View waiting tasks
SELECT * FROM sys.dm_os_waiting_tasks WHERE session_id > 50;

-- View schedulers
SELECT * FROM sys.dm_os_schedulers WHERE status = 'VISIBLE ONLINE';

-- View NUMA nodes
SELECT * FROM sys.dm_os_nodes;
```

---

## 10. **Key Takeaways**
- SQL Server uses **non-preemptive scheduling** to control task execution.
- **Waits are normal**, but excessive waits indicate bottlenecks.
- Use **DMVs** to diagnose performance issues at a granular level.
- **Wait statistics + PerfMon counters** = comprehensive performance picture.
- Always **test changes** in a non-production environment first.

-----------------
# Views in SQL Server – Key Notes

## **1. What is a View?**
A **view** is a **stored SELECT query** that behaves like a table but doesn’t store data itself.  
- Data comes from **underlying base tables**.
- Can be referenced in other queries, just like a table.
- Used for:
  - **Simplifying complex table relationships**
  - **Security** (restrict columns/rows users can see)
  - **Providing an abstraction layer** between apps and tables

---

## **2. Types of Views**

| View Type | Description |
|-----------|-------------|
| **User-Defined Views** | Created by developers |
| • **Standard Views** | Non-indexed, query runs each time view is accessed |
| • **Indexed Views** | Has a clustered index, stores data on disk for performance |
| • **Partitioned Views** | Joins horizontally partitioned tables (local or distributed) |
| **System Views** | Provided by SQL Server |
| • **Catalog Views** | System metadata (e.g., `sys.tables`, `sys.views`) |
| • **Dynamic Management Views (DMVs)** | Runtime state info (e.g., `sys.dm_exec_connections`) |
| • **Compatibility Views** | Backward compatibility for SQL Server 2000 |
| • **Information Schema Views** | ISO-standard metadata (e.g., `INFORMATION_SCHEMA.TABLES`) |

---

## **3. Advantages of Views**
- **Simplify complexity** – Hide joins and complex logic.
- **Security** – Restrict access to specific columns/rows.
- **Abstraction layer** – Shield apps from schema changes.
- **Format data for reporting** – Pre-format data for easier reporting.

---

## **4. Creating and Managing Views**
### **CREATE VIEW**
```sql
CREATE VIEW Sales.vw_CustomerOrders AS
SELECT c.CustomerID, c.FirstName, o.OrderDate, o.TotalAmount
FROM Sales.Customers c
JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
WHERE o.Status = 'Shipped';
```

### **View Options**
| Option | Purpose |
|--------|---------|
| `WITH ENCRYPTION` | Obfuscates view definition in system catalog |
| `WITH SCHEMABINDING` | Prevents changes to underlying tables that would break the view (required for indexed views) |
| `WITH VIEW_METADATA` | Returns view metadata (not base table metadata) to APIs |
| `WITH CHECK OPTION` | Ensures data modified through view complies with view’s WHERE clause |

### **ALTER VIEW**
```sql
ALTER VIEW Sales.vw_CustomerOrders AS
SELECT c.CustomerID, c.FirstName, c.LastName, o.OrderDate, o.TotalAmount
FROM Sales.Customers c
JOIN Sales.Orders o ON c.CustomerID = o.CustomerID
WHERE o.Status IN ('Shipped', 'Processing');
```
**Note:** `ALTER VIEW` preserves permissions.

### **DROP VIEW**
```sql
DROP VIEW Sales.vw_CustomerOrders;
```
Drops the view and all associated permissions.

---

## **5. Updateable Views**
A view is **updateable** if:
1. References **only one base table**.
2. Contains **no aggregations** (SUM, AVG, etc.).
3. Has **no DISTINCT, GROUP BY, HAVING, or TOP**.
4. **Columns directly reference base table columns** (no computed columns).
5. Updates comply with **base table constraints** (NOT NULL, PK, FK, etc.).

**Example:**
```sql
CREATE VIEW Sales.vw_CustomersSimple AS
SELECT CustomerID, FirstName, LastName
FROM Sales.Customers;

-- This works:
INSERT INTO Sales.vw_CustomersSimple VALUES (1001, 'John', 'Doe');
```

**WITH CHECK OPTION:**
- Ensures INSERT/UPDATE through view **must satisfy view’s WHERE condition**.

---

## **6. Ownership Chains & Security**
- **Ownership chain** – Sequence of objects referencing each other.
- If view and underlying tables have **same owner**, permissions on view suffice.
- If owners differ, **broken ownership chain** occurs – user needs permissions on **both** view and underlying tables.
- Best practice: place related objects in **same schema** with same owner.

---

## **7. Finding View Information**
| Method | Description |
|--------|-------------|
| `sys.views` | Lists all views in database |
| `OBJECT_DEFINITION(object_id)` | Returns view definition (not for encrypted views) |
| `sp_helptext 'view_name'` | Displays view definition (system stored procedure) |
| `sys.sql_expression_dependencies` | Shows objects the view depends on |
| SSMS Object Explorer | GUI browsing of views |

---

## **8. Performance Considerations**
### **Standard Views**
- **Dynamic resolution** – Query optimizer **merges** view definition into outer query (“inlining”).
- **No separate query plan** for view.
- **Avoid `SELECT *`** – Changes to base tables won’t be reflected until view is refreshed.

### **Indexed Views**
- **Materialized view** with **clustered index**.
- Data stored on disk – good for **aggregations, complex joins**.
- **Improves SELECT performance**, but **slows INSERT/UPDATE/DELETE**.
- Requirements:
  - `WITH SCHEMABINDING`
  - Deterministic columns
  - Proper SET options (e.g., `ANSI_NULLS ON`)

**Use cases:** Data warehouses, reporting systems (read-heavy).

### **Nested Views**
- Views referencing other views.
- **Disadvantages:**
  - Broken ownership chains
  - Hard to debug performance issues
  - Maintenance complexity
- Limit nesting depth for clarity.

### **Partitioned Views**
- **Horizontal partitioning** across tables (same columns).
- Uses `UNION ALL` in view definition.
- **Local** – tables on same server.
- **Distributed** – tables on different servers.
- Benefits: **Improved query performance, easier maintenance**.

---

## **9. Dynamic Management Views (DMVs)**
- Provide **runtime state information**.
- Prefix: `sys.dm_*`
- Examples:
  - `sys.dm_exec_sessions` – Active sessions
  - `sys.dm_exec_requests` – Current requests
  - `sys.dm_exec_query_stats` – Query performance stats
- Used for **monitoring, troubleshooting, performance tuning**.

---

## **10. Best Practices**
1. **Prefix view names** (e.g., `vw_EmployeeList`) for clarity.
2. **Avoid deep nesting** of views.
3. **Use `WITH SCHEMABINDING`** for indexed views.
4. **Document views** – Keep track of purpose and usage.
5. **Test performance** – Especially for indexed views.
6. **Use views for security** – Restrict column/row access.
7. **Avoid `SELECT *`** in view definitions.

---

## **11. Common Commands Summary**
```sql
-- Create view
CREATE VIEW vw_Example WITH SCHEMABINDING AS ...;

-- Alter view
ALTER VIEW vw_Example AS ...;

-- Drop view
DROP VIEW vw_Example;

-- Check view definition
SELECT OBJECT_DEFINITION(OBJECT_ID('vw_Example'));

-- Refresh view after base table changes
EXEC sp_refreshview 'vw_Example';

-- Check dependencies
SELECT * FROM sys.sql_expression_dependencies
WHERE referencing_id = OBJECT_ID('vw_Example');
```

---

## **12. Key Takeaways**
- Views are **virtual tables** defined by SELECT queries.
- **Standard views** simplify queries and enhance security.
- **Indexed views** improve performance for read-heavy workloads.
- **Ownership chains** affect security permissions.
- **DMVs and catalog views** provide metadata and runtime info.
- **Test and monitor** view performance, especially when nested or indexed.
------------

quiz test:
Which component of SQL Server is responsible for managing memory, threads, and scheduling of tasks?
c
SQLOS

Which of the following SQL Server components are responsible for ensuring transactional consistency and durability? 
b.
Transaction Manager
d.
Storage Engine

Which are valid SQL Server function types? 
b.
Scalar functions
d.
System functions

What type of function is GETDATE() and CURRENT_TIMESTAMP?
a.
Nondeterministic

Can a function call another stored procedure?
b. NO

Which is scheduling is being used by SQL Server?
d.
Cooperative

Which of the following is NOT a sub-component of SQL Server Database Engine?
a.
SQLOS

What are common drawbacks of multi-statement table-valued functions (MSTVFs)? 
a.
They often produce inaccurate cardinality estimates

Can you modify data or insert rows into database with functions?
d.
No

How is performance measured in Azure SQL
c.
Database Warehouse Units

Which of the following is true about deterministic vs nondeterministic functions? 
a.
Scalar UDFs can be either deterministic or nondeterministic
b.
Deterministic functions always return the same result for the same input 
d.
Nondeterministic functions can return different results even with the same input 

Inline table-valued functions are 100% equivalent to views?
c.
No – inline TVFs support parameterization, allowing more flexible filtering

Which protocol is being used for communication in the application layer?
c.
Tabular Data Stream (TDS)

Consider a SQL Server instance under heavy workload. Which of the following actions are performed by the Storage Engine?
c.
Managing locks and latches
d.
Writing transaction log records to disk
e.
Coordinating checkpoint operations 
f.
 Reading data pages from disk into buffer pool 