
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

