getwd()
#"./autasmall.csv"
#setwd()

install.packages("httr")
install.packages("jsonlite")
installed.packages("dpylr")

# Zad.1
cars <- read.csv("./autasmall.csv", fileEncoding="UTF-8")
View(head(cars, 5))

#Zad.2

library(httr)
library(jsonlite)

# moje rozwiązanie
endpoint <- "https://api.openweathermap.org/data/2.5/weather?q=Warszawa&appid=bc04ccba04751b32190b90cbc84c9acc&units=metric"
#httr::GET
getweather <- GET(endpoint)
weatherText<-content(getweather, "text")
View(weatherText)
weatherJSON<-fromJSON(weatherText)
wdf <- as.data.frame(weatherJSON)
View(wdf)

# rozwiązanie z projektora
library(httr)
library(jsonlite)
endpoint <- "https://api.openweathermap.org/data/2.5/weather?q=Warszawa&appid=1765994b51ed366c506d5dc0d0b07b77&units=metric"
#httr::GET
getWeather<- GET(endpoint)
weatherText<- content(getWeather,"text")
View(weatherText)
weatherJSON<-fromJSON(weatherText)
wdf<- as.data.frame(weatherJSON)
View(wdf)

#Zad.3

install.packages("RSQLite")
install.packages("DBI")
#install.packages(c("DBI", "RSQLite"))

library(RSQLite)
library(DBI)
readToBase<-function(filepath,dbConn,tablename,nrows,sep=",",header=TRUE,delete=TRUE){
  ap<-delete
  ov<-delete
  #fileConnection<-file(description="autaSmall.csv", open="r")
  fileConnection<-file(description=filepath, open="r")
  df <-read.table(fileConnection, nrows=20, header = TRUE, fill=TRUE, sep=",")
  dbWriteTable(con, tablename, df)
  myColNames<-names(df)
  con <- dbConnect(RSQLite::SQLite(), dbConn)
  i<-1
  repeat{
    if(nrow(df)==0){
      dbDisconnect(con)
      clos(fileConnection)
      break
    }
    df <-read.table(fileConnection, nrows=20, header = TRUE, fill=TRUE, sep=",")
    dbWriteTable(con, tablename, df, append = TRUE, overwrite =FALSE)
  }
}

readToBase("./autaSmall.csv", "Cars", "Table_1", "40", sep=",",header=TRUE,delete=TRUE )

con <-dbConnect(SQLite(), "auta.sqlite")
readToBase("./autaSmall.csv", con, "auta2", size=1000)
con <-dbConnect(SQLite(), "auta.sqlite")
res<-dbSendQuery(con, "Select * from auta2")
zBazy <-dbFetch(res)
dbClearResult(res)

fromJSON("http://54.37.136.190:8000/row?id=10000000")


#read_table
#file
#petla
#instrukcja warunkowa przerywania
#polaczenie z sqlitem


con <- dbConnect(RSQLite::SQLite(), "CarsDB.db")

# Odczyt danych podzielonych


View(df1)
df2<- read.table(fileConnection, nrows=10, col.names=myColNames, fill=TRUE, sep=",")
View(df2)
close(fileConnection)

#Petla


# Utworzenie bazy danych
table_1 <- read.table("./autaSmall.csv", header = TRUE, sep = ",")
#str(table_1)

DBI::dbWriteTable(con, "Cars_data", table_1, header=TRUE)

# Inny przykład
#con <- dbConnect(RSQLite::SQLite(), ":memory:")
#DBI::dbWriteTable(con, "autasmall", table_1)

#Zad. 4
#Napisz funkcję znajdującą tydzień obserwacji z największą średnią ceną ofert korzystając z zapytania SQL.


# Zad. 5
# #5. Podobnie jak w poprzednim zadaniu napisz funkcję znajdującą tydzień obserwacji z największą średnią ceną ofert  tym razem wykorzystując REST api.
library(httr)
library(jsonlite)

# moje rozwiązanie
endpoint <- "http://54.37.136.190:8000/rnumb"
#httr::GET
getweather <- GET(endpoint)
weatherText<-content(getweather, "text")
View(weatherText)
weatherJSON<-fromJSON(weatherText)
wdf <- as.data.frame(weatherJSON)
View(wdf)


