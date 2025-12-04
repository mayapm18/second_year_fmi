
# Views

## Какво е view
View = записан SELECT, който се държи като виртуална таблица (не съхранява данни).

## Защо се използва
- Скрива ненужни колони (сигурност).  
- Показва само нужните редове (филтриране).  
- Улеснява заявки — сложният SQL е записан на едно място.

## Как се създава
```sql
CREATE VIEW ViewName AS
SELECT Column1, Column2
FROM TableName;
````

## Обновяеми views

Може да UPDATE/INSERT/DELETE през view, ако няма:

* агрегатни функции
* DISTINCT
* GROUP BY / HAVING
* UNION

## WITH ENCRYPTION

Скрива дефиницията на view. Не защитава данните — само кодът става невидим.

## Ownership chain (права)

View работи без допълнителни права само ако собственикът му е същият като на таблиците.
Ако “chain” е счупен → трябва да дадеш права или да смениш owner.

## Nested views

View може да използва друго view. Работи, но може да стане бавно и сложно. Ползвай умерено.

---

## Cheatsheet

* View = записан SELECT
* Създаване → `CREATE VIEW ... AS SELECT`
* Updateable само при “прости” SELECT-и
* `WITH ENCRYPTION` = скриване на кода
* Ownership chain = важен за правата

```

DML - good
DDL -no

------------

# Module 9 — Functions 

## Какво е функция
Функция = SQL обект, който връща стойност. Може да е скаларна (една стойност) или таблична (таблица).

## Видове функции
- **Scalar function** – връща единична стойност (число, текст).  
- **Inline table-valued function (iTVF)** – връща таблица чрез един SELECT.  
- **Multi-statement table-valued function (mTVF)** – връща таблица, изградена в няколко стъпки.

## Защо се използват
- Повторно използване на логика.  
- По-чист и кратък код.  
- Може да се вграждат в SELECT, WHERE, JOIN.

## Как се създава (пример)
### Scalar
```sql
CREATE FUNCTION dbo.GetFullName(@First NVARCHAR(50), @Last NVARCHAR(50))
RETURNS NVARCHAR(100)
AS
BEGIN
   RETURN @First + ' ' + @Last;
END;
````

### Inline TVF

```sql
CREATE FUNCTION dbo.ActiveEmployees()
RETURNS TABLE
AS
RETURN (SELECT * FROM Employees WHERE Active = 1);
```

## Ограничения

* Функциите **не могат** да променят данни (няма INSERT/UPDATE/DELETE).
* Нямат транзакции.
* Scalar функции могат да са бавни при много редове.

## Основни разлики (много важно)

* Scalar → по-бавни, връщат 1 стойност.
* Inline TVF → най-бързи, оптимизаторът ги третира като вграден SELECT.
* Multi-statement TVF → по-бавни, заради временната таблица вътре.

## Cheatsheet

* Scalar: `RETURNS dataType`
* Inline: `RETURNS TABLE AS RETURN (SELECT ...)`
* Multi-statement: `RETURNS @TableVar TABLE (...)`

```



QUiz:

What are the benefits of Stored Procedures? 
a.
Can enhance the security of an application
b.
Can improve performance
c.
Create once, but call many times and from many applications

What is true about the stored procedures? 
a.
Can have output parameters
b.
Can be created in managed code or Transact-SQL
d.
Can have input parameters

What happens when you update a view?
a.
Base table data changes

Parameter sniffing can cause:
c.
A query plan optimized for one value to perform poorly for others

What is the benefit of parameters in stored procedures?
b.
They allow dynamic input values

What is a view? 
a.
A view is a stored query expression
c.
A select query from one or multiple tables
d.
A virtual table that combines or filter other tables

Which of the following is a limitation of a view in SQL Server?
d.
A view cannot have an ORDER BY clause unless it is used with TOP.

What is the purpose of a view in SQL Server?
d.
To present relevant information to users and hide complexity

What is required for creating an indexed view?
c.
The view must be created WITH SCHEMABINDING

Which statement is valid for stored procedures?
c.
Stored procedures can modify data but not schema.

What is true about altering a stored procedure?
c.
ALTER PROCEDURE keeps permissions and updates the logic

Indexed view improves 
a.
Execution of SELECT queries with aggregation
d.
Read performance