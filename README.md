Bachelorthese project 2018-2019: Beslisbomen
============================================

Op deze repository vind je de up-to-date materialen voor het bachelorthese-project.

Aankomende deadlines
--------------------

-   Maandag 29 april: Inleveren 1e versie Resultaten en Discussie

-   Vrijdag 3 mei: Feedback 1e versie Resultaten en Discussie

-   Maandag 13 mei: Inleveren 2e versie Resultaten en Discussie

-   Maandag 20 mei: Feedback 2e versie Resultaten en Discussie

-   Zondag 2 juni: Inleveren complete bachelorthese (digitaal; op papier kan t/m dinsdag 4 juni)

Tip voor data zoeken: PLOS ONE
------------------------------

Een peer-reviewed journal waarin veel auteurs de data voor hun studie beschikbaar maken als 'supplementary material', of een link geven naar een website met data is PLOS ONE <https://journals.plos.org/plosone/>. Om specifiek in publicaties uit PLOS ONE te zoeken op Google Scholar, ga naar <https://scholar.google.nl/>, klik op het icoon met drie strepen linksbovenin de pagina en dan op 'Geavanceerd zoeken'. Je kunt PLOS ONE dan invoeren onder 'Artikelen weergeven die zijn gepubliceerd in' en zoektermen gebruiken zoals je normaal zou doen.

Relevante literatuur
--------------------

Uit het boek van James, Witten, Hastie en Tibshirani (2013) kunnen hoofdstuk 8 (tree-based methods) en sectie 5.1 (resampling methods - cross validation) behulpzaam zijn. Je kunt het boek gratis downloaden van <https://www-bcf.usc.edu/~gareth/ISL/ISLR%20Sixth%20Printing.pdf>.

Verder geeft de referentielijst onderaan deze pagina een aantal relevante verwijzingen voor de algoritmes geimplementeerd in functie `ctree()` (Hothorn, Hornik & Zeileis, 2006), functies `lmtree` en `glmtree` (Zeileis, Hornik & Hothorn, 2008), functies `lmertree()` en `glmertree()` (Fokkema, Smits, Zeileis, Hothorn & Kelderman, 2018) en functie `randomForest()` (Breiman, 2001). Daar moet je hoe dan ook naar verwijzen als je de algoritmes gebruikt in je scriptie. Het is aan te raden om de publicaties ook te bestuderen, maar als ze je een beetje boven de pet gaan is dat op zich geen probleem.

Wanneer je **R** en specifieke **R** packages gebruikt, is het belangrijk om correct te verwijzen. Al deze software wordt je gratis aangeboden en je kunt iets teruggeven aan de ontwikkelaars door hun werk (correct) te citeren. Om de juiste citatie voor **R** en packages te verkrijgen, gebruik je in **R** de `citation()` functie. Voor APA formatering hoef je alleen nog zelf cursief (van journal- of boektitel) toe te voegen. Bijvoorbeeld:

``` r
citation()
```

    ## 
    ## To cite R in publications use:
    ## 
    ##   R Core Team (2019). R: A language and environment for
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
    ##     year = {2019},
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
    ##   651--674, DOI: 10.1198/106186006X133933
    ## 
    ## If mob() is used additionally cite:
    ## 
    ##   Achim Zeileis, Torsten Hothorn and Kurt Hornik (2008).
    ##   Model-Based Recursive Partitioning. Journal of Computational and
    ##   Graphical Statistics, 17(2), 492--514, DOI:
    ##   10.1198/106186008X319331
    ## 
    ## To see these entries in BibTeX format, use 'print(<citation>,
    ## bibtex=TRUE)', 'toBibtex(.)', or set
    ## 'options(citation.bibtex.max=999)'.

Referenties
===========

Breiman, L. (2001). Random forests. *Machine Learning, 45*(1), 5-32.

Hothorn, T., Hornik, K., & Zeileis, A. (2006). Unbiased recursive partitioning: A conditional inference framework. *Journal of Computational and Graphical Statistics, 15*(3), 651-674.

Fokkema, M., Smits, N., Zeileis, A., Hothorn, T., & Kelderman, H. (2018). Detecting treatment-subgroup interactions in clustered data with generalized linear mixed-effects model trees. *Behavior Research Methods, 50*(5), 2016-2034.

James, G., Witten, D., Hastie, T., Tisbshirani, R. (2013). *An introduction to statistical learning.* Springer Verlag, New York, NY.

Strobl, C., Malley, J., & Tutz, G. (2009). An introduction to recursive partitioning: rationale, application, and characteristics of classification and regression trees, bagging, and random forests. *Psychological Methods, 14*(4), 323.

Zeileis, A., Hothorn, T., & Hornik, K. (2008). Model-based recursive partitioning. *Journal of Computational and Graphical Statistics, 17*(2), 492-514.
