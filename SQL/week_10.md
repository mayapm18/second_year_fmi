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