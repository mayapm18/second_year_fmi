## *The most important things about SQL*

[LeetCode link](https://leetcode.com/studyplan/top-sql-50/)

[YouTube](https://www.youtube.com/watch?v=el_dbLPcXsI&list=PLi01XoE8jYohv6KlFfGXTZwjjZtg88VMz&index=6)

```bash
SELECT -- Кои колони искаме да видим
FROM   -- От коя таблица
WHERE  -- Условие за филтриране на редове
GROUP BY -- Групиране
HAVING -- Филтриране на групи
ORDER BY -- Сортиране на крайния резултат
```

SQL USING Clause
````dash
SELECT column_list
FROM table1
JOIN table2
USING (common_column);
````
------------
```bash
DISTINCT - remove duplicate
ASC = ascending order
````

- Оператори за сравнение: =, <> (или !=), >, <, >=, <=.

- Логически оператори: AND, OR, NOT.

- Оператори за работа с множества: IN, BETWEEN, LIKE (с wildcards: % за множество символи, _ за един символ).
**Пример:**
```bash
  -- Намира всички имена, които започват с "Mar"
WHERE Name LIKE 'Mar%' -- "Maria", "Martin", "Mar"

-- Намира всички имена, които завършват на "son"
WHERE Name LIKE '%son' -- "Johnson", "Jackson", "Wilson"

-- Намира всички имена, които съдържат "ana"
WHERE Name LIKE '%ana%' -- "Ana", "Diana", "Banana"
```
<img width="1080" height="1471" alt="image" src="https://github.com/user-attachments/assets/033e76ef-5f35-4462-9f13-fddf40b3a31f" />

# Типове данни в SQL Server

## CHAR vs VARCHAR
### CHAR(n)
- **Фиксирана дължина**
- Винаги заема **n** на брой символа
- Ако данните са по-кратки, се допълва с празни пространства (spaces)
- **Пример:** `CHAR(5)`
  - 'Hi' става 'Hi___' (3 space-а)
  - Заема винаги 5 байта
### VARCHAR(n)
- **Променлива дължина**
- Заема само колкото реално са данните
- Не се допълва с празни пространства
- **Пример:** `VARCHAR(5)`
  - 'Hi' остава 'Hi'
  - Заема само 2 байта

## Други важни типове
### INT
- Цели числа
- **Пример:** 1, -5, 1000
### DECIMAL(p,s)
- Десетични числа
- **p** - общ брой цифри (precision)
- **s** - брой цифри след десетичната запетая (scale)
- **Пример:** `DECIMAL(5,2)`
  - 123.45 - ✅ валидно
  - 1234.5 - ❌ невалидно (надвишава общия брой цифри)
### DATE
- Само дата (без час)
- **Формат:** 'YYYY-MM-DD'
- **Пример:** '2024-01-15'
### DATETIME
- Дата + час
- **Формат:** 'YYYY-MM-DD HH:MI:SS'
- **Пример:** '2024-01-15 14:30:25'
