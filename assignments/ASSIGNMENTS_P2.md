---
title: "DCS Assignments Part II"
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
    pandoc_args: ["--number-offset","4"]
    
---





# **Quick Links** {-}

* [Main Assignments Page](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/)
* [Assignments Part 1A: Introduction to the mathematics of change](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P1A.html)
* [Assignments Part 1B: Fitting Parameters and Potential Functions](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P1B.html)
* [Assignments Part 3: Quantifying Recurrences in State Space](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P3.html)
* [Assignments Part 4: Complex Networks](https://darwin.pwo.ru.nl/skunkworks/courseware/1718_DCS/assignments/ASSIGNMENTS_P4.html)
  
</br>
</br>

# **Basic Timeseries Analysis** 

In this course we will not discuss the type of linear time series models known as Autoregressive Models (e.g. AR, ARMA, ARiMA, ARfiMA) summarised on [this Wikipedia page on timeseries](https://en.wikipedia.org/wiki/Time_series#Models). We will in fact be discussing a lot of methods in a book the Wiki page refers to for *'Further references on nonlinear time series analysis'*: [**Nonlinear Time Series Analysis** by Kantz & Schreiber](https://www.cambridge.org/core/books/nonlinear-time-series-analysis/519783E4E8A2C3DCD4641E42765309C7). You do not need to buy the book, but it can be a helpful reference if you want to go beyond the formal level (= mathematics) used in this course. Some of the packages we use are based on the acompanying software [**TiSEAN**](https://www.pks.mpg.de/~tisean/Tisean_3.0.1/index.html) which is written in `C` and `Fortran` and can be called from the commandline (Windows / Linux).


## **Correlation functions**  

Correlation functions are intuitive tools for quantifiying the temporal structure in a time series. As you know, correlation can only quantify linear regularities between variables, which is why we discuss them here as `basic` tools for time series analysis. So what are the variables? In the simplest case, the variables between which we calculate a correlation are between a datapoint at time *t* and a data point that is seperated in time by some *lag*, for example, if you would calculate the correlation in a lag-1 return plot, you would have calculated the 1st value of the correlation function (actually, it is 2nd value, the 1st value is the correlation of time series with itself, the lag-0 correlation, which is of course $r = 1$)  

### ACF and PCF {.tabset .tabset-fade .tabset-pills}


You can do the analyses in SPSS or in `R`, but this analysis is very common so you'll find functions called `acf`, `pacf`and `ccf` in many other statistical software packages,


#### Questions (SPSS/R) {-}

* Download the file [`series.sav`](https://github.com/FredHasselman/The-Complex-Systems-Approach-Book/blob/master/assignments/assignment_data/BasicTSA_arma/series.sav) from Github. 

It contains three time series `TS_1`, `TS_2` and `TS_3`. As a first step look at the mean and the standard deviation (`Analyze` >> `Descriptives`).  Suppose these were time series from three subjects in an experiment, what would you conclude based on the means and SD’s?  

* Let’s visualize these data. Go to `Forecasting` >> `Time Series` >> `Sequence Charts`. Check the box One chart per variable and move all the variables to Variables. Are they really the same?  

* Let’s look at the `ACF` and `PCF`
    + Go to `Analyze` >> `Forecasting` >> `Autocorrelations`. 
    + Enter all the variables and make sure both *Autocorrelations* (ACF) and *Partial autocorrelations* (PACF) boxes are checked. Click `Options`, and change the `Maximum Number of Lags` to `30`. 
    + Use the table to characterize the time series:  


|                    SHAPE                | INDICATED MODEL |
|-----------------------------------------|-------------------------------------------------------------------------------------------------|
|       Exponential, decaying to zero     | Autoregressive model. Use the partial autocorrelation plot to identify the order of the autoregressive model|
| Alternating positive and negative, decaying to zero  | Autoregressive model. Use the partial autocorrelation plot to help identify the order.|
| One or more spikes, rest are essentially zero | Moving average model, order identified by where plot becomes zero. |
| Decay, starting after a few lags | Mixed autoregressive and moving average model.|
All zero or close to zero  | Data is essentially random.|
| High values at fixed intervals | Include seasonal autoregressive term. |
| No decay to zero  | Series is not stationary. |


* In the simulation part of this course we have learned a very simple way to explore the dynamics of a system: The return plot. The time series is plotted against itself shifted by 1 step in time. 

* Create return plots (use a Scatterplot) for the three time series. Tip: You can easily create a `t+1` version of the time series by using the LAG function in a `COMPUTE` statement. For instance:

```
COMPUTE TS_1_lag1 = LAG(TS_1)
```
    
* Are your conclusions about the time series based on interpreting these return plots the same as based on the `acf` and `pacf`?
     
     
#### Answers (SPSS) {-}

If you run this syntax in `SPSS` you'll get the correct output.

```
DESCRIPTIVES
  VARIABLES=TS_1 TS_2 TS_3
  /STATISTICS=MEAN STDDEV MIN MAX .

*Sequence Charts .
TSPLOT VARIABLES= TS_1
  /NOLOG
  /FORMAT NOFILL REFERENCE.
TSPLOT VARIABLES= TS_2
  /NOLOG
  /FORMAT NOFILL REFERENCE.
TSPLOT VARIABLES= TS_3
  /NOLOG
  /FORMAT NOFILL REFERENCE.

*ACF and PCF.

ACF
  VARIABLES= TS_1 TS_2 TS_3
  /NOLOG
  /MXAUTO 30
  /SERROR=IND
  /PACF.


*Return plots.

COMPUTE TS_1_lag1 = LAG(TS_1) .
COMPUTE TS_2_lag1 = LAG(TS_2) .
COMPUTE TS_3_lag1 = LAG(TS_3) .
EXECUTE .


IGRAPH /VIEWNAME='Scatterplot' /X1 = VAR(TS_1_lag1) TYPE = SCALE /Y =
  VAR(TS_1) TYPE = SCALE /COORDINATE = VERTICAL  /X1LENGTH=3.0 /YLENGTH=3.0
  /X2LENGTH=3.0 /CHARTLOOK='NONE' /SCATTER COINCIDENT = NONE.
EXE.

IGRAPH /VIEWNAME='Scatterplot' /X1 = VAR(TS_2_lag1) TYPE = SCALE /Y =
  VAR(TS_2) TYPE = SCALE /COORDINATE = VERTICAL  /X1LENGTH=3.0 /YLENGTH=3.0
  /X2LENGTH=3.0 /CHARTLOOK='NONE' /SCATTER COINCIDENT = NONE.
EXE.

IGRAPH /VIEWNAME='Scatterplot' /X1 = VAR(TS_3_lag1) TYPE = SCALE /Y =
  VAR(TS_3) TYPE = SCALE /COORDINATE = VERTICAL  /X1LENGTH=3.0 /YLENGTH=3.0
  /X2LENGTH=3.0 /CHARTLOOK='NONE' /SCATTER COINCIDENT = NONE.
EXE.

```


#### Notes for `R` {-}

If you want to use `R`, just go through the questions and ignore the `SPSS` specific comments. Here are some tips:

**Importing data in `R`**

By downloading:

1. Follow the link, e.g. for [`series.sav`](https://github.com/FredHasselman/The-Complex-Systems-Approach-Book/blob/master/assignments/assignment_data/BasicTSA_arma/series.sav).
2. On the Github page, find a button marked **Download** (or **Raw** for textfiles).
3. Download the file
4. Load it into `R`


```r
library(rio)
series <- import("series.sav", setclass = "tbl_df")
```


By importing from Github:

1. Copy the `url` associated with the **Download**  button on Github (right-clik).
2. The copied path should contain the word 'raw' somewhere in the url.
3. Call `rio::import(url)`

```r
library(rio)
series <- import("https://github.com/FredHasselman/The-Complex-Systems-Approach-Book/raw/master/assignments/assignment_data/BasicTSA_arma/series.sav", setclass = "tbl_df")
```

You can use the functions in the `stats` package: `arima()`, `acf()` and `pacf()` (`Matlab` has functions that go by slightly different names, check the [Matlab Help pages](https://nl.mathworks.com/help/econ/autocorr.html)). 

There are many extensions to these linear models, check the [`CRAN Task View` on `Time Series Analysis`](https://cran.r-project.org/web/views/TimeSeries.html) to learn more (e.g. about package `zoo` and `forecast`).



### Relative Roughness of the Heart {.tabset .tabset-fade .tabset-pills}

> "We can take it to the end of the *line*     
>  Your love is like a shadow on me all of the *time*     
>  I don't know what to do and I'm always in the dark     
>  We're living in a powder keg and giving off *sparks*"     
>
> --- Bonnie Tyler/James R. Steinman, Total Eclipse of the Heart


Download three different time series of heartbeat intervals (HBI) [here](https://github.com/FredHasselman/The-Complex-Systems-Approach-Book/tree/master/assignments/assignment_data/RelativeRoughness). If you use `R` and have package `rio` installed you can run this code and the load the data into a `data.frame` directly from `Github`.


```r
library(rio)
TS1 <- rio::import("https://github.com/FredHasselman/The-Complex-Systems-Approach-Book/raw/master/assignments/assignment_data/RelativeRoughness/TS1.xlsx", col_names=FALSE)
TS2 <- rio::import("https://github.com/FredHasselman/The-Complex-Systems-Approach-Book/raw/master/assignments/assignment_data/RelativeRoughness/TS2.xlsx", col_names=FALSE)
TS3 <- rio::import("https://github.com/FredHasselman/The-Complex-Systems-Approach-Book/raw/master/assignments/assignment_data/RelativeRoughness/TS3.xlsx", col_names=FALSE)
```

The Excel files did not have any column names, so let's create them in the `data.frame`

```r
colnames(TS1) <- "TS1"
colnames(TS2) <- "TS2"
colnames(TS3) <- "TS3"
```


**The recordings**
These HBI’s were constructed from the[] R-R interbeat intervals](https://www.physionet.org/tutorials/hrv/) in electrocardiogram (ECG) recordings, as defined in Figure \@ref(fig:RRf1).

<div class="figure" style="text-align: center">
<img src="images/RRfig1.png" alt="Definition of Heart Beat Periods." width="862" />
<p class="caption">(\#fig:RRf1)Definition of Heart Beat Periods.</p>
</div>


 * One HBI series is a sample from a male adult, 62 years old (called *Jimmy*). Approximately two years before the recording, the subject has had a coronary artery bypass, as advised by his physician following a diagnosis of congestive heart failure. *Jimmy* used antiarrhythmic medicines at the time of measurement.

 * Another HBI series is a sample from a healthy male adult, 21 years old (called *Tommy*). This subject never reported any cardiac complaint. Tommy was playing the piano during the recording.

 * A third supposed HBI series is fictitious, and was never recorded from a human subject (let’s call this counterfeit *Dummy*).


#### Questions {-}

The assignment is to scrutinise the data and find out which time series belongs to *Jimmy*, *Tommy*, and *Dummy* respectively. ^[The HBI intervals were truncated (not rounded) to a multiple of 10 ms (e.g., an interval of 0.457s is represented as 0.450s), and to 750 data points each. The means and standard deviations among the HBI series are approximately equidistant, which might complicate your challenge.]

The chances that you are an experienced cardiologist are slim. We therefore suggest you proceed your detective work as follows:

*	Construct a graphical representation of the time series, and inspect their dynamics visually ( plot your time series).
* Write down your first guesses about which time series belongs to which subject. Take your time for this visual inspection (i.e., which one looks more like a line than a plane, which one looks more 'smooth' than 'rough').
*	Next, explore some measures of central tendency and dispersion, etc.
*	Third, compute the Relative Roughness for each time series, use Equation \@ref(eq:RR)

\begin{equation}
RR = 2\left[1−\frac{\gamma_1(x_i)}{Var(x_i)}\right]
(\#eq:RR)
\end{equation}

The numerator in the formula stands for the `lag 1` autocovariance of the HBI time series $x_i$. The denominator stands for the (global) variance of $x_i$. Most statistics packages can calculate these variances, `R` and `Matlab` have built in functions. Alternatively, you can create the formula yourself.

*	Compare your (intuitive) visual inspection with these preliminary dynamic quantifications, and find out where each of the HIB series are positions on the ‘colorful spectrum of noises’ (i.e., line them up with Figure \@ref(fig:RRf3)).

<div class="figure" style="text-align: center">
<img src="images/RRfig3.png" alt="Coloured Noise versus Relative Roughness" width="793" />
<p class="caption">(\#fig:RRf3)Coloured Noise versus Relative Roughness</p>
</div>


**What do we know now, that we didn’t knew before?**
Any updates on Jimmy’s, Tommy’s and Dummy’s health? You may start to wonder about the 'meaning' of these dynamics, and not find immediate answers.

Don’t worry; we’ll cover the interpretation over the next two weeks in further depth. Let’s focus the dynamics just a little further for now. It might give you some clues.

* Use the `randperm` function (in `Matlab` or in package  [`pracma`](http://www.inside-r.org/packages/cran/pracma) in `R`) to randomize the temporal ordering of the HBI series. Or try to use the function `sample()`
* Visualize the resulting time series to check whether they were randomized successfully
* Next estimate the Relative Roughness of the randomized series. Did the estimates change compared to your previous outcomes (if so, why)?
* Now suppose you would repeat what you did the previous, but instead of using shuffle you would integrate the fictitious HBI series (i.e., normalize, then use `x=cumsum(x))`. You can look up `cumsum` in `R` or `Matlab`’s Help documentation). Would you get an estimate of Relative Roughness that is approximately comparable with what you got in another HBI series? If so, why?


#### Answers {-}


```r
library(rio)
TS1 <- rio::import("https://github.com/FredHasselman/The-Complex-Systems-Approach-Book/raw/master/assignments/assignment_data/RelativeRoughness/TS1.xlsx", col_names=FALSE)
TS2 <- rio::import("https://github.com/FredHasselman/The-Complex-Systems-Approach-Book/raw/master/assignments/assignment_data/RelativeRoughness/TS2.xlsx", col_names=FALSE)
TS3 <- rio::import("https://github.com/FredHasselman/The-Complex-Systems-Approach-Book/raw/master/assignments/assignment_data/RelativeRoughness/TS3.xlsx", col_names=FALSE)
```

The Excel files did not have any column names, so let's create them in the `data.frame`

```r
colnames(TS1) <- "TS1"
colnames(TS2) <- "TS2"
colnames(TS3) <- "TS3"
```


```r
# Create a function for RR
RR <- function(ts){
# lag.max = n gives autocovariance of lags 0 ... n,
VAR  <- acf(ts, lag.max = 1, type = 'covariance', plot=FALSE)
# RR formula
RelR   <- 2*(1-VAR$acf[2] / VAR$acf[1])
# Add some attributes to the output
attributes(RelR) <- list(localAutoCoVariance = VAR$acf[2], globalAutoCoVariance = VAR$acf[1])
return(RelR)
}

# Look at the results
for(ts in list(TS1,TS2,TS3)){
  relR <- RR(ts[,1])
  cat(paste0(colnames(ts),": RR = ",round(relR,digits=3), " = 2*(1-",
         round(attributes(relR)$localAutoCoVariance, digits = 4),"/",
         round(attributes(relR)$globalAutoCoVariance,digits = 4),")\n"))
  }
```

```
## TS1: RR = 0.485 = 2*(1-0.0016/0.0021)
## TS2: RR = 0.118 = 2*(1-0.0018/0.0019)
## TS3: RR = 2.052 = 2*(1--1e-04/0.002)
```

Use Figure \@ref(fig:RRf3) to lookup which value of $RR$ corresponds to which type of dynamics:

**TS1**: Pink noise
**TS2**: Brownian noise
**TS3**: White noise



**Randomize**

To randomize the data you may use the function `sample` (which is easier than `randperm`)


```r
library(pracma)
# randperm()
TS1Random <- TS1$TS1[randperm(length(TS1$TS1))]

# sample()
TS1Random <- sample(TS1$TS1, length(TS1$TS1))
TS2Random <- sample(TS2$TS2, length(TS2$TS2))
TS3Random <- sample(TS3$TS3, length(TS3$TS3))


plot.ts(TS1Random)
lines(ts(TS1$TS1),col="red3")
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

If you repeat this for TS2 and TS3 and compute the Relative Roughness of each randomized time series, the outcomes should be around 2, white noise! This makes sense, you destroyed all the correlations in the data by removing the temporal order with which values were observed.


```r
cat("TS1random\n")
```

```
## TS1random
```

```r
cat(RR(TS1Random))
```

```
## 2.046686
```

```r
cat("\nTS2random\n")
```

```
## 
## TS2random
```

```r
cat(RR(TS2Random))
```

```
## 1.997709
```

```r
cat("\nTS3random\n")
```

```
## 
## TS3random
```

```r
cat(RR(TS3Random))
```

```
## 2.034602
```

**Integrate**

Normalize the white noise time series

```r
TS3Norm <- scale(TS3$TS3)
```

Now integrate it, which just means, 'take the cumulative sum'.

```r
TS3Int <- cumsum(TS3Norm)
plot.ts(TS3Int)
lines(ts(TS3Norm),col="red3")
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

If you compute the Relative Roughness of the integrated time series, the outcome should be close to 0, Brownian noise.

```r
cat("\nTS3Int\n")
```

```
## 
## TS3Int
```

```r
cat(RR(TS3Int))
```

```
## 0.02783704
```


### Sample Entropy  {.tabset .tabset-fade .tabset-pills}

Use the `sample_entropy()` function in package `pracma`.

#### Questions {-}

* Calculate the Sample Entropy of the two sets of three timeseries you now have.
    + Use your favourite function to estimate the sample entropy of the three time series. Use for instance a segment length `edim` of 3 datapoints, and a tolerance range `r` of 1 * the standard deviation of the series. What values do you observe?
    + Can you change the absolute SampEn outcomes by 'playing' with the m parameter? If so, how does the outcome change, and why?
    + Can you change the absolute SampEn outcomes by 'playing' with the r parameter If so, how does the outcome change, and why?
    + Do changes in the relative SampEn outcome change the outcomes for the three time series relative to each other?

*	Extra: Go back to the assignment where you generated simulated time series from the logistic map.


#### Answers {-}

Change some of the parameters.


```r
library(rio)
library(pracma)

# ACF assignment data `series`
cat(paste0("\nseries.TS1 m=3\n",sample_entropy(series$TS_1, edim = 3, r = sd(series$TS_1))))
## 
## series.TS1 m=3
## 0.652582760511648
cat(paste0("\nseries.TS2 m=3\n",sample_entropy(series$TS_2, edim = 3, r = sd(series$TS_2))))
## 
## series.TS2 m=3
## 0.195888185092471
cat(paste0("\nseries.TS3 m=3\n",sample_entropy(series$TS_3, edim = 3, r = sd(series$TS_3))))
## 
## series.TS3 m=3
## 0.528115883767288


# ACF assignment data `series`
cat(paste0("\nseries.TS1 m=6\n",sample_entropy(series$TS_1, edim = 6, r = sd(series$TS_1))))
## 
## series.TS1 m=6
## 0.676004479826967
cat(paste0("\nseries.TS2 m=6\n",sample_entropy(series$TS_2, edim = 6, r = sd(series$TS_2))))
## 
## series.TS2 m=6
## 0.167801266934409
cat(paste0("\nseries.TS3 m=6\n",sample_entropy(series$TS_3, edim = 6, r = sd(series$TS_3))))
## 
## series.TS3 m=6
## 0.527677852462416


# ACF assignment data `series`
cat(paste0("\nseries.TS1 m=6, r=.5\n",sample_entropy(series$TS_1, edim = 3, r = .5*sd(series$TS_1))))
## 
## series.TS1 m=6, r=.5
## 1.26945692316692
cat(paste0("\nseries.TS2 m=6, r=.5\n",sample_entropy(series$TS_2, edim = 3, r = .5*sd(series$TS_2))))
## 
## series.TS2 m=6, r=.5
## 0.641584864066123
cat(paste0("\nseries.TS3 m=6, r=.5\n",sample_entropy(series$TS_3, edim = 3, r = .5*sd(series$TS_3))))
## 
## series.TS3 m=6, r=.5
## 0.5894301000077
```

The change of `m` keeps the relaive order, change of `r` for the same `m` does not.

**Values of other time series**


```r

# RR assignment data `TS1,TS2,TS3`
cat(paste0("\nTS1\n",sample_entropy(TS1$TS1, edim = 3, r = sd(TS1$TS1))))
## 
## TS1
## 0.260297595725622
cat(paste0("TS1Random\n",sample_entropy(TS1Random, edim = 3, r = sd(TS1Random))))
## TS1Random
## 0.634738107184503

cat(paste0("\nTS2\n",sample_entropy(TS2$TS2, edim = 3, r = sd(TS2$TS2))))
## 
## TS2
## 0.0477314028211898
cat(paste0("TS2Random\n",sample_entropy(TS2Random, edim = 3, r = sd(TS2Random))))
## TS2Random
## 0.58180240485767

cat(paste0("\nTS3\n",sample_entropy(TS3$TS3, edim = 3, r = sd(TS3$TS3))))
## 
## TS3
## 0.612955347930071
cat(paste0("TS3Int\n",sample_entropy(TS3Norm, edim = 3, r = sd(TS3Norm))))
## TS3Int
## 0.612955347930071


# Logistic map
library(casnet)
cat("\nLogistic map\nr=2.9\n")
## 
## Logistic map
## r=2.9
y1<-growth_ac(r = 2.9,type="logistic")
sample_entropy(y1, edim = 3, r = sd(y1))
## [1] 0.0002390343
cat("\nLogistic map\nr=4\n")
## 
## Logistic map
## r=4
y2<-growth_ac(r = 4,type="logistic")
sample_entropy(y2, edim = 3, r = sd(y2))
## [1] 0.5293149
```



## **Fluctuation analyses**

Install package `casnet` to use the functions `fd_sda()`, `fd_psd()` and `fd_dfa()`.


```r
# Install casnet if necessary: https://github.com/FredHasselman/casnet
# !!Warning!! Very Beta...
# Auto config of Marwan's commandline rqa works on Windows, MacOS and probably Linux as well
library(devtools)
ifelse("casnet"%in%installed.packages(),library(casnet),devtools::install_github("FredHasselman/casnet"))
```

```
## [1] "devtools"
```

###  Standardised Dispersion Analysis {.tabset .tabset-fade .tabset-pills}


#### Questions {-}

* Common data preparation before running fluctuation analyses:
    + Normalize the time series (using `sd` based on `N`, not `N-1`)
    + Check whether time series length is a power of `2`. If you use `N <- log2(length(y))`, the number you get is `2^N`. You need an integer power for the length in order to create equal bin sizes. You can padd the series with 0s, or make it shorter before analysis.
* Perform `sda` on the 3 HRV timeseries, or any of the other series you already analysed.
* Compare to what you find for `sda` to the other measures (`RR`,`SampEn`, `acf`, `pacf`)


#### Answers {-}



```r
library(rio)
library(pracma)
library(casnet)

# ACF assignment data `series`
cat(paste0("\nseries.TS1 m=3\n",fd_sda(series$TS_1, doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-1.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-2.png)<!-- -->

```
## 
## series.TS1 m=3
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1.00048863916916, 0.698072619354232, 0.468778807482939, 0.327856201643399, 0.205170105827264, 0.115717944242596, 0.0936095404167764, 0.0768720895384629, 0.0281256004293065, 0.0162244807120432)) 
## series.TS1 m=3
## list(sap = -0.6378456980678, H = 0.3621543019322, FD = 1.6378456980678, fitlm1 = list(coefficients = c(0.129663467739614, -0.6378456980678), residuals = c(-0.129174947915699, -0.0469746629336486, -0.00304582086589474, 0.0815191976529704, 0.0549044618509935, -0.0756582954591311, 0.154439242585115, 0.399570749761866, -0.163770959843595, -0.271808964832976), effects = c(5.8814594882136, -4.01576292746785, 0.0299552105750072, 0.113134361860518, 0.0851337588251866, -0.0468148657182923, 0.181896805092599, 
## 0.425642445035996, -0.139085131802819, -0.248509004025554), rank = 2, fitted.values = c(0.129663467739613, -0.312457479508373, -0.754578426756358, -1.19669937400434, -1.63882032125233, -2.08094126850032, -2.5230622157483, -2.96518316299629, -3.40730411024427, -3.84942505749226), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 
## -9.86365729932036, 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.00048851982391331, -0.359432142442021, -0.757624247622253, 
## -1.11518017635137, -1.58391585940134, -2.15659956395945, -2.36862297316319, -2.56561241323442, -3.57107507008787, -4.12123402232523), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS1 m=3
## list(sap = -0.561179556800627, H = 0.438820443199373, FD = 1.56117955680063, fitlm2 = list(coefficients = c(-0.0018822604989444, -0.561179556800627), residuals = c(0.00237078032285807, 0.0314301456411573, 0.0222180680451607, 0.0536421669002746, -0.0261134885654534, -0.209817165539329, -0.0328605471588342, 0.159130040354166), effects = c(3.85602965016425, -2.52087869563296, 0.0193613424982444, 0.0546050390705098, -0.0213310186780667, -0.201215097934791, -0.0204388818371446, 0.175371303393007), rank = 2, 
##     fitted.values = c(-0.00188226049894476, -0.390862288083179, -0.779842315667414, -1.16882234325165, -1.55780237083588, -1.94678239842012, -2.33576242600435, -2.72474245358859), assign = 0:1, qr = list(qr = c(-2.82842712474619, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, -6.86180700427983, 4.4921071430415, 0.0903888096881914, -0.0639145402739005, -0.218217890235992, -0.372521240198084, -0.526824590160176, -0.681127940122268
##     ), qraux = c(1.35355339059327, 1.24469215965028), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 6, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.00048851982391331, -0.359432142442021, -0.757624247622253, -1.11518017635137, -1.58391585940134, -2.15659956395945, -2.36862297316319, -2.56561241323442), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 
##     2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962)))) 
## series.TS1 m=3
## list(sd = c(1.00048863916916, 0.698072619354232, 0.468778807482939, 0.327856201643399, 0.205170105827264, 0.115717944242596, 0.0936095404167764, 0.0768720895384629, 0.0281256004293065, 0.0162244807120432), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
cat(paste0("\nseries.TS2 m=3\n",fd_sda(series$TS_2, doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-3.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-4.png)<!-- -->

```
## 
## series.TS2 m=3
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1.00048863916916, 0.955390236316598, 0.934404804336079, 0.921081298175831, 0.905975383127022, 0.831848960026241, 0.73852047940931, 0.0513407102679796, 0.0353765803791022, 0.0418458427863038)) 
## series.TS2 m=3
## list(sap = -0.584911757983907, H = 0.415088242016093, FD = 1.58491175798391, fitlm1 = list(coefficients = c(0.797845441383309, -0.584911757983907), residuals = c(-0.797356921559395, -0.438050903010743, -0.0548310948320929, 0.336237391397863, 0.725131158058544, 1.0451998451602, 1.33162772784804, -0.929107158965294, -0.896111202989072, -0.322738841108048), effects = c(3.24636031554265, -3.68250026717613, 0.167142503621275, 0.536781023244981, 0.904244823299413, 1.20288354379482, 1.46788145987641, -0.814283393543173, 
## -0.802717404173201, -0.250775008898426), rank = 2, fitted.values = c(0.797845441383308, 0.392415505460403, -0.0130144304625032, -0.418444366385409, -0.823874302308315, -1.22930423823122, -1.63473417415413, -2.04016411007703, -2.44559404599994, -2.85102398192284), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, -9.86365729932036, 
## 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.00048851982391331, -0.0456353975503407, -0.0678455252945962, -0.0822069749875465, 
## -0.0987431442497712, -0.184104393071022, -0.303106446306088, -2.96927126904233, -3.34170524898901, -3.17376282303089), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS2 m=3
## list(sap = -0.385422618948269, H = 0.614577381051731, FD = 1.38542261894827, fitlm2 = list(coefficients = c(0.466238026933358, -0.385422618948269), residuals = c(-0.465749507109444, -0.244718822835676, 0.000225651068091859, 0.253018803023164, 0.503637235408963, 0.685430588235734, 0.833583136648691, -1.56542708443952), effects = c(1.32597534434066, -1.73135969966728, 0.130818007406939, 0.368355121076776, 0.603717515177339, 0.770254829718875, 0.903151339846597, -1.51111491952685), rank = 2, fitted.values = c(0.466238026933357, 
## 0.199083425285335, -0.068071176362688, -0.335225778010711, -0.602380379658734, -0.869534981306757, -1.13668958295478, -1.4038441846028), assign = 0:1, qr = list(qr = c(-2.82842712474619, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, -6.86180700427983, 4.4921071430415, 0.0903888096881914, -0.0639145402739005, -0.218217890235992, -0.372521240198084, -0.526824590160176, -0.681127940122268), qraux = c(1.35355339059327, 
## 1.24469215965028), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 6, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.00048851982391331, -0.0456353975503407, -0.0678455252945962, -0.0822069749875465, -0.0987431442497712, -0.184104393071022, -0.303106446306088, -2.96927126904233), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 
## 3.46573590279973, 4.15888308335967, 4.85203026391962)))) 
## series.TS2 m=3
## list(sd = c(1.00048863916916, 0.955390236316598, 0.934404804336079, 0.921081298175831, 0.905975383127022, 0.831848960026241, 0.73852047940931, 0.0513407102679796, 0.0353765803791022, 0.0418458427863038), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
cat(paste0("\nseries.TS3 m=3\n",fd_sda(series$TS_3, doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-5.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-6.png)<!-- -->

```
## 
## series.TS3 m=3
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1.00048863916916, 0.70391263003542, 0.45286985910729, 0.334850283921018, 0.213588205385402, 0.129313242224143, 0.0996072186880589, 0.053950671439504, 0.043153955124514, 0.0137251117213528)) 
## series.TS3 m=3
## list(sap = -0.637593769153149, H = 0.362406230846851, FD = 1.63759376915315, fitlm1 = list(coefficients = c(0.140381168163978, -0.637593769153149), residuals = c(-0.139892648340065, -0.0495358803219715, -0.0486390028145079, 0.0913860414079538, 0.0836987339065801, 0.0238328652696899, 0.204776132192427, 0.0335579540868244, 0.2522082135276, -0.451392408914531), effects = c(5.84508220311535, -4.01417682788471, -0.0130647062506228, 0.125575665600444, 0.116503685727675, 0.0552531447193892, 0.234811739270731, 
## 0.0622088887937333, 0.279474475863114, -0.425510818950412), rank = 2, fitted.values = c(0.140381168163978, -0.301565155267117, -0.74351147869821, -1.1854578021293, -1.6274041255604, -2.06935044899149, -2.51129677242259, -2.95324309585368, -3.39518941928478, -3.83713574271587), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, -9.86365729932036, 
## 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.00048851982391331, -0.351101035589088, -0.792150481512718, -1.09407176072135, 
## -1.54370539165382, -2.0455175837218, -2.30652064023016, -2.91968514176686, -3.14298120575717, -4.2885281516304), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS3 m=3
## list(sap = -0.591299702035941, H = 0.408700297964059, FD = 1.59129970203594, fitlm2 = list(coefficients = c(0.0529690852410343, -0.591299702035941), residuals = c(-0.0524805654171206, 0.00578760050202523, -0.0254041240894556, 0.0825323180340603, 0.042756408433741, -0.0491980623020949, 0.0996566025216965, -0.103650177682852), effects = c(3.90756523959006, -2.65618161519396, -0.0131117652653227, 0.0972415443924478, 0.0598825023263829, -0.0296551008751985, 0.121616431482847, -0.0792734811874465), rank = 2, 
##     fitted.values = c(0.0529690852410339, -0.356888636091114, -0.766746357423263, -1.17660407875541, -1.58646180008756, -1.99631952141971, -2.40617724275186, -2.816034964084), assign = 0:1, qr = list(qr = c(-2.82842712474619, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, -6.86180700427983, 4.4921071430415, 0.0903888096881914, -0.0639145402739005, -0.218217890235992, -0.372521240198084, -0.526824590160176, -0.681127940122268
##     ), qraux = c(1.35355339059327, 1.24469215965028), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 6, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.00048851982391331, -0.351101035589088, -0.792150481512718, -1.09407176072135, -1.54370539165382, -2.0455175837218, -2.30652064023016, -2.91968514176686), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 
##     2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962)))) 
## series.TS3 m=3
## list(sd = c(1.00048863916916, 0.70391263003542, 0.45286985910729, 0.334850283921018, 0.213588205385402, 0.129313242224143, 0.0996072186880589, 0.053950671439504, 0.043153955124514, 0.0137251117213528), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))


# ACF assignment data `series`
cat(paste0("\nseries.TS1 m=6\n",fd_sda(series$TS_1,  doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-7.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-8.png)<!-- -->

```
## 
## series.TS1 m=6
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1.00048863916916, 0.698072619354232, 0.468778807482939, 0.327856201643399, 0.205170105827264, 0.115717944242596, 0.0936095404167764, 0.0768720895384629, 0.0281256004293065, 0.0162244807120432)) 
## series.TS1 m=6
## list(sap = -0.6378456980678, H = 0.3621543019322, FD = 1.6378456980678, fitlm1 = list(coefficients = c(0.129663467739614, -0.6378456980678), residuals = c(-0.129174947915699, -0.0469746629336486, -0.00304582086589474, 0.0815191976529704, 0.0549044618509935, -0.0756582954591311, 0.154439242585115, 0.399570749761866, -0.163770959843595, -0.271808964832976), effects = c(5.8814594882136, -4.01576292746785, 0.0299552105750072, 0.113134361860518, 0.0851337588251866, -0.0468148657182923, 0.181896805092599, 
## 0.425642445035996, -0.139085131802819, -0.248509004025554), rank = 2, fitted.values = c(0.129663467739613, -0.312457479508373, -0.754578426756358, -1.19669937400434, -1.63882032125233, -2.08094126850032, -2.5230622157483, -2.96518316299629, -3.40730411024427, -3.84942505749226), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 
## -9.86365729932036, 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.00048851982391331, -0.359432142442021, -0.757624247622253, 
## -1.11518017635137, -1.58391585940134, -2.15659956395945, -2.36862297316319, -2.56561241323442, -3.57107507008787, -4.12123402232523), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS1 m=6
## list(sap = -0.561179556800627, H = 0.438820443199373, FD = 1.56117955680063, fitlm2 = list(coefficients = c(-0.0018822604989444, -0.561179556800627), residuals = c(0.00237078032285807, 0.0314301456411573, 0.0222180680451607, 0.0536421669002746, -0.0261134885654534, -0.209817165539329, -0.0328605471588342, 0.159130040354166), effects = c(3.85602965016425, -2.52087869563296, 0.0193613424982444, 0.0546050390705098, -0.0213310186780667, -0.201215097934791, -0.0204388818371446, 0.175371303393007), rank = 2, 
##     fitted.values = c(-0.00188226049894476, -0.390862288083179, -0.779842315667414, -1.16882234325165, -1.55780237083588, -1.94678239842012, -2.33576242600435, -2.72474245358859), assign = 0:1, qr = list(qr = c(-2.82842712474619, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, -6.86180700427983, 4.4921071430415, 0.0903888096881914, -0.0639145402739005, -0.218217890235992, -0.372521240198084, -0.526824590160176, -0.681127940122268
##     ), qraux = c(1.35355339059327, 1.24469215965028), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 6, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.00048851982391331, -0.359432142442021, -0.757624247622253, -1.11518017635137, -1.58391585940134, -2.15659956395945, -2.36862297316319, -2.56561241323442), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 
##     2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962)))) 
## series.TS1 m=6
## list(sd = c(1.00048863916916, 0.698072619354232, 0.468778807482939, 0.327856201643399, 0.205170105827264, 0.115717944242596, 0.0936095404167764, 0.0768720895384629, 0.0281256004293065, 0.0162244807120432), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
cat(paste0("\nseries.TS2 m=6\n",fd_sda(series$TS_2,  doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-9.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-10.png)<!-- -->

```
## 
## series.TS2 m=6
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1.00048863916916, 0.955390236316598, 0.934404804336079, 0.921081298175831, 0.905975383127022, 0.831848960026241, 0.73852047940931, 0.0513407102679796, 0.0353765803791022, 0.0418458427863038)) 
## series.TS2 m=6
## list(sap = -0.584911757983907, H = 0.415088242016093, FD = 1.58491175798391, fitlm1 = list(coefficients = c(0.797845441383309, -0.584911757983907), residuals = c(-0.797356921559395, -0.438050903010743, -0.0548310948320929, 0.336237391397863, 0.725131158058544, 1.0451998451602, 1.33162772784804, -0.929107158965294, -0.896111202989072, -0.322738841108048), effects = c(3.24636031554265, -3.68250026717613, 0.167142503621275, 0.536781023244981, 0.904244823299413, 1.20288354379482, 1.46788145987641, -0.814283393543173, 
## -0.802717404173201, -0.250775008898426), rank = 2, fitted.values = c(0.797845441383308, 0.392415505460403, -0.0130144304625032, -0.418444366385409, -0.823874302308315, -1.22930423823122, -1.63473417415413, -2.04016411007703, -2.44559404599994, -2.85102398192284), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, -9.86365729932036, 
## 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.00048851982391331, -0.0456353975503407, -0.0678455252945962, -0.0822069749875465, 
## -0.0987431442497712, -0.184104393071022, -0.303106446306088, -2.96927126904233, -3.34170524898901, -3.17376282303089), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS2 m=6
## list(sap = -0.385422618948269, H = 0.614577381051731, FD = 1.38542261894827, fitlm2 = list(coefficients = c(0.466238026933358, -0.385422618948269), residuals = c(-0.465749507109444, -0.244718822835676, 0.000225651068091859, 0.253018803023164, 0.503637235408963, 0.685430588235734, 0.833583136648691, -1.56542708443952), effects = c(1.32597534434066, -1.73135969966728, 0.130818007406939, 0.368355121076776, 0.603717515177339, 0.770254829718875, 0.903151339846597, -1.51111491952685), rank = 2, fitted.values = c(0.466238026933357, 
## 0.199083425285335, -0.068071176362688, -0.335225778010711, -0.602380379658734, -0.869534981306757, -1.13668958295478, -1.4038441846028), assign = 0:1, qr = list(qr = c(-2.82842712474619, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, -6.86180700427983, 4.4921071430415, 0.0903888096881914, -0.0639145402739005, -0.218217890235992, -0.372521240198084, -0.526824590160176, -0.681127940122268), qraux = c(1.35355339059327, 
## 1.24469215965028), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 6, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.00048851982391331, -0.0456353975503407, -0.0678455252945962, -0.0822069749875465, -0.0987431442497712, -0.184104393071022, -0.303106446306088, -2.96927126904233), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 
## 3.46573590279973, 4.15888308335967, 4.85203026391962)))) 
## series.TS2 m=6
## list(sd = c(1.00048863916916, 0.955390236316598, 0.934404804336079, 0.921081298175831, 0.905975383127022, 0.831848960026241, 0.73852047940931, 0.0513407102679796, 0.0353765803791022, 0.0418458427863038), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
cat(paste0("\nseries.TS3 m=6\n",fd_sda(series$TS_3,  doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-11.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-12.png)<!-- -->

```
## 
## series.TS3 m=6
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1.00048863916916, 0.70391263003542, 0.45286985910729, 0.334850283921018, 0.213588205385402, 0.129313242224143, 0.0996072186880589, 0.053950671439504, 0.043153955124514, 0.0137251117213528)) 
## series.TS3 m=6
## list(sap = -0.637593769153149, H = 0.362406230846851, FD = 1.63759376915315, fitlm1 = list(coefficients = c(0.140381168163978, -0.637593769153149), residuals = c(-0.139892648340065, -0.0495358803219715, -0.0486390028145079, 0.0913860414079538, 0.0836987339065801, 0.0238328652696899, 0.204776132192427, 0.0335579540868244, 0.2522082135276, -0.451392408914531), effects = c(5.84508220311535, -4.01417682788471, -0.0130647062506228, 0.125575665600444, 0.116503685727675, 0.0552531447193892, 0.234811739270731, 
## 0.0622088887937333, 0.279474475863114, -0.425510818950412), rank = 2, fitted.values = c(0.140381168163978, -0.301565155267117, -0.74351147869821, -1.1854578021293, -1.6274041255604, -2.06935044899149, -2.51129677242259, -2.95324309585368, -3.39518941928478, -3.83713574271587), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, -9.86365729932036, 
## 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.00048851982391331, -0.351101035589088, -0.792150481512718, -1.09407176072135, 
## -1.54370539165382, -2.0455175837218, -2.30652064023016, -2.91968514176686, -3.14298120575717, -4.2885281516304), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS3 m=6
## list(sap = -0.591299702035941, H = 0.408700297964059, FD = 1.59129970203594, fitlm2 = list(coefficients = c(0.0529690852410343, -0.591299702035941), residuals = c(-0.0524805654171206, 0.00578760050202523, -0.0254041240894556, 0.0825323180340603, 0.042756408433741, -0.0491980623020949, 0.0996566025216965, -0.103650177682852), effects = c(3.90756523959006, -2.65618161519396, -0.0131117652653227, 0.0972415443924478, 0.0598825023263829, -0.0296551008751985, 0.121616431482847, -0.0792734811874465), rank = 2, 
##     fitted.values = c(0.0529690852410339, -0.356888636091114, -0.766746357423263, -1.17660407875541, -1.58646180008756, -1.99631952141971, -2.40617724275186, -2.816034964084), assign = 0:1, qr = list(qr = c(-2.82842712474619, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, -6.86180700427983, 4.4921071430415, 0.0903888096881914, -0.0639145402739005, -0.218217890235992, -0.372521240198084, -0.526824590160176, -0.681127940122268
##     ), qraux = c(1.35355339059327, 1.24469215965028), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 6, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.00048851982391331, -0.351101035589088, -0.792150481512718, -1.09407176072135, -1.54370539165382, -2.0455175837218, -2.30652064023016, -2.91968514176686), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 
##     2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962)))) 
## series.TS3 m=6
## list(sd = c(1.00048863916916, 0.70391263003542, 0.45286985910729, 0.334850283921018, 0.213588205385402, 0.129313242224143, 0.0996072186880589, 0.053950671439504, 0.043153955124514, 0.0137251117213528), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))


# ACF assignment data `series`
cat(paste0("\nseries.TS1 m=6, r=.5\n",fd_sda(series$TS_1, doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-13.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-14.png)<!-- -->

```
## 
## series.TS1 m=6, r=.5
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1.00048863916916, 0.698072619354232, 0.468778807482939, 0.327856201643399, 0.205170105827264, 0.115717944242596, 0.0936095404167764, 0.0768720895384629, 0.0281256004293065, 0.0162244807120432)) 
## series.TS1 m=6, r=.5
## list(sap = -0.6378456980678, H = 0.3621543019322, FD = 1.6378456980678, fitlm1 = list(coefficients = c(0.129663467739614, -0.6378456980678), residuals = c(-0.129174947915699, -0.0469746629336486, -0.00304582086589474, 0.0815191976529704, 0.0549044618509935, -0.0756582954591311, 0.154439242585115, 0.399570749761866, -0.163770959843595, -0.271808964832976), effects = c(5.8814594882136, -4.01576292746785, 0.0299552105750072, 0.113134361860518, 0.0851337588251866, -0.0468148657182923, 0.181896805092599, 
## 0.425642445035996, -0.139085131802819, -0.248509004025554), rank = 2, fitted.values = c(0.129663467739613, -0.312457479508373, -0.754578426756358, -1.19669937400434, -1.63882032125233, -2.08094126850032, -2.5230622157483, -2.96518316299629, -3.40730411024427, -3.84942505749226), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 
## -9.86365729932036, 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.00048851982391331, -0.359432142442021, -0.757624247622253, 
## -1.11518017635137, -1.58391585940134, -2.15659956395945, -2.36862297316319, -2.56561241323442, -3.57107507008787, -4.12123402232523), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS1 m=6, r=.5
## list(sap = -0.561179556800627, H = 0.438820443199373, FD = 1.56117955680063, fitlm2 = list(coefficients = c(-0.0018822604989444, -0.561179556800627), residuals = c(0.00237078032285807, 0.0314301456411573, 0.0222180680451607, 0.0536421669002746, -0.0261134885654534, -0.209817165539329, -0.0328605471588342, 0.159130040354166), effects = c(3.85602965016425, -2.52087869563296, 0.0193613424982444, 0.0546050390705098, -0.0213310186780667, -0.201215097934791, -0.0204388818371446, 0.175371303393007), rank = 2, 
##     fitted.values = c(-0.00188226049894476, -0.390862288083179, -0.779842315667414, -1.16882234325165, -1.55780237083588, -1.94678239842012, -2.33576242600435, -2.72474245358859), assign = 0:1, qr = list(qr = c(-2.82842712474619, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, -6.86180700427983, 4.4921071430415, 0.0903888096881914, -0.0639145402739005, -0.218217890235992, -0.372521240198084, -0.526824590160176, -0.681127940122268
##     ), qraux = c(1.35355339059327, 1.24469215965028), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 6, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.00048851982391331, -0.359432142442021, -0.757624247622253, -1.11518017635137, -1.58391585940134, -2.15659956395945, -2.36862297316319, -2.56561241323442), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 
##     2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962)))) 
## series.TS1 m=6, r=.5
## list(sd = c(1.00048863916916, 0.698072619354232, 0.468778807482939, 0.327856201643399, 0.205170105827264, 0.115717944242596, 0.0936095404167764, 0.0768720895384629, 0.0281256004293065, 0.0162244807120432), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
cat(paste0("\nseries.TS2 m=6, r=.5\n",fd_sda(series$TS_2, doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-15.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-16.png)<!-- -->

```
## 
## series.TS2 m=6, r=.5
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1.00048863916916, 0.955390236316598, 0.934404804336079, 0.921081298175831, 0.905975383127022, 0.831848960026241, 0.73852047940931, 0.0513407102679796, 0.0353765803791022, 0.0418458427863038)) 
## series.TS2 m=6, r=.5
## list(sap = -0.584911757983907, H = 0.415088242016093, FD = 1.58491175798391, fitlm1 = list(coefficients = c(0.797845441383309, -0.584911757983907), residuals = c(-0.797356921559395, -0.438050903010743, -0.0548310948320929, 0.336237391397863, 0.725131158058544, 1.0451998451602, 1.33162772784804, -0.929107158965294, -0.896111202989072, -0.322738841108048), effects = c(3.24636031554265, -3.68250026717613, 0.167142503621275, 0.536781023244981, 0.904244823299413, 1.20288354379482, 1.46788145987641, -0.814283393543173, 
## -0.802717404173201, -0.250775008898426), rank = 2, fitted.values = c(0.797845441383308, 0.392415505460403, -0.0130144304625032, -0.418444366385409, -0.823874302308315, -1.22930423823122, -1.63473417415413, -2.04016411007703, -2.44559404599994, -2.85102398192284), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, -9.86365729932036, 
## 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.00048851982391331, -0.0456353975503407, -0.0678455252945962, -0.0822069749875465, 
## -0.0987431442497712, -0.184104393071022, -0.303106446306088, -2.96927126904233, -3.34170524898901, -3.17376282303089), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS2 m=6, r=.5
## list(sap = -0.385422618948269, H = 0.614577381051731, FD = 1.38542261894827, fitlm2 = list(coefficients = c(0.466238026933358, -0.385422618948269), residuals = c(-0.465749507109444, -0.244718822835676, 0.000225651068091859, 0.253018803023164, 0.503637235408963, 0.685430588235734, 0.833583136648691, -1.56542708443952), effects = c(1.32597534434066, -1.73135969966728, 0.130818007406939, 0.368355121076776, 0.603717515177339, 0.770254829718875, 0.903151339846597, -1.51111491952685), rank = 2, fitted.values = c(0.466238026933357, 
## 0.199083425285335, -0.068071176362688, -0.335225778010711, -0.602380379658734, -0.869534981306757, -1.13668958295478, -1.4038441846028), assign = 0:1, qr = list(qr = c(-2.82842712474619, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, -6.86180700427983, 4.4921071430415, 0.0903888096881914, -0.0639145402739005, -0.218217890235992, -0.372521240198084, -0.526824590160176, -0.681127940122268), qraux = c(1.35355339059327, 
## 1.24469215965028), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 6, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.00048851982391331, -0.0456353975503407, -0.0678455252945962, -0.0822069749875465, -0.0987431442497712, -0.184104393071022, -0.303106446306088, -2.96927126904233), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 
## 3.46573590279973, 4.15888308335967, 4.85203026391962)))) 
## series.TS2 m=6, r=.5
## list(sd = c(1.00048863916916, 0.955390236316598, 0.934404804336079, 0.921081298175831, 0.905975383127022, 0.831848960026241, 0.73852047940931, 0.0513407102679796, 0.0353765803791022, 0.0418458427863038), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
cat(paste0("\nseries.TS3 m=6, r=.5\n",fd_sda(series$TS_3, doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-17.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-18.png)<!-- -->

```
## 
## series.TS3 m=6, r=.5
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1.00048863916916, 0.70391263003542, 0.45286985910729, 0.334850283921018, 0.213588205385402, 0.129313242224143, 0.0996072186880589, 0.053950671439504, 0.043153955124514, 0.0137251117213528)) 
## series.TS3 m=6, r=.5
## list(sap = -0.637593769153149, H = 0.362406230846851, FD = 1.63759376915315, fitlm1 = list(coefficients = c(0.140381168163978, -0.637593769153149), residuals = c(-0.139892648340065, -0.0495358803219715, -0.0486390028145079, 0.0913860414079538, 0.0836987339065801, 0.0238328652696899, 0.204776132192427, 0.0335579540868244, 0.2522082135276, -0.451392408914531), effects = c(5.84508220311535, -4.01417682788471, -0.0130647062506228, 0.125575665600444, 0.116503685727675, 0.0552531447193892, 0.234811739270731, 
## 0.0622088887937333, 0.279474475863114, -0.425510818950412), rank = 2, fitted.values = c(0.140381168163978, -0.301565155267117, -0.74351147869821, -1.1854578021293, -1.6274041255604, -2.06935044899149, -2.51129677242259, -2.95324309585368, -3.39518941928478, -3.83713574271587), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, -9.86365729932036, 
## 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.00048851982391331, -0.351101035589088, -0.792150481512718, -1.09407176072135, 
## -1.54370539165382, -2.0455175837218, -2.30652064023016, -2.91968514176686, -3.14298120575717, -4.2885281516304), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS3 m=6, r=.5
## list(sap = -0.591299702035941, H = 0.408700297964059, FD = 1.59129970203594, fitlm2 = list(coefficients = c(0.0529690852410343, -0.591299702035941), residuals = c(-0.0524805654171206, 0.00578760050202523, -0.0254041240894556, 0.0825323180340603, 0.042756408433741, -0.0491980623020949, 0.0996566025216965, -0.103650177682852), effects = c(3.90756523959006, -2.65618161519396, -0.0131117652653227, 0.0972415443924478, 0.0598825023263829, -0.0296551008751985, 0.121616431482847, -0.0792734811874465), rank = 2, 
##     fitted.values = c(0.0529690852410339, -0.356888636091114, -0.766746357423263, -1.17660407875541, -1.58646180008756, -1.99631952141971, -2.40617724275186, -2.816034964084), assign = 0:1, qr = list(qr = c(-2.82842712474619, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, 0.353553390593274, -6.86180700427983, 4.4921071430415, 0.0903888096881914, -0.0639145402739005, -0.218217890235992, -0.372521240198084, -0.526824590160176, -0.681127940122268
##     ), qraux = c(1.35355339059327, 1.24469215965028), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 6, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.00048851982391331, -0.351101035589088, -0.792150481512718, -1.09407176072135, -1.54370539165382, -2.0455175837218, -2.30652064023016, -2.91968514176686), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 
##     2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962)))) 
## series.TS3 m=6, r=.5
## list(sd = c(1.00048863916916, 0.70391263003542, 0.45286985910729, 0.334850283921018, 0.213588205385402, 0.129313242224143, 0.0996072186880589, 0.053950671439504, 0.043153955124514, 0.0137251117213528), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
```



**Values of other time series**


```r

L1 <- floor(log2(length(TS1$TS1)))
L2 <- floor(log2(length(TS2$TS2)))
L3 <- floor(log2(length(TS2$TS2)))

# RR assignment data `TS1,TS2,TS3`
cat(paste0("\nTS1\n",fd_sda(TS1$TS1[1:2^L1],  doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-1.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-2.png)<!-- -->

```
## 
## TS1
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256), bulk = c(1.00097799534377, 0.928628068107471, 0.853225003341656, 0.761093501524869, 0.681358895523355, 0.619913092359753, 0.469959103792648, 0.421517812943001, 0.502338100808325)) 
## TS1
## list(sap = -0.156900504163069, H = 0.843099495836931, FD = 1.15690050416307, fitlm1 = list(coefficients = c(0.0267842000867936, -0.156900504163069), residuals = c(-0.025806682668892, 0.00792396441177391, 0.031994096646968, 0.0264821641680044, 0.0245702691304576, 0.0388155259769912, -0.129362948823437, -0.129391447059041, 0.154775058217175), effects = c(1.2247091048084, -0.84241370825074, 0.0369707330222941, 0.0329338348352274, 0.0324969740895775, 0.048217265228008, -0.118486175280523, -0.117039639224231, 
## 0.168601900343883), rank = 2, fitted.values = c(0.0267842000867935, -0.0819709420022718, -0.190726084091336, -0.299481226180402, -0.408236368269467, -0.516991510358532, -0.625746652447597, -0.734501794536662, -0.843256936625727), assign = 0:1, qr = list(qr = c(-3, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, -8.31776616671934, 5.36909497355859, 0.129099444873581, 0, -0.129099444873581, -0.258198889747161, 
## -0.387298334620742, -0.516397779494322, -0.645497224367903), qraux = c(1.33333333333333, 1.25819888974716), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 7, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.000977517417901552, -0.0740469775904979, -0.158731987444369, -0.272999062012397, -0.383666099139009, -0.47817598438154, -0.755109601271034, -0.863893241595703, -0.688481878408551), `log(out$scale)` = c(0, 
## 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956)))) 
## TS1
## list(sap = -0.17010680590214, H = 0.82989319409786, FD = 1.17010680590214, fitlm2 = list(coefficients = c(0.0506197023695291, -0.17010680590214), residuals = c(-0.0496421849516274, -0.0067576270549009, 0.0264664159963547, 0.0301083943334522, 0.0373504101119665, 0.0607495777745611, -0.098274986209806), effects = c(0.801946950020484, -0.623916062620243, 0.0398950558173493, 0.0445973552202967, 0.052899692064661, 0.0773591807931056, -0.0806050621254116), rank = 2, fitted.values = c(0.050619702369529, 
## -0.067289350535597, -0.185198403440723, -0.303107456345849, -0.421016509250975, -0.538925562156101, -0.656834615061228), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), 
##     df.residual = 5, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.000977517417901552, -0.0740469775904979, -0.158731987444369, -0.272999062012397, -0.383666099139009, -0.47817598438154, -0.755109601271034), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) 
## TS1
## list(sd = c(1.00097799534377, 0.928628068107471, 0.853225003341656, 0.761093501524869, 0.681358895523355, 0.619913092359753, 0.469959103792648, 0.421517812943001, 0.502338100808325), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256))
cat(paste0("TS1Random\n",fd_sda(TS1Random[1:2^L1],  doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-3.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-4.png)<!-- -->

```
## TS1Random
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256), bulk = c(1.00097799534377, 0.698619100783598, 0.483576329940262, 0.349218245240568, 0.245834911242749, 0.185994831046965, 0.111980511957799, 0.0903235340963042, 0.00122297284455637)) TS1Random
## list(sap = -0.878184395702594, H = 0.121815604297406, FD = 1.87818439570259, fitlm1 = list(coefficients = c(0.599103469320103, -0.878184395702594), residuals = c(-0.598125951902202, -0.349042036893544, -0.108227500506446, 0.1749714366616, 0.432645621409568, 0.762415324419691, 0.863732334834195, 1.25751656463736, -2.43588579266023), effects = c(5.5072220467556, -4.71505542482438, 0.0617750761988933, 0.32450292463715, 0.56170602065533, 0.871004634935663, 0.951850556620378, 1.32516369769376, -2.38870974833362
## ), rank = 2, fitted.values = c(0.599103469320103, -0.00960756857289002, -0.618318606465881, -1.22702964435887, -1.83574068225187, -2.44445172014486, -3.05316275803785, -3.66187379593084, -4.27058483382383), assign = 0:1, qr = list(qr = c(-3, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, -8.31776616671934, 5.36909497355859, 0.129099444873581, 0, -0.129099444873581, -0.258198889747161, -0.387298334620742, 
## -0.516397779494322, -0.645497224367903), qraux = c(1.33333333333333, 1.25819888974716), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 7, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.000977517417901774, -0.358649605466434, -0.726546106972328, -1.05205820769727, -1.4030950608423, -1.68203639572517, -2.18943042320366, -2.40435723129348, -6.70647062648406), `log(out$scale)` = c(0, 0.693147180559945, 
## 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956)))) TS1Random
## list(sap = -0.509814748571817, H = 0.490185251428183, FD = 1.50981474857182, fitlm2 = list(coefficients = c(0.00143878352854707, -0.509814748571817), residuals = c(-0.000461266110644603, -0.0067117334145487, -0.0212315793400096, 0.00663297551547697, 0.00897277795088542, 0.083408098648448, -0.0706092732496074), effects = c(2.80103358599766, -1.8698934996031, -0.0209247411096131, 0.00592179061708642, 0.00724356992370778, 0.0806608674924832, -0.0743745275343592), rank = 2, fitted.values = c(0.00143878352854638, 
## -0.351937872051885, -0.705314527632318, -1.05869118321275, -1.41206783879318, -1.76544449437362, -2.11882114995405), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 5, 
##     xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.000977517417901774, -0.358649605466434, -0.726546106972328, -1.05205820769727, -1.4030950608423, -1.68203639572517, -2.18943042320366), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) TS1Random
## list(sd = c(1.00097799534377, 0.698619100783598, 0.483576329940262, 0.349218245240568, 0.245834911242749, 0.185994831046965, 0.111980511957799, 0.0903235340963042, 0.00122297284455637), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256))

cat(paste0("\nTS2\n",fd_sda(TS2$TS2[1:2^L2],  doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-5.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-6.png)<!-- -->

```
## 
## TS2
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256), bulk = c(1.00097799534377, 0.973281997589516, 0.964173930841758, 0.949713166094109, 0.922749380908398, 0.853837591383496, 0.791832991092761, 0.734162649645876, 0.893371629900568)) 
## TS2
## list(sap = -0.0433051795240074, H = 0.956694820475993, FD = 1.04330517952401, fitlm1 = list(coefficients = c(0.00809226179310774, -0.0433051795240074), residuals = c(-0.00711474437520622, -0.00515681468378986, 0.0154578899262668, 0.0303630570740441, 0.0315775825772835, -0.0160222236425169, -0.061395862485113, -0.106998901551, 0.119290017160031), effects = c(0.335925571709173, -0.2325096217114, 0.0175831941336535, 0.0321417431678457, 0.0330096505574999, -0.0149367737758856, -0.0606570307320669, -0.106606687911539, 
## 0.119335612685907), rank = 2, fitted.values = c(0.00809226179310777, -0.0219246012976003, -0.0519414643883083, -0.0819583274790163, -0.111975190569724, -0.141992053660432, -0.17200891675114, -0.202025779841848, -0.232042642932556), assign = 0:1, qr = list(qr = c(-3, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, -8.31776616671934, 5.36909497355859, 0.129099444873581, 0, -0.129099444873581, -0.258198889747161, 
## -0.387298334620742, -0.516397779494322, -0.645497224367903), qraux = c(1.33333333333333, 1.25819888974716), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 7, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.000977517417901552, -0.0270814159813902, -0.0364835744620415, -0.0515952704049722, -0.0803976079924408, -0.158014277302949, -0.233404779236253, -0.309024681392848, -0.112752625772525), `log(out$scale)` = c(0, 
## 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956)))) 
## TS2
## list(sap = -0.0519847667500399, H = 0.94801523324996, FD = 1.05198476675004, fitlm2 = list(coefficients = c(0.0243850823771201, -0.0519847667500399), residuals = c(-0.0234075649592186, -0.0154334038536538, 0.0111975321705514, 0.0321189307324772, 0.0393496876498651, -0.00223388715578685, -0.0415912945842344), effects = c(0.221486957414132, -0.190669214055877, 0.0178648290422912, 0.0373929027487079, 0.0432303348105866, 0.000253435149425399, -0.0404972971345314), rank = 2, fitted.values = c(0.0243850823771201, 
## -0.0116480121277364, -0.0476811066325929, -0.0837142011374494, -0.119747295642306, -0.155780390147162, -0.191813484652019), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), 
##     df.residual = 5, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.000977517417901552, -0.0270814159813902, -0.0364835744620415, -0.0515952704049722, -0.0803976079924408, -0.158014277302949, -0.233404779236253), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) 
## TS2
## list(sd = c(1.00097799534377, 0.973281997589516, 0.964173930841758, 0.949713166094109, 0.922749380908398, 0.853837591383496, 0.791832991092761, 0.734162649645876, 0.893371629900568), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256))
cat(paste0("TS2Random\n",fd_sda(TS2Random[1:2^L2],  doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-7.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-8.png)<!-- -->

```
## TS2Random
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256), bulk = c(1.00097799534377, 0.740117140373669, 0.504761771766144, 0.341851897000451, 0.225893016526688, 0.149391293462169, 0.100137422961075, 0.0792338156620838, 0.0963584131394886)) TS2Random
## list(sap = -0.483993963079263, H = 0.516006036920737, FD = 1.48399396307926, fitlm1 = list(coefficients = c(-0.0605438199233932, -0.483993963079263), residuals = c(0.0615213373412949, 0.0950760633303787, 0.0478332216686413, -0.00639671274624974, -0.0852337464000853, -0.163247210168359, -0.227793681350677, -0.126454929516837, 0.404695657841893), effects = c(4.20738007076728, -2.59860955440157, 0.0242755836845086, -0.0217770470815735, -0.0924367770866, -0.162272937206065, -0.218642104739573, -0.109126049256925, 
## 0.430201841750614), rank = 2, fitted.values = c(-0.0605438199233933, -0.39602287083982, -0.731501921756244, -1.06698097267267, -1.40246002358909, -1.73793907450552, -2.07341812542195, -2.40889717633837, -2.7443762272548), assign = 0:1, qr = list(qr = c(-3, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, -8.31776616671934, 5.36909497355859, 0.129099444873581, 0, -0.129099444873581, -0.258198889747161, 
## -0.387298334620742, -0.516397779494322, -0.645497224367903), qraux = c(1.33333333333333, 1.25819888974716), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 7, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.000977517417901552, -0.300946807509441, -0.683668700087603, -1.07337768541892, -1.48769376998918, -1.90118628467388, -2.30121180677262, -2.53535210585521, -2.3396805694129), `log(out$scale)` = c(0, 
## 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956)))) TS2Random
## list(sap = -0.562191052163168, H = 0.437808947836832, FD = 1.56219105216317, fitlm2 = list(coefficients = c(0.0623137800811104, -0.562191052163168), residuals = c(-0.0613362626632086, 0.0264205551523767, 0.0333798053171453, 0.0333519627287584, 0.00871702090142694, -0.0150943510403426, -0.0254387303961562), effects = c(2.92813141758077, -2.06199878861851, 0.0490197182726105, 0.0556771575054378, 0.0377274974993206, 0.0206014073787653, 0.0169423098441659), rank = 2, fitted.values = c(0.0623137800811102, 
## -0.327367362661818, -0.717048505404748, -1.10672964814768, -1.49641079089061, -1.88609193363354, -2.27577307637647), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 5, 
##     xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.000977517417901552, -0.300946807509441, -0.683668700087603, -1.07337768541892, -1.48769376998918, -1.90118628467388, -2.30121180677262), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) TS2Random
## list(sd = c(1.00097799534377, 0.740117140373669, 0.504761771766144, 0.341851897000451, 0.225893016526688, 0.149391293462169, 0.100137422961075, 0.0792338156620838, 0.0963584131394886), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256))

cat(paste0("\nTS3\n",fd_sda(TS3$TS3[1:2^L3],  doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-9.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-10.png)<!-- -->

```
## 
## TS3
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256), bulk = c(1.00097799534377, 0.704507030763386, 0.455548147776341, 0.329763657288379, 0.18761826201684, 0.124765358715981, 0.0826040082098266, 0.0609306006481149, 0.0274847568282971)) 
## TS3
## list(sap = -0.62782532225638, H = 0.37217467774362, FD = 1.62782532225638, fitlm1 = list(coefficients = c(0.0867659324719187, -0.62782532225638), residuals = c(-0.0857884150540167, -0.00184754836707999, -0.00266909319655302, 0.1093810524031, -0.019410426089558, 0.00779039158993355, 0.0305891054751374, 0.161441774803668, -0.199486841564632), effects = c(4.96180642665803, -3.37085378199953, 0.0167669678438441, 0.130828156166604, 0.0040477203970532, 0.0332595807996517, 0.0580693374079626, 0.190933049459601, 
## -0.167984524185592), rank = 2, fitted.values = c(0.0867659324719182, -0.348409419534231, -0.783584771540379, -1.21876012354653, -1.65393547555268, -2.08911082755882, -2.52428617956497, -2.95946153157112, -3.39463688357727), assign = 0:1, qr = list(qr = c(-3, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, -8.31776616671934, 5.36909497355859, 0.129099444873581, 0, -0.129099444873581, -0.258198889747161, 
## -0.387298334620742, -0.516397779494322, -0.645497224367903), qraux = c(1.33333333333333, 1.25819888974716), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 7, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.000977517417901552, -0.350256967901311, -0.786253864736932, -1.10937907114343, -1.67334590164223, -2.08132043596889, -2.49369707408984, -2.79801975676745, -3.5941237251419), `log(out$scale)` = c(0, 
## 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956)))) 
## TS3
## list(sap = -0.609705736769479, H = 0.390294263230521, FD = 1.60970573676948, fitlm2 = list(coefficients = c(0.0545223232297177, -0.609705736769479), residuals = c(-0.0535448058118157, 0.0178365212819584, 0.00445543685932693, 0.10394604286582, -0.0374049752199985, -0.0227636971336672, -0.0125245228416235), effects = c(3.21015651113756, -2.23627267953658, 0.0182517840930195, 0.122770261883971, -0.0135528844173887, 0.00611626545340127, 0.0213833115299036), rank = 2, fitted.values = c(0.0545223232297173, 
## -0.36809348918327, -0.790709301596259, -1.21332511400925, -1.63594092642224, -2.05855673883522, -2.48117255124821), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 5, 
##     xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.000977517417901552, -0.350256967901311, -0.786253864736932, -1.10937907114343, -1.67334590164223, -2.08132043596889, -2.49369707408984), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) 
## TS3
## list(sd = c(1.00097799534377, 0.704507030763386, 0.455548147776341, 0.329763657288379, 0.18761826201684, 0.124765358715981, 0.0826040082098266, 0.0609306006481149, 0.0274847568282971), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256))
cat(paste0("TS3Int\n",fd_sda(TS3Norm[1:2^L3],  doPlot = TRUE)))
## 
## 
## fd.sda:	Sample rate was set to 1.
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-11.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-12.png)<!-- -->

```
## TS3Int
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256), bulk = c(1.00097799534377, 0.704507030763386, 0.455548147776341, 0.329763657288379, 0.18761826201684, 0.124765358715981, 0.0826040082098266, 0.0609306006481149, 0.0274847568282971)) TS3Int
## list(sap = -0.62782532225638, H = 0.37217467774362, FD = 1.62782532225638, fitlm1 = list(coefficients = c(0.086765932471919, -0.62782532225638), residuals = c(-0.085788415054017, -0.0018475483670794, -0.00266909319655305, 0.1093810524031, -0.019410426089558, 0.00779039158993354, 0.0305891054751373, 0.161441774803669, -0.199486841564632), effects = c(4.96180642665803, -3.37085378199953, 0.0167669678438441, 0.130828156166604, 0.00404772039705331, 0.033259580799652, 0.0580693374079628, 0.190933049459601, 
## -0.167984524185592), rank = 2, fitted.values = c(0.0867659324719186, -0.348409419534232, -0.783584771540379, -1.21876012354653, -1.65393547555268, -2.08911082755882, -2.52428617956497, -2.95946153157112, -3.39463688357727), assign = 0:1, qr = list(qr = c(-3, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, -8.31776616671934, 5.36909497355859, 0.129099444873581, 0, -0.129099444873581, -0.258198889747161, 
## -0.387298334620742, -0.516397779494322, -0.645497224367903), qraux = c(1.33333333333333, 1.25819888974716), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 7, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0.000977517417901552, -0.350256967901311, -0.786253864736932, -1.10937907114343, -1.67334590164223, -2.08132043596889, -2.49369707408984, -2.79801975676745, -3.5941237251419), `log(out$scale)` = c(0, 
## 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956)))) TS3Int
## list(sap = -0.609705736769479, H = 0.390294263230521, FD = 1.60970573676948, fitlm2 = list(coefficients = c(0.0545223232297177, -0.609705736769479), residuals = c(-0.0535448058118158, 0.0178365212819584, 0.00445543685932703, 0.10394604286582, -0.0374049752199985, -0.0227636971336672, -0.0125245228416235), effects = c(3.21015651113756, -2.23627267953658, 0.0182517840930196, 0.122770261883971, -0.0135528844173887, 0.00611626545340127, 0.0213833115299036), rank = 2, fitted.values = c(0.0545223232297173, 
## -0.368093489183269, -0.790709301596259, -1.21332511400925, -1.63594092642224, -2.05855673883522, -2.48117255124821), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 5, 
##     xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0.000977517417901552, -0.350256967901311, -0.786253864736932, -1.10937907114343, -1.67334590164223, -2.08132043596889, -2.49369707408984), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) TS3Int
## list(sd = c(1.00097799534377, 0.704507030763386, 0.455548147776341, 0.329763657288379, 0.18761826201684, 0.124765358715981, 0.0826040082098266, 0.0609306006481149, 0.0274847568282971), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256))



# Logistic map
cat("\nLogistic map\nr=2.9\n")
## 
## Logistic map
## r=2.9
y1<-growth_ac(r = 2.9,type="logistic",N = 1024)
fd_sda(y1, doPlot = TRUE)
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-13.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-14.png)<!-- -->

```
## $PLAW
##      freq.norm size       bulk
## 1  1.000000000    1 1.00048864
## 2  0.500000000    2 0.98012794
## 3  0.250000000    4 0.97443863
## 4  0.125000000    8 0.72432273
## 5  0.062500000   16 0.51931814
## 6  0.031250000   32 0.36896558
## 7  0.015625000   64 0.26110575
## 8  0.007812500  128 0.18463474
## 9  0.003906250  256 0.13055648
## 10 0.001953125  512 0.09231737
## 
## $fullRange
## $fullRange$sap
## log(out$scale) 
##     -0.4133837 
## 
## $fullRange$H
## log(out$scale) 
##      0.5866163 
## 
## $fullRange$FD
## log(out$scale) 
##       1.413384 
## 
## $fullRange$fitlm1
## 
## Call:
## stats::lm(formula = log(out$sd) ~ log(out$scale))
## 
## Coefficients:
##    (Intercept)  log(out$scale)  
##         0.3423         -0.4134  
## 
## 
## 
## $fitRange
## $fitRange$sap
## log(out$scale[bins]) 
##           -0.3725079 
## 
## $fitRange$H
## log(out$scale[bins]) 
##            0.6274921 
## 
## $fitRange$FD
## log(out$scale[bins]) 
##             1.372508 
## 
## $fitRange$fitlm2
## 
## Call:
## stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins]))
## 
## Coefficients:
##          (Intercept)  log(out$scale[bins])  
##               0.2721               -0.3725  
## 
## 
## 
## $info
## $info$sd
##  [1] 1.00048864 0.98012794 0.97443863 0.72432273 0.51931814 0.36896558
##  [7] 0.26110575 0.18463474 0.13055648 0.09231737
## 
## $info$scale
##  [1]   1   2   4   8  16  32  64 128 256 512
cat("\nLogistic map\nr=4\n")
## 
## Logistic map
## r=4
y2<-growth_ac(r = 4,type="logistic", N = 1024)
fd_sda(y2, doPlot = TRUE)
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-15.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-16.png)<!-- -->

```
## $PLAW
##      freq.norm size       bulk
## 1  1.000000000    1 1.00048864
## 2  0.500000000    2 0.70391263
## 3  0.250000000    4 0.45286986
## 4  0.125000000    8 0.33485028
## 5  0.062500000   16 0.21358821
## 6  0.031250000   32 0.12931324
## 7  0.015625000   64 0.09960722
## 8  0.007812500  128 0.05395067
## 9  0.003906250  256 0.04315396
## 10 0.001953125  512 0.01372511
## 
## $fullRange
## $fullRange$sap
## log(out$scale) 
##     -0.6375938 
## 
## $fullRange$H
## log(out$scale) 
##      0.3624062 
## 
## $fullRange$FD
## log(out$scale) 
##       1.637594 
## 
## $fullRange$fitlm1
## 
## Call:
## stats::lm(formula = log(out$sd) ~ log(out$scale))
## 
## Coefficients:
##    (Intercept)  log(out$scale)  
##         0.1404         -0.6376  
## 
## 
## 
## $fitRange
## $fitRange$sap
## log(out$scale[bins]) 
##           -0.5912997 
## 
## $fitRange$H
## log(out$scale[bins]) 
##            0.4087003 
## 
## $fitRange$FD
## log(out$scale[bins]) 
##               1.5913 
## 
## $fitRange$fitlm2
## 
## Call:
## stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins]))
## 
## Coefficients:
##          (Intercept)  log(out$scale[bins])  
##              0.05297              -0.59130  
## 
## 
## 
## $info
## $info$sd
##  [1] 1.00048864 0.70391263 0.45286986 0.33485028 0.21358821 0.12931324
##  [7] 0.09960722 0.05395067 0.04315396 0.01372511
## 
## $info$scale
##  [1]   1   2   4   8  16  32  64 128 256 512
```



###  Spectral Slope {.tabset .tabset-fade .tabset-pills}


#### Questions {-}

* Common data preparation before running fluctuation analyses:
    + Normalize the time series (using `sd` based on `N`, not `N-1`)
    + Check whether time series length is a power of `2`. If you use `N <- log2(length(y))`, the number you get is `2^N`. You need an integer power for the length in order to create equal bin sizes. You can padd the series with 0s, or make it shorter before analysis.
* Perform `psd` on the 3 HRV timeseries, or any of the other series you already analysed.
* Compare to what you find for `psd` to the other measures (`RR`,`SampEn`, `acf`, `pacf`)


#### Answers {-}

See `sda`

###  Detrended Fluctuation Analysis {.tabset .tabset-fade .tabset-pills}


#### Questions {-}

* Common data preparation before running fluctuation analyses:
    + Normalize the time series (using `sd` based on `N`, not `N-1`)
    + Check whether time series length is a power of `2`. If you use `N <- log2(length(y))`, the number you get is `2^N`. You need an integer power for the length in order to create equal bin sizes. You can padd the series with 0s, or make it shorter before analysis.
* Perform `dfa` on the 3 HRV timeseries, or any of the other series you already analysed.
* Compare to what you find for `dfa` to the other measures (`RR`,`SampEn`, `acf`, `pacf`)


#### Answers {-}

See `sda`
