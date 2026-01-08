v <- c(10, 20, 30)           # Вектор: 10 20 30
v <- c("a", "b", "c")        # Вектор: "a" "b" "c"
v <- c(TRUE, FALSE, TRUE)    # Логически вектор

1:5      # 1 2 3 4 5
10:6     # 10 9 8 7 6
-2:2     # -2 -1 0 1 2

x <- c(10, 20, 30, 40, 50)
x[3]      # 30 (трети елемент)
x[1]      # 10 (първи елемент)

x <- c(10, 20, 30, 40, 50)
x[-3]     # 10 20 40 50 (без трети елемент)
x[-c(1,3)] # 20 40 50 (без първи и трети)
x[1:4]    # 10 20 30 40
x[c(1, 3, 5)]  # 10 30 50

x <- c(-2, 5, -1, 10, 3)
x[x > 0]       # 5 10 3 (само положителните)

x <- c(1, 3, 5, 7, 2, 4)
x[x > 2 & x < 6]  # 3 5 4 (между 2 и 6)

m <- matrix(1:12, nrow = 3, ncol = 4)  # 3x4 матрица
m <- matrix(1:6, nrow = 2, byrow = TRUE)  # Попълва по редове
m[2, 3]    # Елементът на 2-ри ред, 3-та колона
m[2, ]     # Целият 2-ри ред
m[, 3]     # Цялата 3-та колона

x <- c(1, 2, 3, 4, 5)
str(x)     # num [1:5] 1 2 3 4 5

x <- c(5, 2, 8, 1, 3)
sort(x)    # 1 2 3 5 8
sort(x, decreasing = TRUE)  # 8 5 3 2 1

x <- c(50, 20, 40, 10, 30)
order(x)   # 4 2 5 3 1 (индексите в сортиран ред)
x[order(x)] # 10 20 30 40 50 (сортиран вектор)

max(c(1, 5, 3, 9))   # 9
min(c(1, 5, 3, 9))   # 1

x <- c(10, 50, 30, 80, 20)
which.max(x)  # 4 (80 е на 4-та позиция)
which.min(x)  # 1 (10 е на 1-ва позиция)

L <- c(TRUE, FALSE, TRUE, FALSE, TRUE)
which(L)     # 1 3 5

x <- c(-2, 5, -1, 10, -3)
which(x > 0)  # 2 4 (5 и 10 са на позиции 2 и 4)

install.packages("ggplot2")  # Инсталира ggplot2 от CRAN
install.packages(c("dplyr", "tidyr"))  # Инсталира няколко пакета

library(ggplot2)    # Зарежда ggplot2 за използване
library(dplyr)      # Зарежда dplyr
# или
require(ggplot2)    # Алтернативен начин

# ФАКТОРИ (CATEGORICAL VARIABLES)
# =================================

# 1. Създаване на фактор със специфични нива
# -----------------------------------------
d <- c("ниско", "високо", "ниско", "средно", "високо")
L <- c("ниско", "средно", "високо")  # Подредба на нивата
x <- factor(d, levels = L)           # Създава фактор x с нива L от данни d
# x: [1] ниско високо ниско средно високо
# Levels: ниско средно високо

# 2. Вземане на нивата на фактор
# ------------------------------
levels(x)  # Връща нивата на категорийната променлива x
# Резултат: [1] "ниско"  "средно" "високо"

# 3. Промяна на нивата на фактор
# ------------------------------
levels(x) <- c("Low", "Medium", "High")  # Променя нивата на x
# x: [1] Low High Low Medium High
# Levels: Low Medium High

# ТАБЛИЦИ И ЧЕСТОТИ
# =================

# 4. Създаване на честотна таблица за един фактор
# -----------------------------------------------
color <- factor(c("червен", "син", "червен", "зелен", "син", "син"))
t <- table(color)  # Връща честотна таблица
# Резултат:
# color
# червен   зелен     син 
#      2       1       3

# 5. Създаване на таблица за два фактора
# --------------------------------------
gender <- factor(c("M", "F", "M", "F", "M", "M"))
preference <- factor(c("A", "B", "A", "A", "B", "B"))
t2 <- table(gender, preference)  # Връща честотите на всички комбинации
# Резултат:
#     preference
# gender A B
#      F 1 1
#      M 2 2

# ВЕРОЯТНОСТИ
# ===========

# 6. Преобразуване в таблица с вероятности
# ----------------------------------------
prop.table(t)  # Преобразува честотна таблица в таблица с вероятности
# Резултат:
#   червен     зелен       син 
# 0.3333333 0.1666667 0.5000000

# 7. Условни вероятности по редове (сума във всеки ред = 1)
# --------------------------------------------------------
prop.table(t2, 1)  # Условни вероятности по редове
# Резултат:
#     preference
# gender   A   B
#      F 0.5 0.5
#      M 0.5 0.5

# 8. Условни вероятности по колони (сума във всяка колона = 1)
# ------------------------------------------------------------
prop.table(t2, 2)  # Условни вероятности по колони
# Резултат:
#     preference
# gender         A         B
#      F 0.3333333 0.3333333
#      M 0.6666667 0.6666667

# ВИЗУАЛИЗАЦИЯ
# ============

# 9. Кръгова диаграма (pie chart)
# --------------------------------
pie(t, 
    main = "Разпределение на цветовете",
    col = c("red", "green", "blue"))

# 10. Стълбова диаграма (bar plot)
# --------------------------------
barplot(t,
        main = "Честота на цветовете",
        xlab = "Цвят",
        ylab = "Брой",
        col = "lightblue",
        border = "darkblue")

# ПЪЛЕН ПРИМЕР ЗА РАБОТА С ФАКТОРИ И ТАБЛИЦИ
# ===========================================

# Създаване на данни
grades <- c("A", "B", "C", "A", "B", "A", "C", "B")
subject <- c("Математика", "Физика", "Математика", 
             "Физика", "Химия", "Химия", "Математика", "Физика")

# Създаване на фактори с подредени нива
grade_factor <- factor(grades, levels = c("C", "B", "A"))
subject_factor <- factor(subject)

# Преглед на нивата
cat("Нива на оценките:", levels(grade_factor), "\n")
cat("Нива на предметите:", levels(subject_factor), "\n")

# Създаване на таблица
joint_table <- table(grade_factor, subject_factor)
cat("\nСъвместна таблица:\n")
print(joint_table)

# Различни видове вероятности
cat("\nОбщи вероятности:\n")
print(prop.table(joint_table))

cat("\nУсловни вероятности по оценки:\n")
print(prop.table(joint_table, 1))

cat("\nУсловни вероятности по предмети:\n")
print(prop.table(joint_table, 2))

# Визуализация
par(mfrow = c(2, 2))  # Създава 2x2 решетка за графики

# 1. Кръгова диаграма за оценките
pie(table(grade_factor), 
    main = "Разпределение на оценките",
    col = rainbow(length(levels(grade_factor))))

# 2. Стълбова диаграма за предметите
barplot(table(subject_factor),
        main = "Брой по предмети",
        xlab = "Предмет",
        ylab = "Брой",
        col = "lightgreen")

# 3. Съвместна стълбова диаграма
barplot(joint_table,
        main = "Оценки по предмети",
        xlab = "Предмет",
        ylab = "Брой",
        col = c("red", "yellow", "green"),
        legend.text = levels(grade_factor),
        beside = TRUE)

# 4. Heatmap (топлинна карта)
image(1:ncol(joint_table), 1:nrow(joint_table),
      t(joint_table[nrow(joint_table):1, ]),
      col = heat.colors(12),
      main = "Топлинна карта",
      xlab = "Предмет", ylab = "Оценка",
      axes = FALSE)
axis(1, at = 1:ncol(joint_table), labels = colnames(joint_table))
axis(2, at = 1:nrow(joint_table), labels = rev(rownames(joint_table)))

# Връщане към нормално графично устройство
par(mfrow = c(1, 1))

# ДОПЪЛНИТЕЛНИ ПРИМЕРИ
# ===================

# Пример с промяна на нивата
survey_data <- factor(c("Съгласен", "Несъгласен", "Без мнение", "Съгласен"))
cat("\nОригинални данни от анкета:\n")
print(table(survey_data))

# Промяна на нивата
levels(survey_data) <- c("Agree", "Disagree", "Neutral")
cat("\nДанни след промяна на нивата:\n")
print(table(survey_data))

# Пример с пропуснати стойности
data_with_na <- factor(c("A", "B", NA, "A", "C", NA, "B"))
cat("\nТаблица с пропуснати стойности:\n")
print(table(data_with_na, useNA = "ifany"))

# Пример: Изчисляване на проценти
freq_table <- table(color)
percent_table <- prop.table(freq_table) * 100
cat("\nПроцентно разпределение:\n")
print(percent_table)

# Запиши таблицата във файл
write.csv(joint_table, "grades_table.csv", row.names = TRUE)
cat("\nТаблицата е записана във файл 'grades_table.csv'\n")

# Прочети таблица от файл
read_table <- read.csv("grades_table.csv", row.names = 1)
cat("\nПрочетена таблица от файл:\n")
print(read_table)


# ОПИСАТЕЛНА СТАТИСТИКА В R
# =========================

# 1. mean(x) - средна стойност на x
x <- c(10, 20, 30, 40, 50)
mean(x)      # 30

# 2. var(x) - дисперсия на x
var(x)       # 250

# 3. sd(x) - стандартното отклонение на x
sd(x)        # 15.81139

# 4. quantile(x) - пресмята квартилите на x
quantile(x)  # 0%  25%  50%  75% 100% 
             # 10   20   30   40   50

# 5. quantile(x, α) - пресмята α квантил на x
quantile(x, 0.9)  # 90-ти квантил: 46

# 6. summary(x) - пресмята средната стойност и квартилите на x
summary(x)   # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
             # 10.0    20.0    30.0    30.0    40.0    50.0

# 7. density(x) - връща плътността на x
set.seed(123)
normal_data <- rnorm(100, mean = 50, sd = 10)
density(normal_data)  # Обект с плътност

# 8. boxplot(x) - построява боксплот по данните x
boxplot(normal_data)

# 9. hist(x) - построява хистограма по данните x
hist(normal_data)

# 10. plot() - чертае графика
plot(1:10, 1:10, type = "l")

# 11. lines() - добавя линия/крива към вече начертана графика
lines(1:10, sin(1:10))

# 12. split.screen() - разделя полето за чертаене на части
split.screen(c(2, 2))

# 13. screen() - избира част, в която да се чертае
screen(1)
plot(1:10, 1:10)

# 14. close.screen(all.screens = TRUE) - затваря всички разделения
close.screen(all.screens = TRUE)

# ПРИМЕРИ С ПЪЛНИ КОДОВЕ
# ======================

# Пример 1: Пълна статистическа анализа
data <- c(23, 45, 67, 89, 34, 56, 78, 12, 90, 43)

# Основни статистики
cat("Средна стойност:", mean(data), "\n")
cat("Медиана:", median(data), "\n")
cat("Дисперсия:", var(data), "\n")
cat("Стандартно отклонение:", sd(data), "\n")
cat("Минимум:", min(data), "\n")
cat("Максимум:", max(data), "\n")

# Квартили
cat("\nКвартили:\n")
print(quantile(data))

# Обобщена статистика
cat("\nОбобщение:\n")
print(summary(data))

# Пример 2: Графики
par(mfrow = c(2, 2))  # 2x2 мрежа от графики

# Хистограма
hist(data, 
     main = "Хистограма",
     col = "lightblue",
     xlab = "Стойности")

# Боксплот
boxplot(data,
        main = "Боксплот",
        col = "lightgreen",
        ylab = "Стойности")

# Графика с плътност
plot(density(data),
     main = "Плътност",
     col = "red",
     lwd = 2)

# Q-Q графика
qqnorm(data,
       main = "Q-Q графика")
qqline(data, col = "blue")

par(mfrow = c(1, 1))  # Връщане към нормален режим

# Пример 3: Линейни графики
x <- seq(0, 10, 0.1)
y <- sin(x)

# Основна графика
plot(x, y,
     type = "l",
     main = "Синусова функция",
     xlab = "x",
     ylab = "sin(x)",
     col = "blue",
     lwd = 2)

# Добавяне на косинус
lines(x, cos(x), 
      col = "red", 
      lwd = 2, 
      lty = 2)

# Добавяне на легенда
legend("topright",
       legend = c("sin(x)", "cos(x)"),
       col = c("blue", "red"),
       lwd = c(2, 2),
       lty = c(1, 2))

# Пример 4: Разделяне на екрана
# Разделяне на 3 части
split.screen(c(1, 3))

screen(1)
plot(1:5, 1:5, main = "Графика 1")

screen(2)
plot(5:1, 1:5, main = "Графика 2")

screen(3)
plot(1:5, 5:1, main = "Графика 3")

close.screen(all.screens = TRUE)

# Пример 5: Практически анализ
# Генериране на нормално разпределени данни
set.seed(42)
sample_data <- rnorm(200, mean = 100, sd = 15)

# Преглед на разпределението
hist(sample_data,
     breaks = 20,
     main = "Разпределение на височини",
     xlab = "Височина (см)",
     col = "lightblue",
     border = "white",
     prob = TRUE)  # Показва плътност

# Добавяне на крива на плътността
lines(density(sample_data), 
      col = "red", 
      lwd = 2)

# Добавяне на нормално разпределение
curve(dnorm(x, mean = mean(sample_data), sd = sd(sample_data)),
      add = TRUE,
      col = "blue",
      lwd = 2,
      lty = 2)

# Добавяне на вертикални линии за средна стойност и стандартни отклонения
abline(v = mean(sample_data), col = "green", lwd = 2)
abline(v = mean(sample_data) + sd(sample_data), col = "orange", lwd = 1, lty = 2)
abline(v = mean(sample_data) - sd(sample_data), col = "orange", lwd = 1, lty = 2)

# Легенда
legend("topright",
       legend = c("Данни", "Емпирична плътност", "Теоретична нормална", "Средна", "±1 SD"),
       col = c("lightblue", "red", "blue", "green", "orange"),
       lwd = c(NA, 2, 2, 2, 1),
       lty = c(NA, 1, 2, 1, 2),
       fill = c("lightblue", NA, NA, NA, NA),
       border = c("white", NA, NA, NA, NA))

# Пример 6: Изчисляване на различни квантили
data_vector <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)

cat("\nРазлични квантили:\n")
cat("25-ти перцентил:", quantile(data_vector, 0.25), "\n")
cat("Медиана (50-ти перцентил):", quantile(data_vector, 0.5), "\n")
cat("75-ти перцентил:", quantile(data_vector, 0.75), "\n")
cat("90-ти перцентил:", quantile(data_vector, 0.9), "\n")
cat("95-ти перцентил:", quantile(data_vector, 0.95), "\n")
cat("99-ти перцентил:", quantile(data_vector, 0.99), "\n")

# Пример 7: Сравнение на две популации
group1 <- rnorm(50, mean = 100, sd = 10)
group2 <- rnorm(50, mean = 110, sd = 12)

# Боксплот за сравнение
boxplot(list("Група 1" = group1, "Група 2" = group2),
        main = "Сравнение на две групи",
        ylab = "Стойности",
        col = c("lightblue", "lightgreen"),
        border = c("blue", "green"))

# Статистики за сравнение
cat("\nСтатистики за Група 1:\n")
print(summary(group1))
cat("\nСтатистики за Група 2:\n")
print(summary(group2))

# Пример 8: Използване на split.screen за сложни графики
split.screen(c(2, 2))

screen(1)
hist(group1, main = "Група 1", col = "lightblue")

screen(2)
hist(group2, main = "Група 2", col = "lightgreen")

screen(3)
boxplot(list(group1, group2), 
        names = c("Група 1", "Група 2"),
        col = c("lightblue", "lightgreen"))

screen(4)
plot(density(group1), 
     main = "Плътност", 
     col = "blue", 
     lwd = 2,
     xlim = range(c(group1, group2)))
lines(density(group2), 
      col = "green", 
      lwd = 2)
legend("topright", 
       legend = c("Група 1", "Група 2"), 
       col = c("blue", "green"), 
       lwd = 2)

close.screen(all.screens = TRUE)

# Пример 9: Проста времева серия
time <- 1:100
values <- cumsum(rnorm(100))  # случаен разход

plot(time, values,
     type = "l",
     main = "Времева серия",
     xlab = "Време",
     ylab = "Стойност",
     col = "darkblue",
     lwd = 2)

# Добавяне на плъзгаща се средна
library(zoo)
moving_avg <- rollmean(values, 10, fill = NA)
lines(time, moving_avg, 
      col = "red", 
      lwd = 2, 
      lty = 2)

# Добавяне на линия на тренда
trend <- lm(values ~ time)
abline(trend, 
       col = "green", 
       lwd = 2)

legend("topleft",
       legend = c("Данни", "Плъзгаща се средна (10)", "Линеен тренд"),
       col = c("darkblue", "red", "green"),
       lwd = c(2, 2, 2),
       lty = c(1, 2, 1))

# Край на демонстрацията
cat("\nДемонстрацията на статистическите функции и графики е завършена!\n")