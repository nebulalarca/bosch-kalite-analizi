
library(duckdb)
library(DBI)
library(ggplot2)
library(randomForest)

# 
con <- dbConnect(duckdb())

# 
dbExecute(con, "CREATE VIEW train_num AS SELECT * FROM read_csv_auto('/Users/melis/Desktop/bosch-production-line-performance/train_numeric.csv')")

# Hata orani
dbGetQuery(con, "SELECT Response, COUNT(*) as adet FROM train_num GROUP BY Response")

# 
model_data <- dbGetQuery(con, "
  SELECT L3_S29_F3315, L3_S29_F3318, L3_S29_F3321,
         L3_S30_F3494, L3_S30_F3499, L3_S33_F3855,
         L3_S35_F3884, Response
  FROM train_num
  WHERE L3_S29_F3315 IS NOT NULL
  LIMIT 100000
")
model_data[is.na(model_data)] <- 0

# 
hatali <- model_data[model_data$Response == 1, ]
hatasiz <- model_data[model_data$Response == 0, ]
set.seed(42)
hatali_arttirilmis <- hatali[sample(nrow(hatali), 5000, replace = TRUE), ]
hatasiz_azaltilmis <- hatasiz[sample(nrow(hatasiz), 5000), ]
dengeli <- rbind(hatali_arttirilmis, hatasiz_azaltilmis)
dengeli <- dengeli[sample(nrow(dengeli)), ]

# Train/test
idx <- sample(nrow(dengeli), 0.8 * nrow(dengeli))
train_set <- dengeli[idx, ]
test_set <- dengeli[-idx, ]
train_set$Response <- as.factor(train_set$Response)
test_set$Response <- as.factor(test_set$Response)

# Random Forest
rf_model <- randomForest(Response ~ ., data = train_set, ntree = 100)
rf_tahmin <- predict(rf_model, test_set)
rf_tablo <- table(Gercek = test_set$Response, Tahmin = rf_tahmin)
print(rf_tablo)
cat("Dogruluk:", round(sum(diag(rf_tablo)) / sum(rf_tablo) * 100, 2), "%
")
