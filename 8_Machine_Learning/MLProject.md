# Machine Learning Project

### Background  

The objective of this analysis is the use accelerameter data to predict (classify) the manner in which a participant was performing an exercise.  There are 5 different classes to predict lettered A through E wit a being the only correct method. The data was collected from the person's belt, forearm, arm or dumbbell. Data such as this is collected from popular devices such as Jawbone or FitBit.  The data was generously provided by Groupware@LES. You can read more about the project [here](http://groupware.les.inf.puc-rio.br/har). 

### Download the Data  

```r
# trainURL<-"https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
#testURL <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
# 
# download.file(trainURL, "train.csv", mode="w")
#download.file(testURL, "test.csv", mode="w")

train    <- read.csv("train.csv", header = T, stringsAsFactors = F, na.strings = c("","NA"))
test    <- read.csv("test.csv", header = T, stringsAsFactors = F, na.strings = "NA")
train$classe<- factor(train$classe)
```

### Split out the validation set  
There are 19622 observations in the training set and 20 observations in the test set. Since there are so many observations in the training set, I should be able to use a small percentage as a hold-out, or validation set, and still have a enough items to adequately do the validation.  I'll use a 90/10 split. 


```r
library(caret)
split<- createDataPartition(train$classe, p=0.9, list=FALSE)
validation<- train[-split,]
train<- train[split,]
```

### Brief Exploratory Analysis  
There are 5 classes of outcomes: A through E. The outcomes are not evenly distributed and there are more A's than the other classes. 'A' is the class for a correctly performed exercise. 


```r
table(train$classe)
```

```

   A    B    C    D    E 
5022 3418 3080 2895 3247 
```


```r
train<- train[,-c(1:7)]
validation<-validation[,-c(1:7)]
```
After running the summary of the training set, it was easy to see there were many variables with NA values. In fact, if the variable had any NA values, then the variable was almost entirely NA.  Because of this, it is safe to remove those variables since they will not add value to the majority of observations. 


```r
index<- which(colSums(is.na(train))>0)
train<- train[,-index]
validation<- validation[,-index]
```

### Fit a Random Forest model
I setup the model to use 5-fold cross validation to reduce the computing time.  As it stands, training the model takes several minutes for my 

```r
fit<- train(classe~., 
            data = train, 
            method = "rf", 
            trControl= trainControl(method = "cv", 
                                    number = 5,
                                    allowParallel = T))
```

```
Loading required package: randomForest
randomForest 4.6-12
Type rfNews() to see new features/changes/bug fixes.

Attaching package: 'randomForest'

The following object is masked from 'package:ggplot2':

    margin
```
### Predict on Validation Set

```r
pred<- predict(fit, newdata=validation)

confusionMatrix(validation$classe, pred)
```

```
Confusion Matrix and Statistics

          Reference
Prediction   A   B   C   D   E
         A 557   1   0   0   0
         B   1 377   1   0   0
         C   0   0 342   0   0
         D   0   0   3 318   0
         E   0   0   0   3 357

Overall Statistics
                                          
               Accuracy : 0.9954          
                 95% CI : (0.9913, 0.9979)
    No Information Rate : 0.2847          
    P-Value [Acc > NIR] : < 2.2e-16       
                                          
                  Kappa : 0.9942          
 Mcnemar's Test P-Value : NA              

Statistics by Class:

                     Class: A Class: B Class: C Class: D Class: E
Sensitivity            0.9982   0.9974   0.9884   0.9907   1.0000
Specificity            0.9993   0.9987   1.0000   0.9982   0.9981
Pos Pred Value         0.9982   0.9947   1.0000   0.9907   0.9917
Neg Pred Value         0.9993   0.9994   0.9975   0.9982   1.0000
Prevalence             0.2847   0.1929   0.1765   0.1638   0.1821
Detection Rate         0.2842   0.1923   0.1745   0.1622   0.1821
Detection Prevalence   0.2847   0.1934   0.1745   0.1638   0.1837
Balanced Accuracy      0.9987   0.9980   0.9942   0.9944   0.9991
```
Not bad, my prediction only misclassified a few observations. Per the summary, the accuracy of this model is 99% which is incredible. I'll run the prediction against the test set and get the results for the quiz.  


```r
test<- test[,-c(1:7)]
test<- test[,-index]
final_pred<- data.frame(Predictions=predict(fit, newdata=test))
write.csv(final_pred, file="Predictions.csv")
```
UPDATE: 20/20 on the quiz!

