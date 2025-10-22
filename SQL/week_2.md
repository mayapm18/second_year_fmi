
# 🧠 TEST Week 2

![image](https://github.com/user-attachments/assets/51c72bc6-2616-4542-bcc2-5579b3f654fb)

---

## 🖥️ SQL Server Overview

### SQLOS
- Server (най-новата версия е от **2022**)
- Релационна система за база от данни  

### Query Processor
- Отговаря за **обработката на заявки**

### SQL Server Management Studio (SSMS)
- Средата, в която ще работим

### Instances
- SQL Server components **are not always instance-aware**
- **Dev instance** → взима името на компютъра  
  - Пример: `hostname\Server1`
- **Enterprise Edition** → пълна версия, включва всичко  
- **Developer Edition** → безплатна, пълна версия на Enterprise  
- **Express Edition** → безплатна, но силно ограничена

---

## ☁️ Azure SQL

| Вид | Достъп | Характеристика |
|------|---------|----------------|
| **Azure SQL Database** | Само база | Не знаем къде се намира сървърът |
| **Azure SQL Managed Instance** | Достъп до instance | Нямаме достъп до повечето компоненти |

---

## 📚 Какво ще учим

- Таблици: `Customers`, `Orders`
- Ще ни трябва теория на множествата

**Основни понятия:**
- **SQL Server** → client-server система  
- **T-SQL** → set-based език  
- Разширение на файловете: `.sql`  
- `GO` → разделя batch-ове (не е задължителен, но подрежда кода

> ⚠️ `Execute` ≠ Debug (F5)  
> Маркирам кода, който искам да изпълня, и натискам *Execute*.

---

## 🪪 Влизане в SSMS

**Стъпки:**
1. Отвори **SQL Server Management Studio**
2. В полето **Server name** → въведи `hostname\Server1` (примерно)
3. Избери **Authentication: Windows**
4. Натисни **Connect**

> Ако си администратор — можеш да споделяш база чрез **Security → Logins → New Login**.

---

## 💬 Интервю въпроси

1. **Как може най-лесно да видим кога последно е актуализирана база?**  
   👉 От *Properties* → трябва да се напише заявка за това.

2. **В коя база се пази информация за задачи и джобове (jobs)?**  
   👉 В базата **`msdb`**

---

## 🧩 FINAL QUIZ

### SQL is Declarative
> Describe **what** you want, not **how** to do it.

---

## 🔺 SQL Command Categories (Priority Order)

| Priority | Category | Meaning | Examples |
|-----------|-----------|----------|-----------|
| 1️⃣ | **DML** | Data Manipulation Language | `SELECT`, `INSERT`, `UPDATE`, `DELETE` |
| 2️⃣ | **DDL** | Data Definition Language | `CREATE`, `ALTER`, `DROP` |
| 3️⃣ | **DCL** | Data Control Language | `GRANT`, `REVOKE`, `DENY` |

✨ Focus of this course → **DML**, especially `SELECT`

---

## 🧮 T-SQL Language Elements

| Category | Elements |
|-----------|-----------|
| **Predicates** | `ALL`, `ANY`, `BETWEEN`, `IN`, `LIKE`, `OR`, `SOME` |
| **Comparison Operators** | `=`, `<>`, `!=`, `>`, `<`, `>=`, `<=` |
| **Logical Operators** | `AND`, `OR`, `NOT` |
| **Arithmetic Operators** | `+`, `-`, `*`, `/`, `%` |
| **Concatenation** | `+` |

---

## 🧱 Basic Query Syntax

```sql
SELECT *          -- Връща всичко
FROM Customer     -- Източник на данните
WHERE <условие>;  -- Условие за филтриране
```

### В SQL има три възможни логически отговора:
- `TRUE`
- `FALSE`
- `NULL` → няма информация

---

## 🧩 Променливи

Името и типът на променливата трябва да се декларират:

```sql
DECLARE @search VARCHAR(30) = 'Match%'
```

---

## 🧮 Примери

```sql
SELECT YEAR(orderdate) + 1 AS next_year
FROM Orders;

SELECT qty * unitprice AS total_price
FROM OrderDetails;
```

---

## 💬 Коментари в SQL

**Многострочен:**
```sql
/*
  Това е коментар
*/
```

**Еднострочен:**
```sql
-- Това също е коментар
```

---

## 🏗️ Elements of a SELECT Statement

| **Element** | **Expression** | **Role** |
|--------------|----------------|----------|
| `SELECT` | `<select list>` | Кои колони да се върнат |
| `FROM` | `<table source>` | От коя таблица |
| `WHERE` | `<search condition>` | Филтриране на редове |
| `GROUP BY` | `<group by list>` | Групиране |
| `HAVING` | `<search condition>` | Филтриране на групи |
| `ORDER BY` | `<order by list>` | Подреждане на резултата |
