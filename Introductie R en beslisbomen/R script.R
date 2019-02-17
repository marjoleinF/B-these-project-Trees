##
## Load and inspect data:
## 

library("foreign")
dep_data <- read.spss("data Carrillo et al.sav", to.data.frame = TRUE)

## Inspect data:
head(dep_data)
dim(dep_data)
names(dep_data)
summary(dep_data)
plot(dep_data)
sapply(dep_data, class)
# Correctly set class of variable:
dep_data$sexo <- factor(dep_data$sexo)



##
## Fit trees
##

## Predict BDI scores with all other variables (regression):

# Fit linear model:
dep_lm <- lm(bdi ~ ., data = dep_data)
dep_lm # print(dep_lm) would yield same result
summary(dep_lm) # gives significance tests
plot(dep_lm) # for checking assumptions

# Fit regression trees:
library("partykit")
dep_ctree <- ctree(bdi ~ ., data = dep_data)
plot(dep_ctree)
plot(dep_ctree, type = "simple")
print(dep_ctree)

library("rpart")
dep_cart <- rpart(bdi ~ ., data = dep_data)
plot(dep_cart)
text(dep_cart)


## (For sake of example) Predict gender using personality scores (classification):

# Fit logistic regression:
gen_glm <- glm(sexo ~ . - bdi - edad, data = dep_data, family = "binomial")
gen_glm
summary(gen_glm)
plot(gen_glm)

# Fit classification trees:
gen_ctree <- ctree(sexo ~ . - bdi - edad, data = dep_data)
plot(gen_ctree)
gen_cart <- rpart(sexo ~ . - bdi - edad, data = dep_data)
plot(gen_cart)
text(gen_cart)





##
## Generate predictions and perform cross validation
##

# Use of predict function:
predict(dep_lm, newdata = dep_data)
predict(dep_ctree, newdata = dep_data)
predict(dep_cart, newdata = dep_data)
predict(gen_glm, newdata = dep_data)
predict(gen_ctree, newdata = dep_data)
predict(gen_ctree, newdata = dep_data, type = "prob")
predict(gen_cart, newdata = dep_data)

# generate k folds for CV:
k <- 10
fold_ids <- rep(1:k, length.out = nrow(dep_data))
fold_ids
set.seed(42)
fold_ids <- sample(fold_ids)
fold_ids
dim(dep_data[fold_ids != 1, ]) # training data for fold 1
dim(dep_data[fold_ids == 1, ]) # test data for fold 1
dim(dep_data[fold_ids != 9, ]) # training data for fold 9
dim(dep_data[fold_ids == 9, ]) # test data for fold 9

# perform CV:
lmods <- ctrees <- list() # for saving fitted models (optional, for later use)
cv_preds <- data.frame(matrix(NA, nrow = nrow(dep_data), ncol = 3))
names(cv_preds) <- c("lm", "ctree", "rpart")

for (i in 1:k) {
  
  # Fit models: 
  lmods[[i]] <- lm(bdi ~ ., data = dep_data[fold_ids != i, ])
  ctrees[[i]] <- ctree(bdi ~ ., data = dep_data[fold_ids != i, ])
  cart <- rpart(bdi ~ ., data = dep_data[fold_ids != i, ])
  
  # get predictions:
  cv_preds$lm[fold_ids == i] <- predict(lmods[[i]], 
                                        newdata = dep_data[fold_ids == i,])
  cv_preds$ctree[fold_ids == i] <- predict(ctrees[[i]], 
                                           newdata = dep_data[fold_ids == i,])
  cv_preds$rpart[fold_ids == i] <-predict(cart, 
                                          newdata = dep_data[fold_ids == i,])
}

# save results:
save(cv_preds, file = "cv_preds")
load("cv_preds")



##
## Evaluate results
##

# Assess mean squared error:
errors <- cv_preds - dep_data$bdi
boxplot(errors)
colMeans(errors^2)
apply(errors^2, MARGIN = 2, FUN = sd) 
apply(errors^2, MARGIN = 2, FUN = sd) / sqrt(nrow(errors))
# in terms of standard error, differences seem not significant

# Perform anova to test significance of differences:
errors_aov_dat <- stack(errors)
head(errors_aov_dat)
errors_aov <- aov(values^2 ~ ind, data = errors_aov_dat)
summary(errors_aov)
TukeyHSD(errors_aov)
# as already suspected, no significant difference between methods




##
## Fitting trees to multilevel data
##

library("glmertree")
UKMH_data <- read.table("UK_MH mimic data.txt")
dim(UKMH_data)
head(UKMH_data)
UKMH_tree <- lmertree(outcome ~ 1 | cluster_id | age + gender + emotional + 
                        autism + impact + conduct, data = UKMH_data)
plot(UKMH_tree)

# check assumptions:
resids <- residuals(UKMH_tree)
plot(x = factor(UKMH_data$cluster_id), y = resids, 
     xlab = "cluster indicator", ylab = "residuals",
     boxwex = .5, cex.lab=.75, cex.axis = .75)
preds <- predict(UKMH_tree)
scatter.smooth(x = preds, y = resids, xlab = "predicted values", 
               ylab = "residuals", cex = .5, cex.lab = .75, cex.axis = .75)




##
## Fitting model-based trees
## 

data("DepressionDemo", package = "glmertree")
head(DepressionDemo)

# fit linear model tree
lt <- lmtree(depression ~ treatment | age + anxiety + duration,
               data = DepressionDemo)
print(lt)
plot(lt)

# fit linear mixed-effects model tree:
lmert <- lmertree(depression ~ treatment | cluster | age + anxiety + duration,
                data = DepressionDemo)
print(lmert)
plot(lmert)
head(predict(lmert, newdata = DepressionDemo))
head(predict(lmert, re.form = NA))