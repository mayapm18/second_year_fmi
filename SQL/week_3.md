
# What Is a Table?

- *Relational databases* store data in tables (relations).
  - Defined by columns (with names)
  - Can have zero or more rows

- Tables represent a type of object or entity:
  - Examples: `employees`, `purchase orders`, `customers`, `sales orders`
  - Consistent naming is important

- Tables act as a **security boundary**
- Each row represents a **single instance** of the entity:
  - Example: one employee, one purchase order
  - Rows have **no inherent order**

---

## Чужд ключ (Foreign Key)

Чуждият ключ е връзка между две таблици.

- В една таблица има колона, която сочи към първичния ключ на друга таблица.  
- Това гарантира, че данните са свързани и валидни.

### Най-важните правила:

- Не може да имаш връзка към нещо, което **не съществува**.  
- Ако в таблицата **"Поръчки"** имаш клиент с `ID=5`, то в таблицата **"Клиенти"** задължително трябва да има клиент с това `ID`.  
- Не може да изтриеш нещо, към което има връзка.  
- Ако има поръчки от клиент с `ID=5`, не можеш просто така да изтриеш този клиент — първо реши какво да стане с поръчките му.

---

## Useful Tables in **msdb** Database

- `dbo.backupset`  
- `dbo.restorehistory`  
- `dbo.sysjobstory`

---

## Query Writing Principles

При писане на заявки трябва всичко да е **оптимално**, **бързо** и **лесно за ползване**.  
Колкото по-актуална е една база от данни, толкова повече хора биха я използвали.

---

## UNIQUE Tables and Identity

Може да създадем **UNIQUE** таблица, ако нямаме такава:

````sql
IDENTITY(1, 10) / SCOPE_IDENTITY
1
2
3
...
````
````sql
SEQUENCE 
//start:
//max:
1
2
3
...
````

# Data Types

## Overview

- Understand the purpose of data types  
- Use exact numeric data types  
- Use approximate numeric data types  
- Use date and time data types  
- Work with unique identifiers  
- Understand when to use `NULL` and `NOT NULL`  
- Create alias data types  
- Convert data between data types  
- Work with international character data  

---

## Типове данни

Определят какъв вид информация се съхранява:

- **Числа** – `INT` (цели), `DECIMAL` (пари)  
- **Текст** – `VARCHAR` (променлив текст)  
- **Дата** – `DATE`, `DATETIME`  
- **NULL** – липсваща стойност  
- **NOT NULL** – задължително поле  

---

## 3 Basic Sets of Data Types

1. **System data types**  
2. **Alias data types**  
3. **User-defined data types**

---

## Integer Types (Цели числа)

| Type       | Range                           | Size     | Description                  |
|-------------|---------------------------------|----------|------------------------------|
| `tinyint`   | 0 до 255                       | 1 байт   | Много малки числа            |
| `smallint`  | -32,768 до 32,767              | 2 байта  | Малки цели числа             |
| `int`       | ~ -2 млрд. до +2 млрд.         | 4 байта  | Най-често използван тип      |
| `bigint`    | Много големи числа             | 8 байта  | За големи обеми от данни     |

---

## Exact Fractional Types (Точни дробни числа)

- `decimal(p,s)` – точни дробни числа с определена точност (подходящ за пари)  
  - `p` – общ брой цифри  
  - `s` – брой цифри след запетая  
- `numeric` = `decimal` (идентични)  
- `money` / `smallmoney` – за пари (4 десетични знака, по-стари типове)  

> ⚠️ **`float`** и **`real`** – имат неточности → избягват се при финансови изчисления.

---

## Date and Time

- `{23.10.2025}` → `DATE` → винаги във формат **`YYYY-MM-DD`**  
- `{20:00:00}` → `TIME`  
- `datetime2` → по-прецизен тип за дати и време  

---

## Unique Identifier

- `uniqueidentifier` – шанс някой да има същия ID клони към **нула**  
- `NOT NULL` & `NULL` – показват наличие или липса на данни  
- `CREATE TYPE` → дефиниране на потребителски тип (`sys.types`)

---

# Converting Data Between Data Types

| Function      | Description                              |
|----------------|------------------------------------------|
| `CAST()`       | Преобразува между типове                 |
| `CONVERT()`    | Също преобразува, но позволява формат    |
| `PARSE()`      | Само за дати                             |
| `TRY_CAST()`   | Пробва да преобразува без грешка         |
| `TRY_CONVERT()`| Също безопасно преобразуване             |
| `TRY_PARSE()`  | Безопасно преобразуване на дата          |

---

# UNICODE

- Използва **`N` префикс** → `N'текст'`  
- `LEN()` – връща дължината на текста  
- `DATALENGTH()` – връща броя байтове  

---

# SCHEMA

Използва се за именуване и организация на обекти:

- Server Name → Database → (dbo / mr / etc.) → Schema {owner} → Object


---

# Creating and Altering Tables

### Основни команди:
- `CREATE TABLE` – създава таблица  
- `DROP TABLE` – изтрива таблица  
- `ALTER TABLE` – променя таблица  

### Temporary Tables

| Prefix  | Видимост | Бележка |
|----------|-----------|----------|
| `#`      | Локална (само за текущата сесия) | Изчезва след приключване |
| `##`     | Глобална (достъпна за всички) | Внимавай с натрупване |

> 💡 **Важно:** не прекалявай с временно създаване на таблици – използвай `DROP` за почистване.

---

# SQL Query Clauses

| Clause     | Expression         |
|-------------|--------------------|
| `SELECT`    | `<select list>`    |
| `FROM`      | `<table or view>`  |
| `WHERE`     | `<search condition>` |
| `GROUP BY`  | `<group by list>`  |
| `ORDER BY`  | `<order by list>`  |

---

# Query Examples

````sql
SELECT *
FROM Sales.Customers; -- понякога ; е задължително
````

- Уникалност = DISTINCT
- Премахване на редовете след: WHERE, HAVING, GROUP BY

  Calculations in the SELECT Clause:

| Operator | Description           |
|----------|-----------------------|
| +        | Add or concatenate    |
| -        | Subtract              |
| *        | Multiply              |
| /        | Divide                |
| %        | Modulo                |

# Logical Processing Order & Aliases

- FROM, WHERE, HAVING се обработват преди SELECT

- Алиаси, създадени в SELECT, са видими само за ORDER BY

- Могат да се използват повторно в заявката


# CASE

*Simple CASE*
- Работи с фиксирана колона
- Проверява за точно съвпадение

````sql
CASE column_name
    WHEN 'A' THEN 'Group 1'
    WHEN 'B' THEN 'Group 2'
    ELSE 'Other'
END
````

*Search CASE*
- Позволява повече условия / категории

````sql
CASE 
    WHEN amount < 100 THEN 'Low'
    WHEN amount BETWEEN 100 AND 500 THEN 'Medium'
    WHEN amount > 500 THEN 'High'
    ELSE 'Unknown'
END
````
