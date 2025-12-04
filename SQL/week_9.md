## 📌 **ОСНОВНИ SQL КАТЕГОРИИ**

### 1. **DDL (Data Definition Language)**
```sql
-- Създаване на база данни
CREATE DATABASE database_name;

-- Създаване на таблица
CREATE TABLE table_name (
    column1 datatype constraints,
    column2 datatype constraints,
    ...
    PRIMARY KEY (column1),
    FOREIGN KEY (column2) REFERENCES other_table(column)
);

-- Промяна на таблица
ALTER TABLE table_name
ADD column_name datatype;

ALTER TABLE table_name
DROP COLUMN column_name;

-- Изтриване
DROP TABLE table_name;
TRUNCATE TABLE table_name;
```

### 2. **DML (Data Manipulation Language)**
```sql
-- Вмъкване на данни
INSERT INTO table_name (column1, column2)
VALUES (value1, value2);

-- Актуализация
UPDATE table_name
SET column1 = value1
WHERE condition;

-- Изтриване
DELETE FROM table_name
WHERE condition;
```

### 3. **DQL (Data Query Language)**
```sql
-- Основен SELECT
SELECT column1, column2
FROM table_name
WHERE condition
ORDER BY column1
LIMIT number;

-- SELECT с агрегатни функции
SELECT COUNT(*), AVG(column), SUM(column), MAX(column), MIN(column)
FROM table_name
GROUP BY column
HAVING condition;
```

---

## 🔑 **КЛЮЧОВИ КОНЦЕПЦИИ**

### **JOIN операции**
```sql
-- INNER JOIN
SELECT *
FROM table1
INNER JOIN table2 ON table1.id = table2.foreign_id;

-- LEFT JOIN
SELECT *
FROM table1
LEFT JOIN table2 ON table1.id = table2.foreign_id;

-- RIGHT JOIN
SELECT *
FROM table1
RIGHT JOIN table2 ON table1.id = table2.foreign_id;

-- FULL OUTER JOIN
SELECT *
FROM table1
FULL OUTER JOIN table2 ON table1.id = table2.foreign_id;

-- CROSS JOIN
SELECT *
FROM table1
CROSS JOIN table2;
```

### **ПОДЗАЯВКИ (Subqueries)**
```sql
-- В SELECT клауза
SELECT column1, (SELECT MAX(column2) FROM table2) AS max_value
FROM table1;

-- В WHERE клауза
SELECT *
FROM table1
WHERE column1 IN (SELECT column2 FROM table2 WHERE condition);

-- В FROM клауза (derived table)
SELECT *
FROM (SELECT * FROM table1 WHERE condition) AS subquery
WHERE subquery.column = value;
```

### **АГРЕГАТНИ ФУНКЦИИ**
```sql
-- Групиране
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;

-- Вложени агрегатни функции
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;
```

---

## 🏗️ **CONSTRAINTS (ОГРАНИЧЕНИЯ)**

### **Основни типове ограничения**
```sql
CREATE TABLE example (
    -- PRIMARY KEY
    id INT PRIMARY KEY,
    
    -- FOREIGN KEY
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id),
    
    -- UNIQUE
    email VARCHAR(255) UNIQUE,
    
    -- NOT NULL
    name VARCHAR(100) NOT NULL,
    
    -- CHECK
    age INT CHECK (age >= 18),
    
    -- DEFAULT
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## 📊 **СЛОЖНИ ЗАЯВКИ**

### **UNION/UNION ALL**
```sql
SELECT column1 FROM table1
UNION
SELECT column1 FROM table2;

SELECT column1 FROM table1
UNION ALL
SELECT column1 FROM table2;
```

### **CASE изрази**
```sql
SELECT 
    name,
    CASE 
        WHEN salary > 50000 THEN 'Висок'
        WHEN salary > 30000 THEN 'Среден'
        ELSE 'Нисък'
    END AS salary_category
FROM employees;
```

### **ОКОННИ ФУНКЦИИ (Window Functions)**
```sql
-- ROW_NUMBER
SELECT 
    name,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS rank
FROM employees;

-- RANK и DENSE_RANK
SELECT 
    name,
    salary,
    RANK() OVER (ORDER BY salary DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;

-- Агрегатни функции с прозорци
SELECT 
    department,
    name,
    salary,
    AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary
FROM employees;
```

---

## 🔍 **УСЛОВИЯ И ФИЛТРИРАНЕ**

### **WHERE клауза с различни оператори**
```sql
SELECT *
FROM table_name
WHERE 
    column1 = value AND
    column2 > value AND
    column3 BETWEEN value1 AND value2 AND
    column4 LIKE 'pattern%' AND
    column5 IN (value1, value2, value3) AND
    column6 IS NOT NULL;
```

### **LIKE оператор**
```sql
-- Започва с
WHERE column LIKE 'A%'

-- Завършва на
WHERE column LIKE '%Z'

-- Съдържа
WHERE column LIKE '%middle%'

-- Точно 3 символа
WHERE column LIKE '___'

-- Втори символ е 'a'
WHERE column LIKE '_a%'
```

---

## 🗃️ **ИНДЕКСИ И ОПТИМИЗАЦИЯ**

### **Създаване на индекси**
```sql
-- Прост индекс
CREATE INDEX idx_column ON table_name(column);

-- Уникален индекс
CREATE UNIQUE INDEX idx_unique_column ON table_name(column);

-- Съставен индекс
CREATE INDEX idx_multiple ON table_name(column1, column2);

-- Пълнотекстов индекс
CREATE FULLTEXT INDEX idx_fulltext ON table_name(text_column);
```

### **EXPLAIN за анализ на заявки**
```sql
EXPLAIN SELECT * FROM table_name WHERE condition;
```

---

## 🔄 **TRANSACTIONS (ТРАНЗАКЦИИ)**

```sql
-- Начало на транзакция
START TRANSACTION;

-- Операции
INSERT INTO table1 VALUES (...);
UPDATE table2 SET column = value WHERE condition;

-- Потвърждение
COMMIT;

-- Отмяна
ROLLBACK;

-- SAVEPOINT
SAVEPOINT savepoint_name;
ROLLBACK TO SAVEPOINT savepoint_name;
```

---

## 📝 **ВИДОВЕ ДАННИ (Data Types)**

### **Числени типове**
- `INT`, `SMALLINT`, `BIGINT`
- `DECIMAL(p, s)`, `NUMERIC(p, s)`
- `FLOAT`, `DOUBLE`, `REAL`

### **Символни типове**
- `CHAR(n)` - фиксирана дължина
- `VARCHAR(n)` - променлива дължина
- `TEXT` - голям текст

### **Дата и час**
- `DATE` - дата
- `TIME` - час
- `DATETIME` - дата и час
- `TIMESTAMP` - timestamp

### **Други типове**
- `BOOLEAN`/`BOOL`
- `BLOB` - бинарни данни
- `JSON` - JSON данни

---

## 🛠️ **ВАЖНИ ФУНКЦИИ**

### **Стрингови функции**
```sql
CONCAT(str1, str2)      -- Конкатенация
SUBSTRING(str, pos, len) -- Подниз
LENGTH(str)             -- Дължина
UPPER(str), LOWER(str)  -- Регистър
TRIM(str)               -- Премахване на интервали
REPLACE(str, old, new)  -- Замяна
```

### **Дата/час функции**
```sql
NOW()                   -- Текуща дата/час
CURDATE()               -- Текуща дата
CURTIME()               -- Текущ час
DATE_ADD(date, INTERVAL) -- Добавяне
DATEDIFF(date1, date2)  -- Разлика в дни
EXTRACT(part FROM date) -- Извличане на част
```

### **Математически функции**
```sql
ABS(x)                  -- Абсолютна стойност
ROUND(x, decimals)      -- Закръгляне
CEIL(x), FLOOR(x)       -- Закръгляне нагоре/надолу
MOD(x, y)              -- Остатък
POWER(x, y)            -- Степенуване
SQRT(x)                -- Корен квадратен
```

---

## 📋 **ЧЕСТО СРЕЩАНИ ГРЕШКИ И РЕШЕНИЯ**

1. **Забравена GROUP BY клауза** при използване на агрегатни функции
2. **Използване на HAVING вместо WHERE** - WHERE филтрира преди групиране, HAVING след
3. **Липса на JOIN условие** - води до CROSS JOIN
4. **SQL инжекция** - винаги използвайте параметризирани заявки
5. **Липса на индекси** на често търсени колони

---

## 🎯 **НАЙ-ВАЖНИТЕ НЕЩА ЗА ЗАПОМНЯНЕ**

1. **SELECT ред на клаузите**: 
   ```
   SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT
   ```

2. **Изпълнение на заявки**:
   ```
   FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
   ```

3. **JOIN типове**:
   - INNER JOIN: само съвпадащи редове
   - LEFT JOIN: всички редове от лявата таблица + съвпадащи от дясната
   - RIGHT JOIN: обратното на LEFT JOIN
   - FULL JOIN: всички редове от двете таблици

4. **Индексирайте**:
   - PRIMARY KEY колони
   - FOREIGN KEY колони
   - Колони в WHERE клаузи
   - Колони в JOIN условия
   - Колони в ORDER BY

5. **Нормализация на базите данни** до 3NF като минимум

