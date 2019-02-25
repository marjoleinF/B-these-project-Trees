In dit voorbeeld gebruiken we de dataset van vorige week:

``` r
library("foreign")
dep_data <- read.spss("data Carrillo et al.sav", to.data.frame = TRUE)
```

    ## re-encoding from UTF-8

Inleiding (Introduction)
========================

Aan het eidne van de Inleiding (Introduction) sectie moet je de hypothesen die je in je onderzoek gaat toetsen vermelden. Een van de mogelijke hypothesen die we kunnen toetsen met de voorbeelddata van vorige week is als volgt:

Beslisboommethoden geven een betere predictie dan lineaire regressie bij het voorspellen van depressiescores op basis van persoonlijkheidsschalen.

In de resultaten sectie toets je deze hypothese. Hieronder een voorbeeld. De R code is weergegeven, zodat je ziet waar de gerapporteede resultaten vandaan komen, maar die moet je natuurlijk weglaten uit je eigen Resultatensectie.

Resultaten (Results)
====================

``` r
# load packages:
library("partykit")
library("rpart")

# generate k folds for CV:
k <- 10
fold_ids <- rep(1:k, length.out = nrow(dep_data))
set.seed(42)
fold_ids <- sample(fold_ids)

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
errors <- cv_preds - dep_data$bdi
## Bereken MSE (mean squared error) en standard errors:
colMeans(errors^2)
```

    ##       lm    ctree    rpart 
    ## 53.04657 48.80217 40.79667

``` r
apply(errors^2, MARGIN = 2, FUN = sd) / sqrt(nrow(errors))
```

    ##        lm     ctree     rpart 
    ## 11.130021  8.310137  7.006908

``` r
boxplot(errors, names = c("Lineaire regressie", "Beslisboom: ctree", "Beslisboom: rpart"))
```

![Figuur 1. Boxplots van predictiefouten per methode.](R_script_files/figure-markdown_github/unnamed-chunk-3-1.png)

In Figuur 1 (let op dat geen APA formattering is gebruikt in Figuur 1, dat moet je in je scriptie wel doen) zijn de predictiefouten voor de methoden weergegeven. De MSE was 53.05 (SE = 11.13) voor lineaire regressie, 48.80 (SE = 8.31) voor de ctree en 40.80 (SE = 7.00) voor de rpart methode. De verschillen tussen de MSEs lijken klein, in vergelijking met de standard errors. Een one-way ANOVA liet geen significante verschillen in mean squared errors (MSEs) tussen de methoden zien: *F*(2, 333) = 0.480; *p* = .619. Een tweede one-way ANOVA liet geen significante verschillen tussen de mean absolute errors (MAEs) tussen de methoden zien: *F*(2, 333) = 0.358; p = .700. Er werd dus geen ondersteuning voor de hypothese gevonden.

``` r
errors_aov_dat <- stack(errors)
sq_errors_aov <- aov(values^2 ~ ind, data = errors_aov_dat)
summary(sq_errors_aov)
```

    ##              Df  Sum Sq Mean Sq F value Pr(>F)
    ## ind           2    8667    4334    0.48  0.619
    ## Residuals   333 3008948    9036

``` r
abs_errors_aov <- aov(abs(values) ~ ind, data = errors_aov_dat)
summary(abs_errors_aov)
```

    ##              Df Sum Sq Mean Sq F value Pr(>F)
    ## ind           2     16   7.986   0.358    0.7
    ## Residuals   333   7436  22.329
