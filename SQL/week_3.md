What Is a Table?

- *Relational databases* store data in tables (relations).
  - Defined by columns (with names)
  - Can have zero or more rows

- Tables represent a type of object or entity

   - Examples: employees, purchase orders, customers, sales orders

    - Consistent naming is important

- Tables act as a security boundary

- Each row represents a single instance of the entity

  - Example: one employee, one purchase order

  - Rows have no inherent order
----------------------------------
Чуждият ключ е като връзка между две таблици.

- В една таблица има колона, която сочи към първичния ключ на друга таблица.
- Това гарантира, че данните са свързани и валидни.

Най-важните правила:

- Не може да имаш връзка към нещо, което не съществува.
- Ако в таблицата "Поръчки" имаш клиент с ID=5, то в таблицата "Клиенти" задължително трябва да има клиент с това ID.
- Не може да изтриеш нещо, към което има връзка.
- Ако има поръчки от клиент с ID=5, не можеш просто така да изтриеш този клиент. Трябва първо да решиш какво да стане с поръчките му (например да ги изтриеш заедно с него).

-----------------------------
Some tables in the **msdb** database are still useful: 
- dbo.backupset
- dbo.restorehistory
- dbo.sysjobstory


При писанеро на заявки трябва всичко да е оптимално и бързо лесно за ползване. Колкото по-актуална е една база от данни, толкова повече хора биха я изпозлвали

Може да си създадем UNIQUE  таблица, ако нямаме такава 

````
IDENTITY(1, 10) / SCOPE_IDENTITY
1
2
3
...
````
````
SEQUENCE 
//start:
//max:
1
2
3
...
````
Data Types:

- Understand the purpose of data types.
- Use exact numeric data types.
- Use approximate numeric data types.
- Use date and time data types.
- Work with unique identifiers.
- Understand when to use NULL and NOT NULL.
- Create alias data types.
- Convert data between data types.
- Work with international character data.

Типове данни - определят какъв вид информация се съхранява:

- Числа - INT (цели), DECIMAL (пари)
- Текст - VARCHAR (променлив текст)
- Дата - DATE, DATETIME
- NULL - липсваща стойност
- NOT NULL - задължително поле

*3 basic sets of data types:*
1. Systemdata types
2. Alias data types
3. Use-defined data types

Integer Types (Цели числа):

- tinyint : 0 до 255 (1 байт)
- smallint : -32,768 до 32,767 (2 байта)
- int : -2 млрд. до 2 млрд. (4 байта) - най-често използван
- bigint : много големи числа (8 байта)
- Exact Fractional Types (Точни дробни числа):
- decimal(p,s) : точни дробни числа с определена точност - добър за пари
- p - общ брой цифри
- s - брой цифри след запетая
- numeric = decimal (същото)
- money/smallmoney : за пари (4 decimal places) - стари типове

float & real - не е добра предцизност(избягва се)
datetime2
{23.10.2025} - DATE - Попринцип винаги: YYYY-MM-DD
{20:00:00} - TIME

uniqueidentifier Data Type - шанса някой да има същия unique ID клонящ към 0
NOT NULL & NULL - нямаме данни 
Create Type - sys.types

--------------------
Converting Data Between Data Types

- CAST & CONVERT
- PARSE - само за дати
- TRY_CAST - няма да обърка заявката, 
- TRY_CONVERT - 
- TRY_PARSE -

  ------------------
  UNICODE:
  - N prefix
  - Uses LEN() - дължина
  - Uses DATALENGTH() - числата of bytes
 
  ------------------------
  SCHEMA:

  - for name convention
 
    Server Name -> DB ->(dbo/mr/) Schema{owner}-> Obj.

     ---------------------

  Creating Altering Tables:
  **CREAT TABLE** statement
  **DROP TABLE**  delete table
  **ALTER TABLE** modify tables
  - Temporary Tables:
    - #prefix (Локална и видима само за нас, след това изчезва)- не прекалявай с многото създаване на нови таблици, затова почистваме -> DROP
    - ##prefix (Останалите също може да я виждат)
   


  
