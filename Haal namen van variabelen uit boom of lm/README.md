Welke variabelen worden in de boom gebruikt?
============================================

In dit voorbeeld gebruiken we weer de dataset uit een van de eerdere weken:

``` r
library("foreign")
dep_data <- read.spss("data Carrillo et al.sav", to.data.frame = TRUE)
```

    ## re-encoding from UTF-8

``` r
dep_data$sexo <- factor(dep_data$sexo)
```

CART bomen (rpart)
------------------

We fitten eerst een regressieboom met functie `rpart()`:

``` r
library("rpart")
dep_cart <- rpart(bdi ~ ., data = dep_data)
dep_cart
```

    ## n= 112 
    ## 
    ## node), split, n, deviance, yval
    ##       * denotes terminal node
    ## 
    ##  1) root 112 6822.9200  7.973214  
    ##    2) n3< 23 98 3087.3880  6.163265  
    ##      4) n4< 14.5 51  682.1569  3.725490  
    ##        8) open5>=12.5 41  301.6098  2.902439 *
    ##        9) open5< 12.5 10  238.9000  7.100000 *
    ##      5) n4>=14.5 47 1773.2770  8.808511  
    ##       10) open4>=9.5 40 1075.9750  7.475000  
    ##         20) n3< 17.5 20  224.0000  5.000000 *
    ##         21) n3>=17.5 20  606.9500  9.950000  
    ##           42) e2>=16.5 7  155.4286  6.714286 *
    ##           43) e2< 16.5 13  338.7692 11.692310 *
    ##       11) open4< 9.5 7  219.7143 16.428570 *
    ##    3) n3>=23 14 1167.2140 20.642860 *

Nu maken we een functie, die we toe kunnen passen op een boom gefit met `rpart()`, die een vector met de namen van variabelen die in de boom zijn gebruikt, teruggeeft. We maken daarbij gebruik van het `$frame` gedeelte van de `rpart` tree:

``` r
get_vars_rpart <- function(tree) {
  vars <- as.character(tree$frame$var)
  return(unique(vars[vars != "<leaf>"]))
}
get_vars_rpart(dep_cart)
```

    ## [1] "n3"    "n4"    "open5" "open4" "e2"

c- en lmtrees (partykit)
------------------------

Nu maken we eenzelfde functie, die we toe kunnen passen op een boom gefit met `ctree()`:

``` r
library("partykit")
dep_ctree <- ctree(bdi ~ ., data = dep_data)
dep_ctree
```

    ## 
    ## Model formula:
    ## bdi ~ n1 + n2 + n3 + n4 + n5 + n6 + ntot + e1 + e2 + e3 + e4 + 
    ##     e5 + e6 + etot + open1 + open2 + open3 + open4 + open6 + 
    ##     opentot + altot + contot + sexo + edad + open5
    ## 
    ## Fitted party:
    ## [1] root
    ## |   [2] n3 <= 22
    ## |   |   [3] n3 <= 13: 3.960 (n = 50, err = 1015.9)
    ## |   |   [4] n3 > 13: 8.458 (n = 48, err = 1575.9)
    ## |   [5] n3 > 22: 20.643 (n = 14, err = 1167.2)
    ## 
    ## Number of inner nodes:    2
    ## Number of terminal nodes: 3

``` r
get_vars_partykit <- function(tree) {
  vars <- c()
  for (i in 1:length(tree)) {
    vars <- c(vars, names(tree$data)[tree[[i]]$node$split$varid])
  }
  return(unique(vars))
}
get_vars_partykit(dep_ctree)
```

    ## [1] "n3"

Diezelfde functie kunnen we gebruiken voor `lmtree()`:

``` r
dep_lmtree <- lmtree(bdi ~ 1 | ., data = dep_data)
dep_lmtree
```

    ## Linear model tree
    ## 
    ## Model formula:
    ## bdi ~ 1 | .
    ## 
    ## Fitted party:
    ## [1] root
    ## |   [2] n3 <= 22
    ## |   |   [3] n4 <= 14: n = 51
    ## |   |       (Intercept) 
    ## |   |           3.72549 
    ## |   |   [4] n4 > 14: n = 47
    ## |   |       (Intercept) 
    ## |   |          8.808511 
    ## |   [5] n3 > 22: n = 14
    ## |       (Intercept) 
    ## |          20.64286 
    ## 
    ## Number of inner nodes:    2
    ## Number of terminal nodes: 3
    ## Number of parameters per node: 1
    ## Objective function (residual sum of squares): 3622.648

``` r
get_vars_partykit(dep_lmtree)
```

    ## [1] "n3" "n4"

Lineair model (lm)
------------------

We kunnen eenzelfde functie maken voor een lineair regressiemodel. In een lineair regressiemodel zullen de geschatte coefficients nooit precies nul zijn. Maar we kunnen de p-waarde gebruiken als selectie criterium: we maken dus een functie, die de predictorvariabelen teruggeeft, die een p-waarde lager of gelijk aan een bepaalde waarde van *α* hebben:

``` r
dep_lm <- lm(bdi ~ ., data = dep_data)
summary(dep_lm)
```

    ## 
    ## Call:
    ## lm(formula = bdi ~ ., data = dep_data)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -11.4921  -2.6953  -0.3822   2.3216  14.3500 
    ## 
    ## Coefficients:
    ##              Estimate Std. Error t value Pr(>|t|)  
    ## (Intercept) -0.416600   8.381019  -0.050   0.9605  
    ## n1           0.005334   0.325177   0.016   0.9870  
    ## n2           0.138600   0.355097   0.390   0.6973  
    ## n3           0.267588   0.324464   0.825   0.4118  
    ## n4           0.168752   0.330412   0.511   0.6108  
    ## n5          -0.193900   0.308486  -0.629   0.5313  
    ## n6           0.186429   0.274688   0.679   0.4992  
    ## ntot         0.037974   0.272565   0.139   0.8895  
    ## e1           0.133700   0.190109   0.703   0.4838  
    ## e2          -0.298969   0.172689  -1.731   0.0870 .
    ## e3           0.216725   0.197663   1.096   0.2759  
    ## e4           0.203849   0.181459   1.123   0.2644  
    ## e5           0.194450   0.174803   1.112   0.2691  
    ## e6          -0.224425   0.178406  -1.258   0.2118  
    ## etot        -0.042132   0.065322  -0.645   0.5206  
    ## open1        0.333890   0.159011   2.100   0.0387 *
    ## open2       -0.007413   0.148802  -0.050   0.9604  
    ## open3        0.049270   0.205260   0.240   0.8109  
    ## open4       -0.463724   0.202708  -2.288   0.0246 *
    ## open6       -0.111411   0.205397  -0.542   0.5889  
    ## opentot     -0.022248   0.088653  -0.251   0.8024  
    ## altot        0.053922   0.091377   0.590   0.5567  
    ## contot      -0.001116   0.083044  -0.013   0.9893  
    ## sexo2        1.505708   1.292724   1.165   0.2473  
    ## edad         0.009624   0.048729   0.198   0.8439  
    ## open5       -0.070631   0.178540  -0.396   0.6934  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 5.571 on 86 degrees of freedom
    ## Multiple R-squared:  0.6089, Adjusted R-squared:  0.4952 
    ## F-statistic: 5.355 on 25 and 86 DF,  p-value: 2.428e-09

``` r
alpha <- 0.05
get_vars_lm <- function(lmod, alpha = .05) {
  tmp <- summary(lmod)
  return(attr(terms(tmp), "term.labels")[
    tmp$coefficients[ , "Pr(>|t|)"] <= alpha])
}
get_vars_lm(dep_lm, alpha = .1)
```

    ## [1] "e3"    "open2" "open6"

``` r
get_vars_lm(dep_lm, alpha = .05)
```

    ## [1] "open2" "open6"

``` r
get_vars_lm(dep_lm, alpha = .01)
```

    ## character(0)

Zoals te verwachten viel, zien we: hoe lager *α*, hoe minder variabelen we selecteren. Met *α* = .01 selecteren we zelfs helemaal geen variabelen meer.
