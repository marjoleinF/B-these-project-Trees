Bachelorthese project 2018-2019: Beslisbomen
============================================

Op deze repository vind je de up-to-date materialen voor het bachelorthese-project.

Literatuur
==========

Uit het boek van James, Witten, Hastie en Tibshirani (2013) kunnen hoofdstuk 8 (tree-based methods) en sectie 5.1 (resampling methods - cross validation) behulpzaam zijn.

De referentielijst geeft noder meer verwijzingen voor de algoritmes geimplementeerd in functie `ctree()` (Hothorn, Hornik & Zeileis, 2006), functies `lmtree` en `glmtree` (Zeileis, Hornik & Hothorn, 2008), functies `lmertree()` en `glmertree()` (Fokkema et al, 2018) en functie `randomForest()` (Breiman, 2001). Daar moet je hoe dan ook naar verwijzen als je de algoritmes gebruikt in je scriptie. Het is aan te raden om de publicaties ook te bestuderen, maar als ze je boven de pet gaan is dat op zich geen probleem.

Wanneer je **R** en specifieke **R** packages gebruikt, is het belangrijk om correct te verwijzen. Al deze software wordt je gratis aangeboden en je kunt iets teruggeven aan de ontwikkelaars door hun werk (correct) te citeren. Om de juiste citatie voor **R** en packages te verkrijgen, gebruik je in **R** de `citation()` functie. Voor APA formatering hoef je alleen nog zelf cursief (van journal- of boektitel) toevoegt.

``` r
citation()
```

    ## 
    ## To cite R in publications use:
    ## 
    ##   R Core Team (2017). R: A language and environment for
    ##   statistical computing. R Foundation for Statistical Computing,
    ##   Vienna, Austria. URL https://www.R-project.org/.
    ## 
    ## A BibTeX entry for LaTeX users is
    ## 
    ##   @Manual{,
    ##     title = {R: A Language and Environment for Statistical Computing},
    ##     author = {{R Core Team}},
    ##     organization = {R Foundation for Statistical Computing},
    ##     address = {Vienna, Austria},
    ##     year = {2017},
    ##     url = {https://www.R-project.org/},
    ##   }
    ## 
    ## We have invested a lot of time and effort in creating R, please
    ## cite it when using it for data analysis. See also
    ## 'citation("pkgname")' for citing R packages.

``` r
citation("partykit")
```

    ## 
    ## To cite partykit in publications use:
    ## 
    ##   Torsten Hothorn, Achim Zeileis (2015). partykit: A Modular
    ##   Toolkit for Recursive Partytioning in R. Journal of Machine
    ##   Learning Research, 16, 3905-3909. URL
    ##   http://jmlr.org/papers/v16/hothorn15a.html
    ## 
    ## If ctree() is used additionally cite:
    ## 
    ##   Torsten Hothorn, Kurt Hornik and Achim Zeileis (2006). Unbiased
    ##   Recursive Partitioning: A Conditional Inference Framework.
    ##   Journal of Computational and Graphical Statistics, 15(3),
    ##   651--674.
    ## 
    ## If mob() is used additionally cite:
    ## 
    ##   Achim Zeileis, Torsten Hothorn and Kurt Hornik (2008).
    ##   Model-Based Recursive Partitioning. Journal of Computational and
    ##   Graphical Statistics, 17(2), 492--514.
    ## 
    ## To see these entries in BibTeX format, use 'print(<citation>,
    ## bibtex=TRUE)', 'toBibtex(.)', or set
    ## 'options(citation.bibtex.max=999)'.

Referenties
===========

Breiman, L. (2001). Random forests. *Machine Learning, 45*(1), 5-32.

Hothorn, T., Hornik, K., & Zeileis, A. (2006). Unbiased recursive partitioning: A conditional inference framework. *Journal of Computational and Graphical statistics, 15*(3), 651-674.

Fokkema, M., Smits, N., Zeileis, A., Hothorn, T., & Kelderman, H. (2018). Detecting treatment-subgroup interactions in clustered data with generalized linear mixed-effects model trees.\* Behavior Research Methods, 50\*(5), 2016-2034.

James, G., Witten, D., Hastie, T., Tisbshirani, R. (2013). *An introduction to statistical learning.* Springer Verlag, New York, NY.

Strobl, C., Malley, J., & Tutz, G. (2009). An introduction to recursive partitioning: rationale, application, and characteristics of classification and regression trees, bagging, and random forests. *Psychological Methods, 14*(4), 323.

Zeileis, A., Hothorn, T., & Hornik, K. (2008). Model-based recursive partitioning. *Journal of Computational and Graphical Statistics, 17*(2), 492-514.
