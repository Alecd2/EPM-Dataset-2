## For Session 1

library(plyr)
setwd("C:/Users/Alec Duggan/Documents/EPM Dataset 2/Data/Processes/Session 1/")
filenames <- list.files()
library(gtools)
filenames <- mixedsort(filenames)
vec1 <- c("session", "student_Id", "exercise", "activity", "start_time", "end_time", "idle_time", "mouse_wheel", "mouse_wheel_click", "mouse_click_left", "mouse_click_right", "mouse_movement", "keystroke")

dataframe1 <- ldply(.data = filenames, .fun = read.csv, col.names = vec1)

## For Sessions 2

setwd("C:/Users/Alec Duggan/Documents/EPM Dataset 2/Data/Processes/Session 2/")
filenames <- list.files()
filenames <- mixedsort(filenames)
dataframe2 <- ldply(.data = filenames, .fun = read.csv, col.names = vec1) 

## Session 3

setwd("C:/Users/Alec Duggan/Documents/EPM Dataset 2/Data/Processes/Session 3/")
filenames <- list.files()
filenames <- mixedsort(filenames)
dataframe3 <- ldply(.data = filenames, .fun = read.csv, col.names = vec1) 

## Session 4

setwd("C:/Users/Alec Duggan/Documents/EPM Dataset 2/Data/Processes/Session 4/")
filenames <- list.files()
filenames <- mixedsort(filenames)
dataframe4 <- ldply(.data = filenames, .fun = read.csv, col.names = vec1) 

## Session 5

setwd("C:/Users/Alec Duggan/Documents/EPM Dataset 2/Data/Processes/Session 5/")
filenames <- list.files()
filenames <- mixedsort(filenames)
dataframe5 <- ldply(.data = filenames, .fun = read.csv, col.names = vec1) 

## Session 6

setwd("C:/Users/Alec Duggan/Documents/EPM Dataset 2/Data/Processes/Session 6/")
filenames <- list.files()
filenames <- mixedsort(filenames)
dataframe6 <- ldply(.data = filenames, .fun = read.csv, col.names = vec1) 

## MegaFrame (Should be dim of 229798)

megaframe <- rbind(dataframe1, dataframe2)
megaframe <- rbind(megaframe, dataframe3)
megaframe <- rbind(megaframe, dataframe4)
megaframe <- rbind(megaframe, dataframe5)
megaframe <- rbind(megaframe, dataframe6)

##Single student
Student1 <- filter(megaframe, student_Id == 1)


## Filter by first Full subset for students with all sessions and final grades

megaframe <- arrange(megaframe, student_Id)

vecfull <- c(2,4,5,7,10,11,12,14,15,17,19,20,28,30,32,34,36,38,39,42,44,47,49,51,52,53,54,55,56,59,66,67,70,74,78,79,80,81,82,85,86,87,88,90,91,92,93,94,98)
fullmegaframe <- filter(megaframe, student_Id %in% vecfull)


##Filter by subset of students who missed one session but have final grade
vecsub1 <- c(1,6,9,16,18,27,29,41,48,50,61,68,72,73,83,95,96,97,99,102)
sub1megaframe <- filter(megaframe, student_Id %in% vecsub1)



##Filter by subset of students who missed more than one session but have final grade
test1 <- c(1:107)
newvec <- c(vecfull, vecsub1)
vecsub2 <- setdiff(test1, newvec)
sub2megaframe <- filter(megaframe, student_Id %in% vecsub2)



## Final grades
setwd("C:/Users/Alec Duggan/Documents/EPM Dataset 2/Data")
library(openxlsx)
finalgrades1 <- read.xlsx("final_grades.xlsx", sheet = 1)
finalgrades2 <- read.xlsx("final_grades.xlsx", sheet = 2)

colnames(finalgrades1)[18] <- "Total"
colnames(finalgrades2)[18] <- "Total"

finalgrades1 <- select(finalgrades1, Student.ID, Total)
finalgrades2 <- select(finalgrades2, Student.ID, Total)

##Full subset grade
finalgradesfull1 <- filter(finalgrades1, Student.ID %in% vecfull)
finalgradesfull2 <- filter(finalgrades2, Student.ID %in% vecfull)
#Get the average of final grades for full subset
finalgradesfull1 %>% bind_rows(finalgradesfull2) %>% arrange(Student.ID) %>% summarise(all = mean(Total)) ## 56.95763

##Subset 1
finalgrades_s1 <- filter(finalgrades1, Student.ID %in% vecsub1)
finalgrades_s2 <- filter(finalgrades2, Student.ID %in% vecsub1)

finalgrades_s1 %>% bind_rows(finalgrades_s2) %>% arrange(Student.ID) %>% summarise(all = mean(Total)) # 60.18182

##Subset 2
finalgrades_s3 <- filter(finalgrades1, Student.ID %in% vecsub2)
finalgrades_s4 <- filter(finalgrades2, Student.ID %in% vecsub2)

finalgrades_s3 %>% bind_rows(finalgrades_s4) %>% arrange(Student.ID) %>% summarise(all = mean(Total)) #46.18182




