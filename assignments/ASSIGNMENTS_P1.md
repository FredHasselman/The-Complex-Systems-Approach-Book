---
title: "DCS Assignments Part I"
author: "Fred Hasselman & Maarten Wijnants"
date: "1/14/2018"
output: 
  bookdown::html_document2: 
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
---




# **Quick Links** {-}

* [Main Assignments Page](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/)
* [Assignments Part 2: Time Series Analysis: Temporal Correlations and Fractal Scaling](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P2.html)
* [Assignments Part 3: Quantifying Recurrences in State Space](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P3.html)
* [Assignments Part 4: Complex Networks](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P4.html)

# **Modelling (nonlinear) growth and Deterministic Chaos**

In this assignment you will build two (relatively) simple one-dimensional maps. You can use `R`, `Matlab`, `Python`^[Unless otherwise noted, we will assume you'll use `R` complete the assignments.], or, just start in a spreadsheet if you are more familiar with such an environment. You can use the following [GoogleSheet](https://docs.google.com/spreadsheets/d/1BL_oKoCFH3NQ3qKLBQ-WbkPg_ppSZsyDNl2nS9oPGcM/edit?usp=sharing) as a template, save a copy to your computer, or, copy it to a new on-line Google Sheet, or, use your favourite spreadsheet software (e.g., Excel, Numbers).  

We will start modelling the *Linear Map* and then proceed to the slightly more complicated *Logistic Map* (aka *Quadratic map*). 

\BeginKnitrBlock{rmdnote}<div class="rmdnote">Be sure to check the solutions of the assigments **after** you tried to do them on your own!    
Also, if you want to use `R` to do the assignments, have a look at the examples in [Chapter 2](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/02-MathematicsofChange.html) on different ways to visualize time series in `R`</div>\EndKnitrBlock{rmdnote}

## **The Linear Map**

Equation \@ref(eq:linmap) is the ordinary difference equation (ODE) discussed in [Chapter 2](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/02-MathematicsofChange.html) and is called the *Linear Map*:

\begin{equation}
Y_{t+1} = Y_{t=0} + r*Y_t
(\#eq:linmap)
\end{equation}

In these exercises you will *simulate* time series produced by the change process in equation \@ref(eq:linmap) for different parameter settings of the growth-rate parameter $r$ (the *control parameter*) and the initial conditions $Y_0$. Simulation is obviously different from a statistical analysis in which parameters are estimated from a data set. The goal of these assignments is to get a feeling for what a dynamical model is, and how it is different from a linear statistical regression model like GLM.


### Growth in a Spreadsheet

\BeginKnitrBlock{rmdimportant}<div class="rmdimportant">Before you begin, be sure to check the following settings (same as first asignment): 

* Open a Microsoft Excel worksheet or a [Google sheet](https://www.google.com/docs/about/)
* Check whether the spreadsheet uses a 'decimal-comma' ($0,05$) or 'decimal-point' ($0.05$) notation. 
    + The numbers given in the assignments of this course all use a 'decimal-point' notation.
* Check if the `$` symbol fixes rows and columns when it used in a formula in your preferred spreadsheet program. 
    + This is the default setting in Microsoft Excel and Google Sheets. If you use one of those programs you are all set.</div>\EndKnitrBlock{rmdimportant}


* Open the [GoogleSheet](https://docs.google.com/spreadsheets/d/1BL_oKoCFH3NQ3qKLBQ-WbkPg_ppSZsyDNl2nS9oPGcM/edit?usp=sharing) and look at the **Linear map** tab.
* The `r` in cell `A5` is the *control parameter*. It currently has the value $1.08$ in cell`B5`.
* The cell labelled $Y_0$ in `A6` is the *initial value* at $t=0$. It has the value $0.1$ in cell `B6`.   
* The `A` column also contains $Y_t$, the output of the linear map. 
    + Click on `A10`, in the formula bar you can see this refers to the initial value `B6`.
    + Click on `A11`, in the formula bar you can see the very simple implementation of the linear map.
    + The value of cell `A11` (i.e. $Y_{t=1}$) will be calculated by multiplying the value of cell `B5` (parameter `r`) with the value of cell `A10` (the previous value, here: $Y_{t=0}$).
* Remember what it is we are doing! We are calculating $Y_{t=2}$ (i.e. 'behaviour' in the future) and this is completely determined by $Y_{t=1}$ (i.e., the previous step) and the parameter `r`. 


### Vary the control parameter

* If you change the values in cells `B5` and `B6` you will see an immediate change in the graph. To study model behaviour, try the following growth parameters:
    + $r = -1.08$
    + $r = 1,08$
    + $r = 1$
    + $r = -1$

### Dependence on initial conditions?

* Change the initial value $Y_0$ in cell `B6` to $10$.
* Subsequently give the growth parameter in cell `B5` the following values:
    + $0.95$
    + $-0.95$.


## **The Logistic Map** 

The Logistic Map takes the following functional form: 

\begin{equation}
Y_{t+1} = r*Y_t*(1-Y_t)
(\#eq:logmap)
\end{equation}


### Chaos in a spreadsheet 

* Open the [GoogleSheet](https://docs.google.com/spreadsheets/d/1BL_oKoCFH3NQ3qKLBQ-WbkPg_ppSZsyDNl2nS9oPGcM/edit?usp=sharing) and look at the **Logistic map** tab.
* The set-up is the same as for the linear map, except of course the change process that is implemented.
* The `A` column also contains $Y_t$, the output of the Logistic map, currently the behaviour looks a lot like an S-curve, a logistic function. 
    + Click on `A10`, in the formula bar you can see this refers to the initial value `B6`.
    + Click on `A11`, in the formula bar you can see the very simple implementation of the Logistic map.
    + Again, the value of cell `A11` ($Y_{t=1}$) is calculated by multiplying the value of cell `B5` (parameter `r`) with the value of cell `A10` (the current value $Y_t$, in this case $Y_{t=0}$). The only difference is we are also multiplying by $(1-Y_t)$.

\BeginKnitrBlock{rmdselfThink}<div class="rmdselfThink">We established that `r` controls growth, what could be the function of $(1-Y_t)$?</div>\EndKnitrBlock{rmdselfThink}


### Vary the control parameter 

To study the behaviour of the Logistic Map you can start playing around with the values in `B5`. 

* Try the following settings for $r$:
    + $r = 0.9$
    + $r = 1.9$
    + $r = 2.9$
    + $r = 3.3$
    + $r = 3.52$
    + $r = 3.9$


### The return plot 

* Set $r$ at $4.0$:
    + Now copy `A10:A310` to `B9:B309` (i.e., move it one cell to the right, and one cell up)
    + Select both columns (`A10` to `B309`!) and make a scatter-plot

The plot you just produced is a so called **return plot**, in which you have plotted $Y_{t+1}$ against $Y_t$. 

\BeginKnitrBlock{rmdselfThink}<div class="rmdselfThink">Can you explain the pattern you see (a 'parabola') by looking closely at the functional form of the Logistic Map? (hint: it's also called **Quadratic Map**)</div>\EndKnitrBlock{rmdselfThink}

* What do you expect the return plot of the Linear Map will look like? Go back and try it!


### Sensitive dependence on initial conditions? 

Go to the following [GoogleSheet](https://docs.google.com/spreadsheets/d/1pKFhe5JcXXo6vK-Nx-GvxafaYkEZx31ya57I6xpWWMA/edit?usp=sharing) and download or copy it.

This sheet displays the extreme sensitivity on initial conditions of systems displaying chaotic behaviour, more commonly known as: **The Butterfly Effect**

* Imagine these are observed time series from two subjects in a response time experiment. These subjects are perfect 'twins':
    + The formula describing their behaviour is exactly the same (it's the Quadratic Map, check it!)
    + The control parameter, controlling the behavioural mode is exactly the same ($r=4$).
    + The only difference is that they have a tiny discrepancy in initial conditions in cell `D6` of $0.01$.
* Not tiny enough? Change it to become even smaller:
    + $0.001$
    + $0.0001$
    + $0.00001$
    + etc.
* What happens as you make the discrepancy smaller and smaller?
      
      
## **Using `R` to simulate the maps**

The best (and easiest) way to simulate these simple models is to create a function which takes as input the parameters ($Y_0$, $r$) and a variable indicating the length of the time series.

For example for the Linear Map:

```r
# TEMPLATE
# Modify this function
linearMap <- function(Y0 = 0, r = 1, N = 100){
    
    # Initialize Y as vector of Y0, followed by N-1 empty slots (NA).
    Y <- c(Y0, rep(NA,N-1))
    
    # Then, you need create the iteratation
    for(i in 1:(N-1)){
        
    Y[i+1] <- # !!Implement the linear or Quadratic map here!!
        
    }
    
    return(Y)
}
```


* Copy the code above and implement the linear map.
* When you are done, you need to initialize the function, select the code and run it. 
    + The environment will now contain a function called `linearMap`
    + Generate some data by calling the function using $Y0=0.1$, $r=1.08$ and $N=100$ and store the result in a variable. 


### Plot the timeseries

Creating the time series graphs and the return plot should be easy if the function `linearMap` returns the time series.  `R` and `Matlab` have specialized objects to represent time series, and functions and packages for time series analysis. They are especially convenient for plotting time and date information on the X-axis. See the examples on plotting [time series in Chapter 2](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/02-MathematicsofChange.html).



## **The growth model by Van Geert (1991)**

In this assignment you'll build a more sophisticated growth model and look at its properties. The model will be the growth model by Van Geert (1991).

The growth model by Van Geert has the following form: 

\begin{equation}
L_{t+1} = L_t * (1 + r - r * \frac{L_t}{K})
(\#eq:vanG)
\end{equation}

Note the similarities to Equation \@ref(eq:logmap), the (stylized) logistic map.


### The growth model in a spreadsheet

\BeginKnitrBlock{rmdimportant}<div class="rmdimportant">Before you begin, be sure to check the following settings (same as first asignment): 

* Open a Microsoft Excel worksheet or a [Google sheet](https://www.google.com/docs/about/)
* Check whether the spreadsheet uses a 'decimal-comma' ($0,05$) or 'decimal-point' ($0.05$) notation. 
    + The numbers given in the assignments of this course all use a 'decimal-point' notation.
* Check if the `$` symbol fixes rows and columns when it used in a formula in your preferred spreadsheet program. 
    + This is the default setting in Microsoft Excel and Google Sheets. If you use one of those programs you are all set.</div>\EndKnitrBlock{rmdimportant}

To build it take the sheet in [assignment 1,2](#the-logistic-map) as a template. 

* Define the appropriate constants ($r$ in `A5`, $L_0$ in `A6`) and prepare the necessary things you need for building an iterative process. 
* In particular, add the other parameter that appears in Van Geert's model:
    + Type $K$ in cell `A7`. This is the *carrying capacity*. It receives the value $1$ in cell `B7`.
* Start with the following values:
    + $r = 1.2$
    + $L_0 = 0.01$

Take good notice of what is constant (parameters $r$ and $K$), for which the `$` must be used, and what must change on every iterative step (variable $L_t$). Take about $100$ steps.

* Create the graphs
* You can start playing with the values for the parameters and the initial values in cells `B5`, `B6` and `B7`. To study its behaviour, be sure to try the following growth parameters:
    + $r = 1.2$
    + $r = 2.2$
    + $r = 2.5$
    + $r = 2.7$
    + $r = 2.9$
    
* For the carrying capacity $K$ (cell `B7`) you can try the following values:
    + $K = 1.5$
    + $K = 0.5$. (Leave $r = 2.9$. Mind the value on the vertical axis!)
    
* Changes in the values of $K$ have an effect on the height of the graph. The pattern itself also changes a bit. 
    + Can you explain why this is so?

## **Conditional growth: Jumps and Stages**

### Auto-conditional jumps 

Suppose we want to model that the growth rate $r$ increases after a certain amount has been learned. In general, this is a very common phenomenon, for instance: when becoming proficient at a skill, growth (in proficiency) is at first slow, but then all of a sudden there can be a jump to the appropriate (and sustained) level of proficiency.

* Take the model you just built as a starting point with $r = 0.1$ (`B5`)
    + Type $0.5$ in `C5`. This will be the new parameter value for $r$. 
    + Build your new model in column `B` (leave the original in `A`).
    
*  Suppose we want our parameter to change when a growth level of $0.2$ is reached. We???ll need an `IF` statement which looks something like this: `IF` $L > 0.2$ then use the parameter value in `C5`, otherwise use the parameter value in `B5`. 
    + Excel has a built in `IF` function (may be `ALS` in Dutch). 
    + In the first cell in which calculations should start, press $=$ and then from the formula list choose the `IF` function, or just type it. 
    + Try to figure out what you have to do. In the Logical_test box you should state something which expresses $L > 0.2$.
    + The other fields tell Excel what to do when this statement is `TRUE` (then use parameter value in `C5`) or when it is `FALSE` (then use parameter value in `B5`).
    + __Note:__ the word *value* might be misleading; you can also input new statements.
* Make a graph in which the old and the new conditional models are represented by lines.
    + Try changing the value of $r$ in `C5` into: $1, 2, 2.8, 2.9, 3$. 

### Auto-conditional stages

Another conditional change we might want to explore is that when a certain growth level is reached the carrying capacity K increases, reflecting that new resources have become available to support further growth.

* Now we want $K$ to change, so type $1$ in `B7`, $2$ in `C7`.
* Build your model in column C. Follow the same steps as above, but now make sure that when $L > 0.99$, $K$ changes to the value in `C7`. Keep $r = 0.2$ (`B5`).

* If all goes well you should see two stages when you create a graph of the time series in column `C`. Change $K$ in `C7` to other values.
    + Try to also change the growth rate r after reaching $L > 0.99$ by referring to `C5`. Start with a value of $0.3$ in `C5`. Set $K$ in `C7` to $2$ again. 
    + Also try $1, 2.1, 2.5, 2.6, 3$.

## **Connected growers**

You can now easily model coupled growth processes, in which the values in one series serve as the trigger for for parameter changes in the other process. Try to recreate the Figure of the connected growers printed in the chapter by Van Geert.

### Demonstrations of dynamic modeling using spreadsheets

See the website by [Paul Van Geert](http://www.paulvangeert.nl/research.htm), scroll down to see models of:

* Learning and Teaching
* Behaviour Modification
* Connected Growers
* Interaction during Play


----

# **Multivariate systems**

In this assignment we will look at a 2D coupled dynamical system: **the Predator-Prey model** (aka [Lotka-Volterra equations](https://en.wikipedia.org/wiki/Lotka???Volterra_equations)).

## **The predator-prey model**

The dynamical system is given by the following set of first-order differential equations, one represents changes in a population of predators, (e.g., **F**oxes: $f_F(R_t,F_t)$ ), the other represents changes in a population of prey, (e.g., **R**abbits: $f_R(R_t,F_t)$ ).


\begin{align}
\frac{dR}{dt}&=(a-b*F)*R \\
\\
\frac{dF}{dt}&=(c*R-d)*F
(\#eq:lv)
\end{align}


This is not a *difference* equation but a *differential* equation, which means building this system is not as straightforward as was the case in the previous assignments. Simulation requires a numerical method to 'solve' this differential equation for time, which means we need a method to approach, or estimate continuous time in discrete time. Below you will receive a speed course in one of the simplest numerical procedures for integrating differential equations, the [Euler method](https://en.wikipedia.org/wiki/Euler_method).    


### Euler Method {-}

A general differential equation is given by:

\begin{equation}
\frac{dx}{dt} = f(x)
(\#eq:diff)
\end{equation}

Read it as saying: "_a change in $x$ over a change in time is a function of $x$ itself_". This can be approximated by considering the change to be over some constant, small time step $\Delta$:

\begin{equation}
\frac{(x_{t+1} = x_t)}{\Delta} = f(x_t)
(\#eq:Euler)
\end{equation}


After rearranging the terms a more familiar form reveals itself:

\begin{align}
x_{t+1} &= x_t &= f(x_t) * \Delta \\
x_{t+1} &= f(x_t) * \Delta + x_t
(\#eq:Euler2)
\end{align}


This looks like an ordinary iterative process, $\Delta$ the *time constant* determines the size of time step taken at every successive iteration. For a 2D system with variables **R** and **F** on would write:
    
    
\begin{align}
R_{t+1} &= f_R(R_t,Ft) * \Delta + R_t \\
F_{t+1} &= f_F(R_t,F_t) * \Delta + F_t
(\#eq:EulerRF)
\end{align}
    
    
## **A Coupled System in a spreadsheet**

Implement the model in a spreadsheet by substituting $f_R(R_t,Ft)$ and $f_F(R_t,F_t)$ by the differential equations for Foxes and Rabbits given above.

* Start with $a = d = 1$ and $b = c = 2$ and the initial conditions $R_0 = 0.1$ and $F_0 = 0.1$. Use a time constant of $0.01$ and make at least $1000$ iterations.
* Visualize the dynamics of the system by plotting:
    + $F$ against $R$ (i.e., the state space)
    + $R$ and $F$ against time (i.e., the time series) in one plot.
* Starting from the initial predator and prey population represented by the point $(R, F) = (0.1, 0.1)$, how do the populations evolve over time?
* Try to get a grip on the role of the time constant by increasing and decreasing it slightly (e.g. $\Delta = 0.015$) for fixed parameter values. (You might have to add some more iterations to complete the plot). What happens to the plot? 
    + Hint: Remember that $\Delta$ is not a fundamental part of the dynamics, but that it is only introduced by the numerical integration (i.e., the approximation) of the differential equation. It should not change the dynamics of the system, but it has an effect nonetheless.
    

### Tip of the iceberg {-}

There is much more to tell about dynamic modelling, see Chapter 4 for some more advanced topics. 

----

# **Potential Theory and Catastrophe Models**

* The non-linear regression assignment is written for `SPSS`, but you can try to use 'R' as well. Be sure to look at the solutions of the [Basic Time Series Analysis](#bta)) assignments.
* Using the `cusp` package 

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

```
BetaZY1 = Beta*ZY1	*(Bifurcation, splitting parameter).
ZY1_2 = ZY1 ** 2	*(ZY1 Squared).
ZY1_3 = ZY1 ** 3	*(ZY1 Cubed).
```
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

