---
title: "DCS Assignments Part I-B"
author: "Fred Hasselman & Maarten Wijnants"
date: "1/14/2018"
output: 
  bookdown::html_document2: 
    variant: markdown+hard_line_breaks
    fig_caption: yes
    highlight: pygments
    keep_md: yes
    number_sections: yes
    theme: spacelab
    toc: yes
    toc_float: true
    collapsed: false
    smooth_scroll: true
    code_folding: show
    bibliography: [refs.bib, packages.bib]
    biblio-style: apalike
    csl: apa.csl
    includes:
        before_body: assignmentstyle.html
    pandoc_args: ["--number-offset","2"]

---




# **Quick Links** {-}

* [Main Assignments Page](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/)
* [Assignments Part 1A: Introduction to the mathematics of change](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P1A.html)
* [Assignments Part 2: Time Series Analysis: Temporal Correlations and Fractal Scaling](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P2.html)
* [Assignments Part 3: Quantifying Recurrences in State Space](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P3.html)
* [Assignments Part 4: Complex Networks](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P4.html)
  
</br>
</br>


# **Potential Theory and Catastrophe Models**

* The non-linear regression assignment is written for `SPSS`, but you can try to use 'R' as well. Be sure to look at the solutions of the [Basic Time Series Analysis](#bta)) assignments.
* Using the `cusp` package 

</br>
</br>

## **Fitting the cusp catastrophe in `SPSS`**

In the file [Cusp Attitude.sav](https://github.com/FredHasselman/DCS/raw/master/assignmentData/Potential_Catastrophe/Cusp%20attitude.sav), you can find data from a (simulated) experiment. Assume the experiment tried to measure the effects of explicit predisposition and [affective conditioning](http://onlinelibrary.wiley.com/doi/10.1002/mar.4220110207/abstract) on attitudes towards Complexity Science measured in a sample of psychology students using a specially designed Implicit Attitude Test (IAT).


### Explore the data for catastrophe flags

* Look at a Histogram of the difference score (post-pre) $dZY$. This should look quite normal (pun intended).
    -	Perform a regular linear regression analysis predicting $dZY$ (Change in Attitude) from $\alpha$ (Predisposition). 
    - Are you happy with the $R^2$?
* Look for Catastrophe Flags: Bi-modality. Examine what the data look like if we split them across the conditions.
    - Use $\beta$ (Conditioning) as a Split File Variable (`Data >> Split File`). And again, make a histogram of $dZY$.
    - Try to describe what you see in terms of the experiment.
    - Turn Split File off. Make a Scatter plot of $dZY$ (x-axis) and $\alpha$ (y-axis). Here you see the bi-modality flag in a more dramatic fashion. 
     - Can you see another flag?     
      

### Fitting the catastrophe model

* Perhaps we should look at a cusp Catastrophe model:

   - Go to `Analyse >> Regression >> Nonlinear` (also see [Basic Time Series Analysis](#bta)). First we need to tell SPSS which parameters we want to use, press `Parameters.` 
    - Now you can fill in the following: 
        + `Intercept` (Starting value $0.01$)
        + `B1` through `B4` (Starting value $0.01$)
        + Press `Continue` and use $dZY$ as the dependent. 
    - Now we build the model in `Model Expression`, it should say this: 
    ```
    Intercept + B1 * Beta * ZY1 + B2 * Alpha + B3 * ZY1 ** 2 + B4 * ZY1 ** 3
    ```
    - Run! And have a look at $R^2$.


### Alternative without using `regular` regression 

The model can also be fitted with linear regression in SPSS, but we need to make some extra (non-linear) variables using `COMPUTE`:

</br>

```
BetaZY1 = Beta*ZY1	*(Bifurcation, splitting parameter).
ZY1_2 = ZY1 ** 2	*(ZY1 Squared).
ZY1_3 = ZY1 ** 3	*(ZY1 Cubed).
```
</br>

* Create a linear regression model with $dZY$ as dependent and $Alpha$, $BetaZY1$ and $ZY1_2$ en $ZY1_3$ as predictors. 
* Run! The parameter estimates should be the same.
  
  
### Plot the results

Finally try to can make a 3D-scatter plot with a smoother surface to have look at the response surface.

* HINT: this is a lot easier in `R` or `Matlab` perhaps you can export your `SPSS` solution.

### Interpret the results

How to evaluate this model fit? 

* Check Chapter 3 in which the analysis strategy is summarised. 
* The cusp has to outperform the `pre-post` model.


## Using the `cusp` package in `R`

Use this tutorial paper to fit the cusp in 'R' according to a maximum likelihood criterion.

[Grasman, R. P. P. P., Van der Maas, H. L. J., & Wagenmakers, E. (2007). Fitting the Cusp Catastrophe in R: A cusp-Package.](https://cran.r-project.org/web/packages/cusp/vignettes/Cusp-JSS.pdf)

- Start R and install package `cusp` 

- Work through the *Example I* (attitude data) in the paper (*Section 4: Examples*, p. 12).

- *Example II* in the same section is also interesting, but is based on simulated data.
    + Try to think of an application to psychological / behavioural science.
