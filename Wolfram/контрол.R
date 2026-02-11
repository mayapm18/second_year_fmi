#1

f_x<-function(x,n)
    {
  total=0
      for(i in 1:n)
      {
        total<- total + i*(x^(1/i))
      }
  return(total)
}
f_x(2,10)

#2
data_fish <- read.csv("C:/Users/Msi/Downloads/Fish.txt")
data_fish_heavy <- data_fish[data_fish$Weight>700,]
data_fish_heavy_sort <- data_fish_heavy[order(data_fish_heavy$Weight, decreasing = T),]

qqnorm(data_fish$Weight)
qqline(data_fish$Weight)
#ако точките са на линията = нормално разпределение, иначе не 

shapiro.test(data_fish$Weight)
#малко p-value = не е нормална
#голямо p-value = нормална

data_fish_lenght_sort <- data_fish[order(data_fish$Height,decreasing = T),]
data_fish_lenght_sort[1:5,]

#3
data("survey")
data_sport<-survey[survey$Exer =="Freq",]
mean(data_sport$Pulse, na.rm = T)
t.test(survey$Pulse,conf.level = 0.90)

#4

qnorm(0.975)
