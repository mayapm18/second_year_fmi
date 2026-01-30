
## **1. SQL Server Architecture & Core Concepts**
- **SQL Server is an RDBMS** using the **relational model**
- Data is organized in **tables** (one subject per table)
- **Joins** connect related tables (e.g., Customers ↔ Orders)
- **Five System Databases:**
  - `master` - System configuration
  - `model` - Template for new databases
  - `msdb` - SQL Server Agent jobs/alerts
  - `tempdb` - Temporary storage (deleted on restart)
  - `resource` - Hidden read-only system objects

## **2. Client-Server Model**
- **Client** (SSMS/Visual Studio) ≠ **Server** (Database Engine)
- **Client never directly accesses database files** - Server handles all file I/O
- Can be on same machine or different machines
- Use **four-part names** for cross-server references:  
  `Server.Database.Schema.Object`
- For remote servers: Create **linked servers** with `sp_addlinkedserver`

## **3. TSQL Sample Database**
- Used for learning T-SQL queries
- **Schemas** = Logical containers for tables/views
- **Key tables:**
  - `Sales.Orders` - Order headers
  - `Sales.OrderDetails` - Line items
  - `Sales.Customers` - Customer info
  - `HR.Employees` - Employee info

## **4. T-SQL Language Characteristics**
- **Set-based language** (processes data in sets, not row-by-row)
- Scripts use **.sql** extension
- **Batches** separated by `GO` keyword
- Must complete one batch before starting next (e.g., CREATE TABLE before INSERT)

## **5. SQL Server Editions (Know Main 4)**
1. **Enterprise** - All features, high availability
2. **Standard** - Core features, 16 processor cores limit
3. **Business Intelligence** - Full BI features, 16 core limit
4. **Express** - FREE, limited: 4 cores, 1GB RAM, 10GB DB size

## **6. SSMS (SQL Server Management Studio)**
- Primary tool for managing SQL Server
- **Object Explorer** - Hierarchical view of server objects
- **Solution Explorer** - Organizes scripts into:
  - **Solutions** (.ssmssln) - Contain projects
  - **Projects** (.ssmssqlproj) - Contain scripts
  - **Scripts** (.sql) - T-SQL code files
- **To execute queries:** F5, Ctrl+E, or Execute button
- **Results display options:** Grid (Ctrl+D), Text (Ctrl+T), File (Ctrl+Shift+F)
- **Connect requires:** Instance name, Database name, Authentication

## **7. Connection Format**
- Default instance: `hostname`
- Named instance: `hostname\instancename`
- No database specified = connects to user's default or `master`

---

### **Most Likely Quiz Questions:**
1. **"Name the 5 system databases and their purposes"**
2. **"Which edition is free but limited to 4 cores and 1GB RAM?"** (Express)
3. **"True/False: The client application directly reads database files"** (False)
4. **"What separates batches in T-SQL scripts?"** (GO keyword)
5. **"What is the four-part name format?"** (Server.Database.Schema.Object)
6. **"Which system database is recreated on restart?"** (tempdb)
7. **"How do you reference a table in another server?"** (Linked server)

**Study Priority:** System databases, Editions, Client-server separation, Four-part naming, TSQL table purposes.

-----------------------
### **1. SQL Server Basics**
- **SQL Server is an RDBMS** (Relational Database Management System).
- Data is stored in **tables** (one table per subject).
- **Joins** connect data from multiple tables.

### **2. System Databases (MUST KNOW)**
1. **master** → System configuration & info
2. **model** → Template for new databases
3. **msdb** → SQL Server Agent jobs/alerts
4. **tempdb** → Temporary storage (deleted on restart)
5. **resource** → Hidden system objects

### **3. TSQL Database Structure**
- **Schemas** = Logical containers for tables/views
- **Key tables:**
  - `Sales.Orders` → Order headers (customer, date)
  - `Sales.OrderDetails` → Line items (products, prices)
  - `Sales.Customers` → Customer info
  - `HR.Employees` → Employee info

### **4. Client-Server Architecture**
- **Client** (SSMS/Visual Studio) and **Server** (Database Engine) are separate.
- **Client never touches database files directly**.
- Use **four-part names** for cross-server queries:  
  `Server.Database.Schema.Object`  
  Example: `MIA-SQL.sales.dbo.orders`

### **5. Remote Connections**
- Use **linked servers** for remote connections.
- Created with:  
  `EXEC sp_addlinkedserver @server = 'ServerName'`

---

### **Quick Memory Aid:**
**5 System DBs:** Master, Model, MSDB, TempDB, Resource  
**4-Part Name:** Server.Database.Schema.Object  
**TSQL Tables:** Orders (headers), OrderDetails (items), Customers, Employees  
**Key Fact:** Client never accesses files directly—only via server.


# finish

-------------


### **Core Concepts**
*   **SQL Server** is a **Relational Database Management System (RDBMS)**.
*   It uses the **relational model**, organizing data into **tables**.
*   Each table holds information about **one specific thing** (e.g., Customers, Orders).
*   Separating data into different tables promotes **efficiency and reduces redundancy**.

### **Key Operation: Joining Tables**
*   The primary way to combine data from separate tables is by using a **JOIN** in a query.
*   Joins are necessary because related data (e.g., a Customer and their Orders) is stored in different tables.
*   Complex queries often require joining **several tables** together.

### **The Five System Databases (CRITICAL for Quiz)**
1.  **master**: The **system configuration** database. Tracks all system-level information.
2.  **model**: Acts as a **template**. Any changes made to `model` are applied to **new databases**.
3.  **msdb**: Used by **SQL Server Agent** for scheduling **jobs and alerts**.
4.  **tempdb**: A **temporary workspace** for processes. It is **dropped and recreated** every time SQL Server restarts, so nothing here is permanent.
5.  **resource**: A **hidden, read-only** database that contains system objects.

### **Database Contents & Access**
*   Databases contain **data** and **objects** (tables, views, stored procedures, user accounts).
*   To work with a database, you must first **connect** to it.
*   Access requires two things:
    1.  Security credentials to **log on to SQL Server**.
    2.  A database account with the necessary **permissions**.
----------

### **Key Facts about the TSQL Database**
*   **Purpose:** It is a small, **sample database** designed for learning **Transact-SQL (T-SQL) queries**.
*   **Theme:** It represents a **simple sales application** for a small business.

---

### **Database Objects in TSQL**
1.  **Schemas:** These are **logical containers** used to group related **tables and views**.
2.  **Tables:** The core objects that store data. They are **related to each other** primarily through **Foreign Key constraints**.
3.  **Views:** Objects that **display information from more than one table**, simplifying queries.

---

### **Main Tables & Their Schemas**
**(Notice the `Schema.Table` naming convention, e.g., `Sales.Orders`)**

| Table Name (with Schema) | What It Stores |
| :--- | :--- |
| **`Sales.Orders`** | **Invoice header** information. Contains: order ID, customer ID, order date. |
| **`Sales.OrderDetails`** | **Transaction details** for each order. Contains: product ID, quantity, price per item. |
| **`Sales.Customers`** | **Customer information**. Contains: company name, contact details. |
| **`HR.Employees`** | **Employee information**. |

---

### **How the Tables Relate (Critical for Queries)**
*   A typical sales query would **JOIN** these tables:
    *   **`Sales.Orders`** is the central table linking customers to order details.
    *   **`Sales.Customers`** provides the customer information for each order.
    *   **`Sales.OrderDetails`** lists the specific items purchased in each order.
*   **`HR.Employees`** might be joined to show which salesperson handled the order (if that column exists).

----------
