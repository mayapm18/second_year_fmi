# TEST week 2

<img width="960" height="720" alt="image" src="https://github.com/user-attachments/assets/51c72bc6-2616-4542-bcc2-5579b3f654fb" />

SQLOS - server (най-новата версия е от 2022)
-релационна система за база от данни 

QueryProcesser- заявки

SQL Server Management Studio - къде ще работим

SQL Server components are not always instantce-aware 

Dev instance - Взима името на компютъра

DEV: hostname\Server1 - задаваме име

Enterprise - има всичко

Безплатните версии са developer(пълнната версия на enterprise) & express(много е орязано)

Аzure SQL Datebase - единична база и не знаем къде се намира сървъра

👇

Azure SQL Managed Instance - имаме достъп до instance, но нямаме достъп до повечето ?компоненти?

------------------

## С какво ще се занимаваме:

- table : Customers
- table : Orders

Ще ни трябва теория на множествата. 
- SQL Server - client server
- T-SQL : set-based language, ".sql", GO keyword separates batches( то може да си работи и без GO, но за да е по-подредено, го ползваме)


!Execute не е Debug (F5)
// Маркирам кода който искам да пусна и пускам Execute

Open: SSMS ->(инструкции как да влезна, ако може да дообавиш) 

Ако съм администартор мога да споделям база от Security 

За интервюта: 
1. Как може най лесно последно да видиш кога се е актуаллизирала някоя база?

Отговор: Трябва да си напишем заявка, от Propaties


2. За коя база може да работи (нещо си ако може да помогнеш) 

Отговор: MSDB

---------------
!!FINAL QUIZ!!

SQL is declarative: 
-decribe what yo want, not the individual steps
--------------

### Priority: DML → DDL → DCL
## DML
-Data Manipulation Language

-SELECT, INSERT, UPDATE, DELETE

-✨Focus of this course - especially SELECT

## DDL
-Data Definition Language

CREATE, ALTER, DROP

##DCL 
-Data Control Language

-GRANT, REVOKE, DENY

---------------

### T-SQL Language Elements: Predicates and Operators

| Category | Elements |
|----------|----------|
| **Predicates** | ALL, ANY, BETWEEN, IN, LIKE, OR, SOME |
| **Comparison Operators** | =, <>, !=, >, <, >=, <= |
| **Logical Operators** | AND, OR, NOT |
| **Arithmetic Operators** | +, -, *, /, % |
| **Concatenation** | + |

```
SELECT* - Връща всичко което искаме
FROM - Customor
WHERE (условие)
```
Във SQL има три опции за отговор: 
- True
- False
- NUll (няма информация, не знаем дали има информация)

-----------
Името на променливата и тиа от данни трябва да декларираме
````
DECLARE @serch varchar(30) = 'Match%'
````

````
SELECT YEAR(ordedate) + 1 ....
SELECT qty* unitprince ...
````
-----------
-Mожем да коментираме в SQL: 

1 начин :
````
 /*
    hahahhahahaha
 */

````
2 начин:
````
--hahahhah
````
--------------------
Това е подредбата в която пишем SQL Server:
# Elements of a SELECT Statement

| **Element** | **Expression**        | **Role**                                  |
|--------------|----------------------|-------------------------------------------|
| SELECT       | `<select list>`      | Defines which columns to return           |
| FROM         | `<table source>`     | Defines table(s) to query                 |
| WHERE        | `<search condition>` | Filters returned data using a predicate   |
| GROUP BY     | `<group by list>`    | Arranges rows by groups                   |
| HAVING       | `<search condition>` | Filters groups by a predicate             |
| ORDER BY     | `<order by list>`    | Sorts the results                         |


