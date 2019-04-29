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
  vars[vars != "<leaf>"]
}
get_vars_rpart(dep_cart)
```

    ## [1] "n3"    "n4"    "open5" "open4" "n3"    "e2"

Nu maken we eenzelfde functie, die we toe kunnen passen op een boom gefit met `ctree()`:

``` r
library("partykit")
```

    ## Loading required package: grid

    ## Loading required package: libcoin

    ## Loading required package: mvtnorm

``` r
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
