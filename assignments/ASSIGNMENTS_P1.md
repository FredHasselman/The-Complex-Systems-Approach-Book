---
title: "DCS Assignments Part I"
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
---




# **Quick Links** {-}

* [Main Assignments Page](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/)
* [Assignments Part 2: Time Series Analysis: Temporal Correlations and Fractal Scaling](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P2.html)
* [Assignments Part 3: Quantifying Recurrences in State Space](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P3.html)
* [Assignments Part 4: Complex Networks](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P4.html)
  
</br>
</br>

# **Modelling (nonlinear) growth and Deterministic Chaos**

In this assignment you will build two (relatively) simple one-dimensional maps based on the models implemented in a spreadsheet. Just copy the linked Google Sheet to a new on-line Google Sheet, or, save it to your computer and use your favourite spreadsheet software (e.g., Excel, Numbers) to explore the behaviour of the model.    
    
We will start by modelling the *Linear Map* and then proceed to the slightly more complicated *Logistic Map* (aka *Quadratic map*). You can use `R`, `Matlab`, or `Python` to model the dynamical processes, but for now we will assume you use `R`.

</br>

\BeginKnitrBlock{rmdnote}<div class="rmdnote">Check the solutions of the assignments **after** you tried to do them on your own!    
  
Also, have a look at the examples in [Chapter 2](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/02-MathematicsofChange.html) on different ways to visualize time series in `R`.</div>\EndKnitrBlock{rmdnote}

</br>

## **The Linear Map**

</br>

Equation \@ref(eq:linmap) is the ordinary difference equation (ODE) discussed in [Chapter 2](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/02-MathematicsofChange.html) and is called the *Linear Map*:
  
\begin{equation}
Y_{i+1} = Y_{i=0} + r*Y_i
(\#eq:linmap)
\end{equation}
  
In these exercises you will *simulate* time series produced by the change process in equation \@ref(eq:linmap) for different parameter settings of the growth-rate parameter $r$ (the *control parameter*) and the initial conditions $Y_0$. *Simulation* is obviously different from a statistical analysis in which parameters are estimated from a data set. The goal of these assignments is to get a feeling for what a dynamical model is, and in what way it is different from a linear statistical regression model like GLM.

</br>

\BeginKnitrBlock{rmdnote}<div class="rmdnote">It is common practice to use $Y_{i}$ for the current state and $Y_{i+1}$ for the next state of a discrete time model (a map, a difference equation). For a continuous time model (a flow, a differential equation), sometimes $Y_{t}$ and $\hat{Y_t}$ are used. More common is the $\delta$, or *'change in'* notation: $\frac{dY}{dt} = Y_0 + r * Y(t)$, which you can pronounce as *'a change in Y over a change in time is a function of ...'*. However, different authors have different preferences and may use other notations.</div>\EndKnitrBlock{rmdnote}
  
</br>

### Growth in a Spreadsheet
  
</br>

\BeginKnitrBlock{rmdimportant}<div class="rmdimportant">If you want to modify the spreadsheets and use them as a template for other assignments, be sure to check the following settings: 
  
* Open a Microsoft Excel worksheet or a [Google sheet](https://www.google.com/docs/about/)
* Check whether the spreadsheet uses a 'decimal-comma' ($0,05$) or 'decimal-point' ($0.05$) notation. 
    + The numbers given in the assignments of this course all use a 'decimal-point' notation.
* Check if the `$` symbol fixes rows and columns when it used in a formula in your preferred spreadsheet program. 
    + This is the default setting in Microsoft Excel and Google Sheets. If you use one of those programs you are all set.</div>\EndKnitrBlock{rmdimportant}

</br>

First study the behaviour of the **Linear map** in a spreadsheet and then try to implement it in `R`.
  
* Open the [GoogleSheet](https://docs.google.com/spreadsheets/d/1EEpUFxEmelJDPDT61jyT_xfntLo_MYBTW0MZuRSC770/edit?usp=sharing) and look at the **Linear map** tab.
* The `r` in cell `A5` is the *control parameter*. It currently has the value $1.08$ in cell`B5`.
* The cell labelled $Y_0$ in `A6` is the *initial value* at $i=0$. It has the value $0.1$ in cell `B6`.   
* The `A` column also contains $Y_i$, the output of the linear map. 
    + Click on `A10`, in the formula bar you can see this refers to the initial value in `B6`. This will be the first input to the iterative process.
    + Click on `A11`, in the formula bar you can see the very simple implementation of the linear map.
    + The value of cell `A11` (i.e. $Y_{i=1}$) will be calculated by multiplying the value of cell `B5` (parameter `r`) with the value of cell `A10` (the previous value, which happens to be: $Y_{i=0}$).
    
</br>

\BeginKnitrBlock{rmdkennen}<div class="rmdkennen">A reminder of what the model represents:     
      
* We are calculating $Y_{i+1}$ (i.e. 'behaviour' in the future, given the current state)
* This value is *completely determined* by $Y_{t=0}$ (i.e., the first 'input') and the value of the control parameter `r` (the growth rate)
* There are no stochastic components involved in generating the temporal evolution of `Y`</div>\EndKnitrBlock{rmdkennen}
  
</br>

### Change the control parameter, label the order parameter  {.tabset .tabset-fade .tabset-pills}

If you make a copy of the Google Sheet you should be able to edit the cells. If this does not work, [download the spreadsheet from GitHub](https://github.com/FredHasselman/The-Complex-Systems-Approach-Book/blob/master/assignments/assignment_data/Iterating1Dmaps/Assignment%20DCS_%20Iterating%201D%20Maps.xlsx)
  
* Change the values in cells `B5` and `B6` and you will see an immediate change in the graph. To study model behaviour, try the following growth parameters:
    + $r =  1.08$
    + $r = -1.08$
    + $r =  1$
    + $r = -1$
    + $r =  0.95$
    + $r = -0.95$

#### Questions {-}
* Are there any *qualitative differences* in the dynamical behaviour of the system that can be attributed parameter values?
* Provide a description for each clearly distinct behaviour displayed by this system (only for the parameter settings you examined). 

#### Answers {-}
* Yes!
    + $r =  1.08$ - Unlimited exponential growth, $Y$ will grow infinitely large
    + $r = -1.08$ - Unstable limit cycle, exponential 2-period oscillation $Y$ will grow infinitely large
    + $r =  1$ - Point attractor, fixed point at $Y = 1$
    + $r = -1$ - Limit cycle, closed period-2 orbit at $Y = [-1,1]$
    + $r =  0.95$ - Exponential decay, $Y$ will approach $0$ in the limit
    + $r = -0.95$ - Point attractor, exponentially decaying 2-period oscillation, $Y$ will approach $0$


\BeginKnitrBlock{rmdkennen}<div class="rmdkennen">The labels assigned to behavioural modes that are clearly qualitatively distinct from one another, are know as the **order parameter**. The **order parameter** will change its value to indicate the system has transitioned to a new behavioural regime. Such changes often occur suddenly with gradual changes in the **control parameter**.     
For example, the four phases that describe matter are an **order parameter** (solid, liquid, gas and plasma). We know water will transition from a liquid state to a gas state if we increase the **control parameter** beyond a certain point (e.g. temperature rises above $100^\circ\text{C}$).

Other names you might encounter that refer to the change of the label of an order parameter:
  
* Phase transition/shift
* Order transition
* Critical transition
* Change of behavioural mode/regime
* Change of attractor state/landscape
* Shift between self-organised/stable states/attractors</div>\EndKnitrBlock{rmdkennen}

</br>

### Dependence on initial conditions? {.tabset .tabset-fade .tabset-pills}
  
* Change the initial value $Y_0$ in cell `B6` to $10$ and compare to $0.1$ (if you want to directly compare different settings, just create a new copy of the sheet)
* Subsequently give the growth parameter in cell `B5` the following values:
    + $r =  1.08$
    + $r = -1.08$
    + $r =  1$
    + $r = -1$
    + $r =  0.95$
    + $r = -0.95$ 
  
#### Questions {-}
* Are there any *qualitative differences* in the dynamical behaviour of the system for each parameter setting, that can be attributed to a difference in initial conditions?
  
#### Answers {-}
* No, there are no differences in the overall dynamics due to changes in initial conditions. Of course, the absolute values change, but 

  
### Using `R` to simulate the Linear Map {.tabset .tabset-fade .tabset-pills}
  
The best (and easiest) way to simulate these simple models in `R` is to create a function, which takes as input arguments the parameters ($Y_0$, $r$) and a variable indicating the length of the time series.

#### Questions {-}

For the Linear Map you could use this template:


```r
# TEMPLATE
# Modify this function
linearMap <- function(Y0 = 0, r = 1, N = 100){
    
    # Initialize Y as vector of Y0, followed by N-1 empty slots (NA).
    Y <- c(Y0, rep(NA,N-1))
    
    # Then, you need create the iteration
    for(i in 1:(N-1)){
        
    Y[i+1] <- # !!Implement the linear or Quadratic map here!!
        
    }
    
    return(Y)
}
```

</br>

* Copy the code to `R` and implement the Linear Map by looking at the formula, or the spreadsheet.
* To test it, you need to initialize the function by selecting the code and running it. 
    + The environment will now contain a function called `linearMap`
* Generate some data by calling the function using $Y0=0.1$, $r=1.08$ and $N=100$ and store the result in a variable. 

#### Answers {-}


```r
# Linear Map
linearMap <- function(Y0 = 0, r = 1, N = 100){
  
  # Initialize Y as vector of Y0, followed by N-1 empty slots (NA).
  Y <- c(Y0, rep(NA,N-1))
  
  # Then, you need create the iteration
  for(i in 1:(N-1)){
    
    Y[i+1] <- r * Y[i] # The linear difference equation
    
    }
  
  return(Y)
}
```

</br>

### Plot the timeseries {.tabset .tabset-fade .tabset-pills}

#### Questions {-}

Creating a time series plot is easy if the function `linearMap` returns the time series as a numeric vector. You could just use:


```r
plot(linearMap(Y0=0.1,r=1.08,N=100), type = "l")
```

#### Answers {-}


```r
plot(linearMap(Y0=0.1,r=1.08,N=100), type = "l")
```

![](ASSIGNMENTS_P1_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

`R` and `Matlab` have specialized objects to represent time series, and functions and packages for time series analysis. These are especially convenient for plotting time and date information on the X-axis. See the examples on plotting [time series in `R` in Chapter 2](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/02-MathematicsofChange.html#plotTS).
  
</br>
</br>

## **The Logistic Map** 
  
The Logistic Map takes the following functional form: 
  
\begin{equation}
Y_{i+1} = r*Y_i*(1-Y_i)
(\#eq:logmap)
\end{equation}
  
### Chaos in a spreadsheet 
  
* Open the [GoogleSheet](https://docs.google.com/spreadsheets/d/1BL_oKoCFH3NQ3qKLBQ-WbkPg_ppSZsyDNl2nS9oPGcM/edit?usp=sharing) and look at the **Logistic map** tab.
* The set-up is the same as for the linear map, except of course the implemented change process.
* The `A` column contains $Y_i$, the output of the Logistic map. With $r=1.3$ the behaviour looks a lot like an S-curve, a logistic function.
* Check the following:
    + Click on `A10`, in the formula bar you can see this refers to the initial value `B6`.
    + Click on `A11`, in the formula bar you can see the very simple implementation of the Logistic map.
    + The value of cell `A11` ($Y_{i=1}$) is calculated by multiplying the value of cell `B5` (parameter `r`) with the value of cell `A10` (the current value $Y_i$, in this case $Y_{i=0}$). The only difference is we are also multiplying by $(1-Y_i)$.

</br>

\BeginKnitrBlock{rmdselfThink}<div class="rmdselfThink">We established that `r` controls growth, what could be the function of $(1-Y_t)$?</div>\EndKnitrBlock{rmdselfThink}

</br>

### Change the control parameter, label the order parameter {.tabset .tabset-fade .tabset-pills}
  
To study the behaviour of the Logistic Map you can start changing the values in `B5`. 
  
* Try the following settings for $r$:
    + $r = 0.9$
    + $r = 1.9$
    + $r = 2.9$
    + $r = 3.3$
    + $r = 3.52$
    + $r = 3.9$

#### Questions {-}
  
* Are there any *qualitative differences* in the dynamical behaviour of the system that can be attributed parameter values?
* Provide a description for each clearly distinct behaviour (the labels of the order parameter) displayed by this system (only for the parameter settings you examined). 
  
#### Answers {-}

* Yes!
* With $Y_0 = 0.01$:
    + $r = 0.9$ - Point attractor, fixed point at $Y = 0$
    + $r = 1.9$ - Point attractor, fixed point at $Y = 0.4737$
    + $r = 2.9$ - Point attractor, fixed point at $Y = 0.6552$
    + $r = 3.3$ - Limit cycle attractor, closed period 2 orbit at $Y =  [0.8236, 0.4794]$
    + $r = 3.52$ - Limit cycle attractor, closed period 4 orbit at $Y =  [0.5121, 0.8795, 0.3731, 0.8233]$
    + $r = 3.9$ - Strange attractor, a-periodic orbit all values between $\approx0.01$ and $\approx0.99$


  
### The return plot {.tabset .tabset-fade .tabset-pills}
  
#### Questions {-}

* Set $r$ at $4.0$:
    + How would you describe the dynamics of the time series? Periodic? Something else?
    + Check the values, is there any value that is recurring, for example like when $r=3.3$? Perhaps if you increase the length of the simulation?
* Select the values in both columns under $Y(i)$ and $Y(i+1)$, (`A10` to `B309`) and create a scatter-plot (no lines, just points).
    + The points should line up to represent a familiar shape...

</br>

\BeginKnitrBlock{rmdkennen}<div class="rmdkennen">The plot you just produced is a so called **return plot**, in which you have plotted $Y_{i+1}$ against $Y_i$. We shifted the time series by 1 time step, which is why this is also called a **lag 1 plot**.    

Can you explain the pattern you see (a 'parabola') by looking closely at the functional form of the Logistic Map? (hint: another name for this equation is the **Quadratic Map**).

If you change the control parameter to a lower value the return plot will seem to display a shape that is no longer a parabola, but this is not the case, all values produced by by the Logistic Map **must** be a point on a parabola. Some parameter settings just do not produce enought different points for the parabola to show itself in the return plot.</div>\EndKnitrBlock{rmdkennen}

</br>

* What do you expect the return plot of the **Linear Map** will look like? Go ahead and try it!

</br>

\BeginKnitrBlock{rmdselfThink}<div class="rmdselfThink">The return plot is an important tool for getting a 'first impression' of the nature of the dynamic process that generated the observed values:
  
* Try to imagine what the lag 1 plot of a cubic difference equation would look like
* What about the return plot for a timeseries of independent random numbers (white noise)?     
* We are of course not limited to a lag of 1, what happens at lag 2, or lag 10 in the return plots of the Linear and Quadratic Map?</div>\EndKnitrBlock{rmdselfThink}

#### Answers {-}

* Set $r$ at $4.0$:
    + The dynamics are called a-periodic, or quasi-periodic, or, chaotic.
    + None of the values will exactly recur!!
* Select the values in both columns under $Y(i)$ and $Y(i+1)$, (`A10` to `B309`) and create a scatter-plot (no lines, just points).
    + The points form a parabola
    + The return plot for both maps can be seen [here](https://docs.google.com/spreadsheets/d/17PBTvGa1Hu9spqEQGuhpwWXGeY7Nujkm09pxcppKPn4/edit?usp=sharing) 


</br>

### Sensitive dependence on initial conditions?  {.tabset .tabset-fade .tabset-pills}
  
Go to the following [GoogleSheet](https://docs.google.com/spreadsheets/d/1pKFhe5JcXXo6vK-Nx-GvxafaYkEZx31ya57I6xpWWMA/edit?usp=sharing) and download or copy it.
  
#### Questions {-}
  
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

</br>


#### Answers {-}

\BeginKnitrBlock{rmdkennen}<div class="rmdkennen">This sheet displays the extreme sensitivity to changes in initial conditions displayed by the Logistic Map for specific parameter settings. This specific phenomenon is more commonly referred to as **The Butterfly Effect**. It is a characteristic of a very interesting and rather mysterious behaviour displayed by deterministic dynamical equations known as **deterministic chaos**.

However, perhaps even more important to notice here, is the fact that a wide range of qualitatively different behaviourial modes can be understood as originating from one and the same, rather simple, dynamical system. The different behavioural modes were observed for different values of a control parameter, which, in real-world models, often represents an observable (physical) quantity (e.g. temperature, available resources, chemical gradient, etc.) 

The Logistic Map is the simplest nontrivial model that can display deterministic chaos.</div>\EndKnitrBlock{rmdkennen}

</br>

### Use `R` to simulate the Logistic Map {.tabset .tabset-fade .tabset-pills}

The best (and easiest) way to simulate the discrete time models is to create a function which takes as input the parameters ($Y_0$, $r$) and a variable indicating the length of the time series.

#### Questions {-}

To model the Logistic Map, use this template:


```r
# TEMPLATE
# Modify this function
logisticMap <- function(Y0 = 0.01, r = 1, N = 100){
    
    # Initialize Y as vector of Y0, followed by N-1 empty slots (NA).
    Y <- c(Y0, rep(NA,N-1))
    
    # Then, you need create the iteratation
    for(i in 1:(N-1)){
        
    Y[i+1] <- # !!Implement the linear or logistic map here!!
        
    }
    
    return(Y)
}
```

</br>

* Copy the code above and implement the Logistic Map.
* When you are done, you need to initialize the function, select the code and run it. 
    + The environment will now contain a function called `logisticMap`
    + Generate some data by calling the function using $Y0=0.1$, $r=4$ and $N=100$ (or any other values you want to explore) and store the result in a variable. 
    

#### Answers {-}


```r
# Logistic Map
logisticMap <- function(Y0 = 0.01, r = 1, N = 100){
    
    # Initialize Y as vector of Y0, followed by N-1 empty slots (NA).
    Y <- c(Y0, rep(NA,N-1))
    
    # Then, you need create the iteratation
    for(i in 1:(N-1)){
        
    Y[i+1] <- r * Y[i] * (1 - Y[i]) # The quadratic difference equation
       
    }
    
    return(Y)
}
```


### Plot the timeseries {.tabset .tabset-fade .tabset-pills}

#### Questions {-}

Creating a time series plot is easy if the function `linearMap` returns the time series as a numeric vector. You could just use:


```r
plot(logisticMap(Y0=0.01,r=1.9,N=100), type = "l")
```

* Also try ro create a graph that demonstrates the sensitive dependence on initial conditions
* Create the lag 1 return plot.
      + Also try to create a lag 2, lag 3 and lag 4 return plot.
      + Can you explain the patterns?


#### Answers {-}


```r
library(plyr)
rs <- c(0.9,1.9,2.9,3.3,3.52,3.9)
op<-par(mfrow=c(2,3))
l_ply(rs,function(r) plot(logisticMap(r=r),ylab = paste("r =",r) ,type = "l"))
```

![](ASSIGNMENTS_P1_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

```r
par(op)
```

* Also try to create a graph that demonstrates the sensitive dependence on initial conditions
* Create the lag 1 return plot.
      + Also try to create a lag 2, lag 3 and lag 4 return plot.
      + Can you explain the patterns?


```r
lags <- c(1,2,3,4)
op <- par(mfrow = c(2,2), pty = "s")
l_ply(lags, function(l) {plot(dplyr::lag(logisticMap(r=4),l), logisticMap(r=4), pch = 16, xlim = c(0,1), ylim = c(0,1), xlab = "Y(t)", ylab = "Y(t+1)",  main = paste("lag =",l))})
```

![](ASSIGNMENTS_P1_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

```r
par(op)
```

</br>

----

</br>
</br>

## **A model of cogntitive growth**

In this assignment you'll build a slightly more sophisticated growth model and study at its properties. The model will be the growth model introduced by [Paul van Geert (1991)](https://eric.ed.gov/?id=EJ494106).

This growth model was used to study growth of language skills in young children, such as vocabulary, and was intended to be to represent 'an ecology of growers' referring to the many motor, perceptual and cognitive skills a child needs to develop in order to become proficient at using a language. It has the following form: 

\begin{equation}
L_{t+1} = L_t * (1 + r - r * \frac{L_t}{K})
(\#eq:vanG)
\end{equation}

</br>

\BeginKnitrBlock{rmdkennen}<div class="rmdkennen">Note the similarities to Equation \@ref(eq:logmap), the (stylized) logistic map. The main difference is that the number $1$ in $(1-Y_i)$ has become a parameter $K$, or, the *carrying capacity* whch indicates how far the function can grow. A more general term used for models of this kind is: *restricted growth model*. </div>\EndKnitrBlock{rmdkennen}

</br>

### The growth model in a spreadsheet

The model is [implemented in a spreadsheet](https://docs.google.com/spreadsheets/d/1DAg0u-zMFOIvRSDOZDxqnzyS0HQJg4FIXzJIMvEMwiI/edit?usp=sharing), select the first tabsheet.

* You can start by changing the values for the parameters and the initial values in cells `B5`, `B6` and `B7`. To study its behaviour, be sure to try the following growth parameters:
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
    
* Implement the model in `R`. 
    + You should be able to do this by slightly modifying you model of the Logistic Map.
    + Make a lag 1 return plot.

</br>
</br>



To model the autocatalytic growth equations we provide a function `growth.ac()`, which is able to simulate all of the processes discussed in the lectures. Using just a few lines of code, each of the 4 difference equations used in the assignments can be simulated. Basically the code block below contains the solutions to the Linear Map, the stylized Logisitc Map and the Van Geert model for cognitive growth.


```r
growth.ac <- function(Y0 = 0.01, r = 1, k = 1, N = 100, type = c("driving", "damping", "logistic", "vanGeert")[1]){
    # Create a vector Y of length N, which has value Y0 at Y[1]
    if(N>1){
    Y <- as.numeric(c(Y0, rep(NA,N-2)))
    # Conditional on the value of type ... 
    switch(type, 
           # Iterate N steps of the difference function with values passed for Y0, k and r.
           driving  = sapply(seq_along(Y), function(t) Y[[t+1]] <<- r * Y[t] ),
           damping  = k + sapply(seq_along(Y), function(t) Y[[t+1]] <<- - r * Y[t]^2 / k),
           logistic = sapply(seq_along(Y), function(t) Y[[t+1]] <<- r * Y[t] * ((k - Y[t]) / k)),
           vanGeert = sapply(seq_along(Y), function(t) Y[[t+1]] <<- Y[t] * (1 + r - r * Y[t] / k)) 
    )}
    return(ts(Y))
}

# Call the function with default settings and r = 1.1
Y <- growth.ac(r = 1.1)
```

Some notes about this function:

* To select which growth process to simulate, the argument `type` is defined which takes the values `driving` (default), `damping`, `logistic` and `vanGeert`. 
    + The statement `switch(type, ...)` will iterate an equation based on the value of `type`.
* A `time series` object is returned due to the function `ts()`. This is a convenient way to represent time series data, it can also store the sample rate of the signal and start and end times.
    + Most of the basic functions, like `plot()` and `summary()` will recognise a time series object when it is passed as an argument and use settings appropriate for time series data.
* The `sapply()` function iterates $t$ from $1$ to the number of elements in $Y$ (`seq_along(Y)`) and then applies the function.
* The double headed arrow `<<-` is necessary because we want to update vector $Y$, which is defined outside the `sapply()` environment.



## **Conditional growth: Jumps and Stages**


### Auto-conditional jumps 

Suppose we want to model that the growth rate $r$ increases after a certain amount has been learned. In general, this is a very common phenomenon, for instance: When becoming proficient at a skill, growth (in proficiency) is at first slow, but then all of a sudden there can be a jump to the appropriate (and sustained) level of proficiency.

* Take the model of the Logistic Map as a starting point.
* Look at the spreadsheet `Van Geert (Jumps)` 
*  Suppose we want our parameter to change when a growth level of $0.2$ is reached. We'll need an `IF` statement which looks something like this: `IF` $L > 0.2$ then use the new parameter value, otherwise use the parameter value we started with. 
    + in Excel this becomes quite complicated using the `IF` function (`ALS` in Dutch). 
    + Implementing the conditional jumps `R` will take on a different (much easier) form.


```r
# TEMPLATE
# Modify this function
vanGeert <- function(L0 = 0, r = 1, K = 2, N = 100){
    
    # Initialize L as vector of Y0, followed by N-1 empty slots (NA).
    L <- c(L0, rep(NA,N-1))
    
    # Then, you need create the iteratation
    for(i in 1:(N-1)){
        
    # You need to monitor the value of L and change the growth rate according to a rule
    if(L[i]>=ThresholdValue){
      r <- 
    } else {
      r <- 
    }
      
    L[i+1] <- # Implement the model here!!
        
    }
    
    return(L)
}
```

</br>

* Copy the code above and implement the Van Geert's model.
* When you are done, you need to initialize the function, select the code and run it. 
    + The environment will now contain a function called `vanGeert`
    + Generate some data, e.g. with $r$ set to $1, 2, 2.8, 2.9, 3$. 
    + *Extra:* Consider making `ThresholdValue` an argument of the function so you can play around with the values.


### Auto-conditional stages

Another conditional change we might want to explore is that when a certain growth level is reached the carrying capacity $K$ increases, reflecting that new resources have become available to support further growth.

* Build your model in such a way that when $L > 0.99$, $K$ changes to the value 2, keep $r = 0.1$
* Try to also to change the growth rate r after reaching $L > 0.99$ 
* Recreate the model on the tab `Van Geert (3 stages)` in `R`

</br>
</br>

## **Connected growers**

You can now easily model coupled growth processes, in which the values in one series serve as the trigger for for parameter changes in the other process. Try to recreate the Figure of the connected growers printed in the chapter by Van Geert.


### Demonstrations of dynamic modeling using spreadsheets

See the website by [Paul Van Geert](http://www.paulvangeert.nl/research.htm), scroll down to see models of:

* Learning and Teaching
* Behaviour Modification
* Connected Growers
* Interaction during Play

</br>

----

</br>
</br>

# **Multivariate systems**

In this assignment we will look at a 2D coupled dynamical system: **the Predator-Prey model** (aka [Lotka-Volterra equations](https://en.wikipedia.org/wiki/Lotka???Volterra_equations)).

</br>
</br>

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
    
</br>
</br>

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

</br>

----

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

