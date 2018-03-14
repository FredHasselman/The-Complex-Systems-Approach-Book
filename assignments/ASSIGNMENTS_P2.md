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
editor_options: 
  chunk_output_type: console
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

In this course we will not discuss the type of linear time series models known as Autoregressive Models (e.g. AR, ARMA, ARiMA, ARfiMA) summarised on [this Wikipedia page on timeseries](https://en.wikipedia.org/wiki/Time_series#Models). We will in fact be discussing a lot of methods in a book the Wiki page refers to for *'Further references on nonlinear time series analysis'*: [**Nonlinear Time Series Analysis** by Kantz & Schreiber](https://www.cambridge.org/core/books/nonlinear-time-series-analysis/519783E4E8A2C3DCD4641E42765309C7). You do not need to buy the book, but it can be a helpful reference if you want to go beyond the formal level (= mathematics) used in this course. Some of the packages we use are based on the companying software [**TiSEAN**](https://www.pks.mpg.de/~tisean/Tisean_3.0.1/index.html) which is written in `C` and `Fortran` and can be called from the command line (Windows / Linux).


## **Correlation functions**  

Correlation functions are intuitive tools for quantifying the temporal structure in a time series. As you know, correlation can only quantify linear regularities between variables, which is why we discuss them here as `basic` tools for time series analysis. So what are the variables? In the simplest case, the variables between which we calculate a correlation are between a data point at time *t* and a data point that is separated in time by some *lag*, for example, if you would calculate the correlation in a lag-1 return plot, you would have calculated the 1st value of the correlation function (actually, it is 2nd value, the 1st value is the correlation of time series with itself, the lag-0 correlation, which is of course $r = 1$)  

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
2. On the Github page, find a button marked **Download** (or **Raw** for textiles).
3. Download the file
4. Load it into `R`


```r
library(rio)
series <- import("series.sav", setclass = "tbl_df")
```


By importing from Github:

1. Copy the `url` associated with the **Download**  button on Github (right-clink).
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
These HBI’s were constructed from the[] R-R inter-beat intervals](https://www.physionet.org/tutorials/hrv/) in electrocardiogram (ECG) recordings, as defined in Figure \@ref(fig:RRf1).

<div class="figure" style="text-align: center">
<img src="images/RRfig1.png" alt="Definition of Heart Beat Periods." width="862" />
<p class="caption">(\#fig:RRf1)Definition of Heart Beat Periods.</p>
</div>


 * One HBI series is a sample from a male adult, 62 years old (called *Jimmy*). Approximately two years before the recording, the subject has had a coronary artery bypass, as advised by his physician following a diagnosis of congestive heart failure. *Jimmy* used anti-arrhythmic medicines at the time of measurement.

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

The numerator in the formula stands for the `lag 1` auto-covariance of the HBI time series $x_i$. The denominator stands for the (global) variance of $x_i$. Most statistics packages can calculate these variances, `R` and `Matlab` have built in functions. Alternatively, you can create the formula yourself.

*	Compare your (intuitive) visual inspection with these preliminary dynamic quantifications, and find out where each of the HIB series are positions on the ‘colourful spectrum of noises’ (i.e., line them up with Figure \@ref(fig:RRf3)).

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
## 2.046232
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
## 2.047871
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
## 2.076532
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

* Calculate the Sample Entropy of the two sets of three time series you now have.
    + Use your favourite function to estimate the sample entropy of the three time series. Use for instance a segment length `edim` of 3 data points, and a tolerance range `r` of 1 * the standard deviation of the series. What values do you observe?
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

The change of `m` keeps the relative order, change of `r` for the same `m` does not.

**Values of other time series**


```r

# RR assignment data `TS1,TS2,TS3`
cat(paste0("\nTS1\n",sample_entropy(TS1$TS1, edim = 3, r = sd(TS1$TS1))))
## 
## TS1
## 0.260297595725622
cat(paste0("TS1Random\n",sample_entropy(TS1Random, edim = 3, r = sd(TS1Random))))
## TS1Random
## 0.622965932564049

cat(paste0("\nTS2\n",sample_entropy(TS2$TS2, edim = 3, r = sd(TS2$TS2))))
## 
## TS2
## 0.0477314028211898
cat(paste0("TS2Random\n",sample_entropy(TS2Random, edim = 3, r = sd(TS2Random))))
## TS2Random
## 0.562703955988744

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
    + Check whether time series length is a power of `2`. If you use `N <- log2(length(y))`, the number you get is `2^N`. You need an integer power for the length in order to create equal bin sizes. You can pad the series with 0s, or make it shorter before analysis.
* Perform `sda` on the 3 HRV time series, or any of the other series you already analysed.
* Compare to what you find for `sda` to the other measures (`RR`,`SampEn`, `acf`, `pacf`)


#### Answers {-}



```r
library(rio)
library(pracma)
library(casnet)

# ACF assignment data `series`
cat(paste0("\nseries.TS1 m=3\n",fd_sda(series$TS_1, doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-1.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-2.png)<!-- -->

```
## 
## series.TS1 m=3
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1, 0.697731680325664, 0.468549855670756, 0.32769607650484, 0.205069900641396, 0.11566142753874, 0.0935638214687908, 0.0768345451701486, 0.0281118638715009, 0.0162165566672667)) 
## series.TS1 m=3
## list(sap = -0.6378456980678, H = 0.3621543019322, FD = 1.6378456980678, fitlm1 = list(coefficients = c(0.1291749479157, -0.6378456980678), residuals = c(-0.1291749479157, -0.0469746629336484, -0.00304582086589452, 0.0815191976529704, 0.0549044618509935, -0.0756582954591309, 0.154439242585115, 0.399570749761866, -0.163770959843595, -0.271808964832976), effects = c(5.88300432353931, -4.01576292746785, 0.0299552105750075, 0.113134361860518, 0.0851337588251869, -0.0468148657182919, 0.1818968050926, 0.425642445035997, 
## -0.139085131802819, -0.248509004025554), rank = 2, fitted.values = c(0.1291749479157, -0.312945999332286, -0.755066946580272, -1.19718789382826, -1.63930884107624, -2.08142978832423, -2.52355073557221, -2.9656716828202, -3.40779263006819, -3.84991357731617), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, -9.86365729932036, 6.29582191999199, 
## 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0, -0.359920662265935, -0.758112767446166, -1.11566869617529, -1.58440437922525, -2.15708808378336, 
## -2.3691114929871, -2.56610093305833, -3.57156358991178, -4.12172254214915), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS1 m=3
## list(sap = -0.59397614538283, H = 0.40602385461717, FD = 1.59397614538283, fitlm2 = list(coefficients = c(0.0430949454926185, -0.59397614538283), residuals = c(-0.0430949454926176, 0.00869728273341902, 0.0222180680451608, 0.0763750298080126, 0.0193522372500224, -0.141618576816115, 0.0580709044721179), effects = c(3.15385125086663, -2.17857983960266, 0.0334768401180779, 0.0908057078634757, 0.0369548212880317, -0.12084408679556, 0.0820173004752194), rank = 2, fitted.values = c(0.0430949454926176, -0.368617944999354, 
## -0.780330835491327, -1.1920437259833, -1.60375661647527, -2.01546950696724, -2.42718239745922), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 5, xlevels = list(), 
##     call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0, -0.359920662265935, -0.758112767446166, -1.11566869617529, -1.58440437922525, -2.15708808378336, -2.3691114929871), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) 
## series.TS1 m=3
## list(sd = c(1, 0.697731680325664, 0.468549855670756, 0.32769607650484, 0.205069900641396, 0.11566142753874, 0.0935638214687908, 0.0768345451701486, 0.0281118638715009, 0.0162165566672667), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
cat(paste0("\nseries.TS2 m=3\n",fd_sda(series$TS_2, doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-3.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-4.png)<!-- -->

```
## 
## series.TS2 m=3
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1, 0.954923623230736, 0.933948440546056, 0.920631441593112, 0.905532904281031, 0.831442684563655, 0.738159785624958, 0.0513156354385142, 0.0353593024389365, 0.0418254052550304)) 
## series.TS2 m=3
## list(sap = -0.584911757983907, H = 0.415088242016093, FD = 1.58491175798391, fitlm1 = list(coefficients = c(0.797356921559395, -0.584911757983907), residuals = c(-0.797356921559395, -0.438050903010743, -0.0548310948320926, 0.336237391397863, 0.725131158058544, 1.0451998451602, 1.33162772784804, -0.929107158965294, -0.896111202989072, -0.322738841108048), effects = c(3.24790515086836, -3.68250026717613, 0.167142503621275, 0.536781023244981, 0.904244823299413, 1.20288354379482, 1.46788145987641, -0.814283393543173, 
## -0.802717404173201, -0.250775008898426), rank = 2, fitted.values = c(0.797356921559395, 0.391926985636489, -0.0135029502864168, -0.418932886209323, -0.824362822132229, -1.22979275805513, -1.63522269397804, -2.04065262990095, -2.44608256582385, -2.85151250174676), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, -9.86365729932036, 
## 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0, -0.0461239173742539, -0.0683340451185094, -0.0826954948114599, -0.0992316640736845, 
## -0.184592912894936, -0.303594966130002, -2.96975978886624, -3.34219376881292, -3.17425134285481), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS2 m=3
## list(sap = -0.0627892058633876, H = 0.937210794136612, FD = 1.06278920586339, fitlm2 = list(coefficients = c(0.0184846258410089, -0.0627892058633876), residuals = c(-0.0184846258410089, -0.0210863822014578, 0.000225651068091885, 0.0293863623889466, 0.056372354140527, 0.0145332663330811, -0.0609466258881799), effects = c(0.29654072063453, -0.230297629125278, 0.00573439049949296, 0.0324191205316702, 0.0569291309945733, 0.0126140618984499, -0.0653418116114885), rank = 2, fitted.values = c(0.0184846258410089, 
## -0.0250375351727961, -0.0685596961866013, -0.112081857200406, -0.155604018214212, -0.199126179228017, -0.242648340241822), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), 
##     df.residual = 5, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0, -0.0461239173742539, -0.0683340451185094, -0.0826954948114599, -0.0992316640736845, -0.184592912894936, -0.303594966130002), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) 
## series.TS2 m=3
## list(sd = c(1, 0.954923623230736, 0.933948440546056, 0.920631441593112, 0.905532904281031, 0.831442684563655, 0.738159785624958, 0.0513156354385142, 0.0353593024389365, 0.0418254052550304), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
cat(paste0("\nseries.TS3 m=3\n",fd_sda(series$TS_3, doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-5.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-6.png)<!-- -->

```
## 
## series.TS3 m=3
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1, 0.703568838742613, 0.452648677233727, 0.334686742869055, 0.213483888795352, 0.129250085569717, 0.0995585704709017, 0.0539243219036517, 0.0431328787104976, 0.0137184083696849)) 
## series.TS3 m=3
## list(sap = -0.637593769153149, H = 0.362406230846851, FD = 1.63759376915315, fitlm1 = list(coefficients = c(0.139892648340064, -0.637593769153149), residuals = c(-0.139892648340064, -0.0495358803219725, -0.0486390028145079, 0.0913860414079538, 0.0836987339065799, 0.0238328652696902, 0.204776132192427, 0.0335579540868241, 0.2522082135276, -0.451392408914531), effects = c(5.84662703844106, -4.01417682788471, -0.0130647062506229, 0.125575665600443, 0.116503685727674, 0.0552531447193891, 0.234811739270731, 
## 0.0622088887937324, 0.279474475863113, -0.425510818950413), rank = 2, fitted.values = c(0.139892648340064, -0.302053675091029, -0.743999998522124, -1.18594632195322, -1.62789264538431, -2.06983896881541, -2.5117852922465, -2.95373161567759, -3.39567793910869, -3.83762426253978), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 
## -9.86365729932036, 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(-1.11022302462516e-16, -0.351589555413002, -0.792639001336632, 
## -1.09456028054526, -1.54419391147773, -2.04600610354572, -2.30700916005407, -2.92017366159077, -3.14346972558109, -4.28901667145431), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS3 m=3
## list(sap = -0.569937473845897, H = 0.430062526154103, FD = 1.5699374738459, fitlm2 = list(coefficients = c(0.022866228936306, -0.569937473845897), residuals = c(-0.0228662289363059, 0.0205947687424329, -0.0254041240894557, 0.0677251497936529, 0.0131420719529259, -0.093619567023317, 0.0404279295600668), effects = c(3.07511820115046, -2.09041103755853, -0.0198677711504568, 0.0774149018887645, 0.0269852232041501, -0.0756230166159801, 0.0625778791235163), rank = 2, fitted.values = c(0.0228662289363058, 
## -0.372184324155435, -0.767234877247176, -1.16228543033892, -1.55733598343066, -1.9523865365224, -2.34743708961414), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 5, 
##     xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(-1.11022302462516e-16, -0.351589555413002, -0.792639001336632, -1.09456028054526, -1.54419391147773, -2.04600610354572, -2.30700916005407), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) 
## series.TS3 m=3
## list(sd = c(1, 0.703568838742613, 0.452648677233727, 0.334686742869055, 0.213483888795352, 0.129250085569717, 0.0995585704709017, 0.0539243219036517, 0.0431328787104976, 0.0137184083696849), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))


# ACF assignment data `series`
cat(paste0("\nseries.TS1 m=6\n",fd_sda(series$TS_1,  doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-7.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-8.png)<!-- -->

```
## 
## series.TS1 m=6
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1, 0.697731680325664, 0.468549855670756, 0.32769607650484, 0.205069900641396, 0.11566142753874, 0.0935638214687908, 0.0768345451701486, 0.0281118638715009, 0.0162165566672667)) 
## series.TS1 m=6
## list(sap = -0.6378456980678, H = 0.3621543019322, FD = 1.6378456980678, fitlm1 = list(coefficients = c(0.1291749479157, -0.6378456980678), residuals = c(-0.1291749479157, -0.0469746629336484, -0.00304582086589452, 0.0815191976529704, 0.0549044618509935, -0.0756582954591309, 0.154439242585115, 0.399570749761866, -0.163770959843595, -0.271808964832976), effects = c(5.88300432353931, -4.01576292746785, 0.0299552105750075, 0.113134361860518, 0.0851337588251869, -0.0468148657182919, 0.1818968050926, 0.425642445035997, 
## -0.139085131802819, -0.248509004025554), rank = 2, fitted.values = c(0.1291749479157, -0.312945999332286, -0.755066946580272, -1.19718789382826, -1.63930884107624, -2.08142978832423, -2.52355073557221, -2.9656716828202, -3.40779263006819, -3.84991357731617), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, -9.86365729932036, 6.29582191999199, 
## 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0, -0.359920662265935, -0.758112767446166, -1.11566869617529, -1.58440437922525, -2.15708808378336, 
## -2.3691114929871, -2.56610093305833, -3.57156358991178, -4.12172254214915), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS1 m=6
## list(sap = -0.59397614538283, H = 0.40602385461717, FD = 1.59397614538283, fitlm2 = list(coefficients = c(0.0430949454926185, -0.59397614538283), residuals = c(-0.0430949454926176, 0.00869728273341902, 0.0222180680451608, 0.0763750298080126, 0.0193522372500224, -0.141618576816115, 0.0580709044721179), effects = c(3.15385125086663, -2.17857983960266, 0.0334768401180779, 0.0908057078634757, 0.0369548212880317, -0.12084408679556, 0.0820173004752194), rank = 2, fitted.values = c(0.0430949454926176, -0.368617944999354, 
## -0.780330835491327, -1.1920437259833, -1.60375661647527, -2.01546950696724, -2.42718239745922), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 5, xlevels = list(), 
##     call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0, -0.359920662265935, -0.758112767446166, -1.11566869617529, -1.58440437922525, -2.15708808378336, -2.3691114929871), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) 
## series.TS1 m=6
## list(sd = c(1, 0.697731680325664, 0.468549855670756, 0.32769607650484, 0.205069900641396, 0.11566142753874, 0.0935638214687908, 0.0768345451701486, 0.0281118638715009, 0.0162165566672667), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
cat(paste0("\nseries.TS2 m=6\n",fd_sda(series$TS_2,  doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-9.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-10.png)<!-- -->

```
## 
## series.TS2 m=6
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1, 0.954923623230736, 0.933948440546056, 0.920631441593112, 0.905532904281031, 0.831442684563655, 0.738159785624958, 0.0513156354385142, 0.0353593024389365, 0.0418254052550304)) 
## series.TS2 m=6
## list(sap = -0.584911757983907, H = 0.415088242016093, FD = 1.58491175798391, fitlm1 = list(coefficients = c(0.797356921559395, -0.584911757983907), residuals = c(-0.797356921559395, -0.438050903010743, -0.0548310948320926, 0.336237391397863, 0.725131158058544, 1.0451998451602, 1.33162772784804, -0.929107158965294, -0.896111202989072, -0.322738841108048), effects = c(3.24790515086836, -3.68250026717613, 0.167142503621275, 0.536781023244981, 0.904244823299413, 1.20288354379482, 1.46788145987641, -0.814283393543173, 
## -0.802717404173201, -0.250775008898426), rank = 2, fitted.values = c(0.797356921559395, 0.391926985636489, -0.0135029502864168, -0.418932886209323, -0.824362822132229, -1.22979275805513, -1.63522269397804, -2.04065262990095, -2.44608256582385, -2.85151250174676), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, -9.86365729932036, 
## 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0, -0.0461239173742539, -0.0683340451185094, -0.0826954948114599, -0.0992316640736845, 
## -0.184592912894936, -0.303594966130002, -2.96975978886624, -3.34219376881292, -3.17425134285481), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS2 m=6
## list(sap = -0.0627892058633876, H = 0.937210794136612, FD = 1.06278920586339, fitlm2 = list(coefficients = c(0.0184846258410089, -0.0627892058633876), residuals = c(-0.0184846258410089, -0.0210863822014578, 0.000225651068091885, 0.0293863623889466, 0.056372354140527, 0.0145332663330811, -0.0609466258881799), effects = c(0.29654072063453, -0.230297629125278, 0.00573439049949296, 0.0324191205316702, 0.0569291309945733, 0.0126140618984499, -0.0653418116114885), rank = 2, fitted.values = c(0.0184846258410089, 
## -0.0250375351727961, -0.0685596961866013, -0.112081857200406, -0.155604018214212, -0.199126179228017, -0.242648340241822), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), 
##     df.residual = 5, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0, -0.0461239173742539, -0.0683340451185094, -0.0826954948114599, -0.0992316640736845, -0.184592912894936, -0.303594966130002), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) 
## series.TS2 m=6
## list(sd = c(1, 0.954923623230736, 0.933948440546056, 0.920631441593112, 0.905532904281031, 0.831442684563655, 0.738159785624958, 0.0513156354385142, 0.0353593024389365, 0.0418254052550304), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
cat(paste0("\nseries.TS3 m=6\n",fd_sda(series$TS_3,  doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-11.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-12.png)<!-- -->

```
## 
## series.TS3 m=6
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1, 0.703568838742613, 0.452648677233727, 0.334686742869055, 0.213483888795352, 0.129250085569717, 0.0995585704709017, 0.0539243219036517, 0.0431328787104976, 0.0137184083696849)) 
## series.TS3 m=6
## list(sap = -0.637593769153149, H = 0.362406230846851, FD = 1.63759376915315, fitlm1 = list(coefficients = c(0.139892648340064, -0.637593769153149), residuals = c(-0.139892648340064, -0.0495358803219725, -0.0486390028145079, 0.0913860414079538, 0.0836987339065799, 0.0238328652696902, 0.204776132192427, 0.0335579540868241, 0.2522082135276, -0.451392408914531), effects = c(5.84662703844106, -4.01417682788471, -0.0130647062506229, 0.125575665600443, 0.116503685727674, 0.0552531447193891, 0.234811739270731, 
## 0.0622088887937324, 0.279474475863113, -0.425510818950413), rank = 2, fitted.values = c(0.139892648340064, -0.302053675091029, -0.743999998522124, -1.18594632195322, -1.62789264538431, -2.06983896881541, -2.5117852922465, -2.95373161567759, -3.39567793910869, -3.83762426253978), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 
## -9.86365729932036, 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(-1.11022302462516e-16, -0.351589555413002, -0.792639001336632, 
## -1.09456028054526, -1.54419391147773, -2.04600610354572, -2.30700916005407, -2.92017366159077, -3.14346972558109, -4.28901667145431), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS3 m=6
## list(sap = -0.569937473845897, H = 0.430062526154103, FD = 1.5699374738459, fitlm2 = list(coefficients = c(0.022866228936306, -0.569937473845897), residuals = c(-0.0228662289363059, 0.0205947687424329, -0.0254041240894557, 0.0677251497936529, 0.0131420719529259, -0.093619567023317, 0.0404279295600668), effects = c(3.07511820115046, -2.09041103755853, -0.0198677711504568, 0.0774149018887645, 0.0269852232041501, -0.0756230166159801, 0.0625778791235163), rank = 2, fitted.values = c(0.0228662289363058, 
## -0.372184324155435, -0.767234877247176, -1.16228543033892, -1.55733598343066, -1.9523865365224, -2.34743708961414), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 5, 
##     xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(-1.11022302462516e-16, -0.351589555413002, -0.792639001336632, -1.09456028054526, -1.54419391147773, -2.04600610354572, -2.30700916005407), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) 
## series.TS3 m=6
## list(sd = c(1, 0.703568838742613, 0.452648677233727, 0.334686742869055, 0.213483888795352, 0.129250085569717, 0.0995585704709017, 0.0539243219036517, 0.0431328787104976, 0.0137184083696849), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))


# ACF assignment data `series`
cat(paste0("\nseries.TS1 m=6, r=.5\n",fd_sda(series$TS_1, doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-13.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-14.png)<!-- -->

```
## 
## series.TS1 m=6, r=.5
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1, 0.697731680325664, 0.468549855670756, 0.32769607650484, 0.205069900641396, 0.11566142753874, 0.0935638214687908, 0.0768345451701486, 0.0281118638715009, 0.0162165566672667)) 
## series.TS1 m=6, r=.5
## list(sap = -0.6378456980678, H = 0.3621543019322, FD = 1.6378456980678, fitlm1 = list(coefficients = c(0.1291749479157, -0.6378456980678), residuals = c(-0.1291749479157, -0.0469746629336484, -0.00304582086589452, 0.0815191976529704, 0.0549044618509935, -0.0756582954591309, 0.154439242585115, 0.399570749761866, -0.163770959843595, -0.271808964832976), effects = c(5.88300432353931, -4.01576292746785, 0.0299552105750075, 0.113134361860518, 0.0851337588251869, -0.0468148657182919, 0.1818968050926, 0.425642445035997, 
## -0.139085131802819, -0.248509004025554), rank = 2, fitted.values = c(0.1291749479157, -0.312945999332286, -0.755066946580272, -1.19718789382826, -1.63930884107624, -2.08142978832423, -2.52355073557221, -2.9656716828202, -3.40779263006819, -3.84991357731617), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, -9.86365729932036, 6.29582191999199, 
## 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0, -0.359920662265935, -0.758112767446166, -1.11566869617529, -1.58440437922525, -2.15708808378336, 
## -2.3691114929871, -2.56610093305833, -3.57156358991178, -4.12172254214915), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS1 m=6, r=.5
## list(sap = -0.59397614538283, H = 0.40602385461717, FD = 1.59397614538283, fitlm2 = list(coefficients = c(0.0430949454926185, -0.59397614538283), residuals = c(-0.0430949454926176, 0.00869728273341902, 0.0222180680451608, 0.0763750298080126, 0.0193522372500224, -0.141618576816115, 0.0580709044721179), effects = c(3.15385125086663, -2.17857983960266, 0.0334768401180779, 0.0908057078634757, 0.0369548212880317, -0.12084408679556, 0.0820173004752194), rank = 2, fitted.values = c(0.0430949454926176, -0.368617944999354, 
## -0.780330835491327, -1.1920437259833, -1.60375661647527, -2.01546950696724, -2.42718239745922), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 5, xlevels = list(), 
##     call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0, -0.359920662265935, -0.758112767446166, -1.11566869617529, -1.58440437922525, -2.15708808378336, -2.3691114929871), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) 
## series.TS1 m=6, r=.5
## list(sd = c(1, 0.697731680325664, 0.468549855670756, 0.32769607650484, 0.205069900641396, 0.11566142753874, 0.0935638214687908, 0.0768345451701486, 0.0281118638715009, 0.0162165566672667), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
cat(paste0("\nseries.TS2 m=6, r=.5\n",fd_sda(series$TS_2, doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-15.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-16.png)<!-- -->

```
## 
## series.TS2 m=6, r=.5
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1, 0.954923623230736, 0.933948440546056, 0.920631441593112, 0.905532904281031, 0.831442684563655, 0.738159785624958, 0.0513156354385142, 0.0353593024389365, 0.0418254052550304)) 
## series.TS2 m=6, r=.5
## list(sap = -0.584911757983907, H = 0.415088242016093, FD = 1.58491175798391, fitlm1 = list(coefficients = c(0.797356921559395, -0.584911757983907), residuals = c(-0.797356921559395, -0.438050903010743, -0.0548310948320926, 0.336237391397863, 0.725131158058544, 1.0451998451602, 1.33162772784804, -0.929107158965294, -0.896111202989072, -0.322738841108048), effects = c(3.24790515086836, -3.68250026717613, 0.167142503621275, 0.536781023244981, 0.904244823299413, 1.20288354379482, 1.46788145987641, -0.814283393543173, 
## -0.802717404173201, -0.250775008898426), rank = 2, fitted.values = c(0.797356921559395, 0.391926985636489, -0.0135029502864168, -0.418932886209323, -0.824362822132229, -1.22979275805513, -1.63522269397804, -2.04065262990095, -2.44608256582385, -2.85151250174676), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, -9.86365729932036, 
## 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0, -0.0461239173742539, -0.0683340451185094, -0.0826954948114599, -0.0992316640736845, 
## -0.184592912894936, -0.303594966130002, -2.96975978886624, -3.34219376881292, -3.17425134285481), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS2 m=6, r=.5
## list(sap = -0.0627892058633876, H = 0.937210794136612, FD = 1.06278920586339, fitlm2 = list(coefficients = c(0.0184846258410089, -0.0627892058633876), residuals = c(-0.0184846258410089, -0.0210863822014578, 0.000225651068091885, 0.0293863623889466, 0.056372354140527, 0.0145332663330811, -0.0609466258881799), effects = c(0.29654072063453, -0.230297629125278, 0.00573439049949296, 0.0324191205316702, 0.0569291309945733, 0.0126140618984499, -0.0653418116114885), rank = 2, fitted.values = c(0.0184846258410089, 
## -0.0250375351727961, -0.0685596961866013, -0.112081857200406, -0.155604018214212, -0.199126179228017, -0.242648340241822), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), 
##     df.residual = 5, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0, -0.0461239173742539, -0.0683340451185094, -0.0826954948114599, -0.0992316640736845, -0.184592912894936, -0.303594966130002), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) 
## series.TS2 m=6, r=.5
## list(sd = c(1, 0.954923623230736, 0.933948440546056, 0.920631441593112, 0.905532904281031, 0.831442684563655, 0.738159785624958, 0.0513156354385142, 0.0353593024389365, 0.0418254052550304), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
cat(paste0("\nseries.TS3 m=6, r=.5\n",fd_sda(series$TS_3, doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-17.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-17-18.png)<!-- -->

```
## 
## series.TS3 m=6, r=.5
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625, 0.001953125), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512), bulk = c(1, 0.703568838742613, 0.452648677233727, 0.334686742869055, 0.213483888795352, 0.129250085569717, 0.0995585704709017, 0.0539243219036517, 0.0431328787104976, 0.0137184083696849)) 
## series.TS3 m=6, r=.5
## list(sap = -0.637593769153149, H = 0.362406230846851, FD = 1.63759376915315, fitlm1 = list(coefficients = c(0.139892648340064, -0.637593769153149), residuals = c(-0.139892648340064, -0.0495358803219725, -0.0486390028145079, 0.0913860414079538, 0.0836987339065799, 0.0238328652696902, 0.204776132192427, 0.0335579540868241, 0.2522082135276, -0.451392408914531), effects = c(5.84662703844106, -4.01417682788471, -0.0130647062506229, 0.125575665600443, 0.116503685727674, 0.0552531447193891, 0.234811739270731, 
## 0.0622088887937324, 0.279474475863113, -0.425510818950413), rank = 2, fitted.values = c(0.139892648340064, -0.302053675091029, -0.743999998522124, -1.18594632195322, -1.62789264538431, -2.06983896881541, -2.5117852922465, -2.95373161567759, -3.39567793910869, -3.83762426253978), assign = 0:1, qr = list(qr = c(-3.16227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 0.316227766016838, 
## -9.86365729932036, 6.29582191999199, 0.15621147358221, 0.0461150970695743, -0.0639812794430618, -0.174077655955698, -0.284174032468334, -0.39427040898097, -0.504366785493606, -0.614463162006242), qraux = c(1.31622776601684, 1.26630785009485), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 8, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(-1.11022302462516e-16, -0.351589555413002, -0.792639001336632, 
## -1.09456028054526, -1.54419391147773, -2.04600610354572, -2.30700916005407, -2.92017366159077, -3.14346972558109, -4.28901667145431), `log(out$scale)` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956, 6.23832462503951)))) 
## series.TS3 m=6, r=.5
## list(sap = -0.569937473845897, H = 0.430062526154103, FD = 1.5699374738459, fitlm2 = list(coefficients = c(0.022866228936306, -0.569937473845897), residuals = c(-0.0228662289363059, 0.0205947687424329, -0.0254041240894557, 0.0677251497936529, 0.0131420719529259, -0.093619567023317, 0.0404279295600668), effects = c(3.07511820115046, -2.09041103755853, -0.0198677711504568, 0.0774149018887645, 0.0269852232041501, -0.0756230166159801, 0.0625778791235163), rank = 2, fitted.values = c(0.0228662289363058, 
## -0.372184324155435, -0.767234877247176, -1.16228543033892, -1.55733598343066, -1.9523865365224, -2.34743708961414), assign = 0:1, qr = list(qr = c(-2.64575131106459, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, 0.377964473009227, -5.5016851851816, 3.6677901234544, 0.0334733547569204, -0.155508881747693, -0.344491118252307, -0.53347335475692, -0.722455591261534), qraux = c(1.37796447300923, 1.22245559126153), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 5, 
##     xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(-1.11022302462516e-16, -0.351589555413002, -0.792639001336632, -1.09456028054526, -1.54419391147773, -2.04600610354572, -2.30700916005407), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967)))) 
## series.TS3 m=6, r=.5
## list(sd = c(1, 0.703568838742613, 0.452648677233727, 0.334686742869055, 0.213483888795352, 0.129250085569717, 0.0995585704709017, 0.0539243219036517, 0.0431328787104976, 0.0137184083696849), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256, 512))
```



**Values of other time series**


```r

L1 <- floor(log2(length(TS1$TS1)))
L2 <- floor(log2(length(TS2$TS2)))
L3 <- floor(log2(length(TS2$TS2)))

# RR assignment data `TS1,TS2,TS3`
cat(paste0("\nTS1\n",fd_sda(TS1$TS1[1:2^L1],  doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-1.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-2.png)<!-- -->

```
## 
## TS1
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256), bulk = c(1, 0.927720761522386, 0.852391368552144, 0.760349882879778, 0.680693180762036, 0.619307412593876, 0.469499935042278, 0.421105973261919, 0.501847296489077)) 
## TS1
## list(sap = -0.156900504163069, H = 0.843099495836931, FD = 1.15690050416307, fitlm1 = list(coefficients = c(0.0258066826688918, -0.156900504163069), residuals = c(-0.0258066826688918, 0.00792396441177382, 0.0319940966469679, 0.0264821641680045, 0.0245702691304575, 0.0388155259769911, -0.129362948823437, -0.129391447059041, 0.154775058217175), effects = c(1.2276416570621, -0.84241370825074, 0.036970733022294, 0.0329338348352275, 0.0324969740895774, 0.0482172652280078, -0.118486175280524, -0.117039639224231, 
## 0.168601900343883), rank = 2, fitted.values = c(0.0258066826688917, -0.0829484594201734, -0.191703601509238, -0.300458743598303, -0.409213885687368, -0.517969027776433, -0.626724169865498, -0.735479311954563, -0.844234454043628), assign = 0:1, qr = list(qr = c(-3, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, -8.31776616671934, 5.36909497355859, 0.129099444873581, 0, -0.129099444873581, -0.258198889747161, 
## -0.387298334620742, -0.516397779494322, -0.645497224367903), qraux = c(1.33333333333333, 1.25819888974716), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 7, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(-1.11022302462516e-16, -0.0750244950083996, -0.15970950486227, -0.273976579430299, -0.384643616556911, -0.479153501799442, -0.756087118688935, -0.864870759013605, -0.689459395826453), `log(out$scale)` = c(0, 
## 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956)))) 
## TS1
## list(sap = -0.141750638852476, H = 0.858249361147524, FD = 1.14175063885248, fitlm2 = list(coefficients = c(0.0168838562150253, -0.141750638852476), residuals = c(-0.0168838562150254, 0.0063457044397399, 0.0199147502490342, 0.00390173134417069, -0.00851125011927639, -0.00476707969864295), effects = c(0.560323921217094, -0.41102620409112, 0.0253188083834734, 0.0115726392217148, 0.00142650750137252, 0.0074375276651108), rank = 2, fitted.values = c(0.0168838562150253, -0.0813701994481395, -0.179624255111304, 
## -0.277878310774469, -0.376132366437634, -0.474386422100799), assign = 0:1, qr = list(qr = c(-2.44948974278318, 0.408248290463863, 0.408248290463863, 0.408248290463863, 0.408248290463863, 0.408248290463863, -4.24464227255166, 2.89964269239652, -0.0537243000176811, -0.29277002188456, -0.531815743751439, -0.770861465618317), qraux = c(1.40824829046386, 1.1853214218492), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 4, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), 
##     terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(-1.11022302462516e-16, -0.0750244950083996, -0.15970950486227, -0.273976579430299, -0.384643616556911, -0.479153501799442), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973)))) 
## TS1
## list(sd = c(1, 0.927720761522386, 0.852391368552144, 0.760349882879778, 0.680693180762036, 0.619307412593876, 0.469499935042278, 0.421105973261919, 0.501847296489077), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256))
cat(paste0("TS1Random\n",fd_sda(TS1Random[1:2^L1],  doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-3.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-4.png)<!-- -->

```
## TS1Random
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256), bulk = c(1, 0.736784495767938, 0.490375420758547, 0.351261447772413, 0.203967585112868, 0.174278471745666, 0.11978842024717, 0.0421380514854265, 0.0493334286396002)) TS1Random
## list(sap = -0.580454190372883, H = 0.419545809627117, FD = 1.58045419037288, fitlm1 = list(coefficients = c(0.0872330651771014, -0.580454190372883), residuals = c(-0.0872330651771016, 0.00964728340139284, 0.00486328940670164, 0.0735630239840165, -0.0676665174412819, 0.177367015597491, 0.20477979081869, -0.437655877417953, 0.122335056828045), effects = c(4.56638303048273, -3.11651367591206, 0.0234440103287822, 0.0953712902782919, -0.0426307057748117, 0.205630372636156, 0.23627069322955, -0.402937429634899, 
## 0.160281049983295), rank = 2, fitted.values = c(0.0872330651771016, -0.315107120324069, -0.717447305825238, -1.11978749132641, -1.52212767682758, -1.92446786232875, -2.32680804782992, -2.72914823333109, -3.13148841883225), assign = 0:1, qr = list(qr = c(-3, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, -8.31776616671934, 5.36909497355859, 0.129099444873581, 0, -0.129099444873581, -0.258198889747161, 
## -0.387298334620742, -0.516397779494322, -0.645497224367903), qraux = c(1.33333333333333, 1.25819888974716), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 7, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0, -0.305459836922676, -0.712584016418536, -1.04622446734239, -1.58979419426886, -1.74710084673126, -2.12202825701123, -3.16680411074904, -3.00915336200421), `log(out$scale)` = c(0, 0.693147180559945, 
## 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956)))) TS1Random
## list(sap = -0.532649099603092, H = 0.467350900396908, FD = 1.53264909960309, fitlm2 = list(coefficients = c(0.0228166604302384, -0.532649099603092), residuals = c(-0.0228166604302383, 0.0409277242647614, 0.00300776638657858, 0.0385715370804006, -0.135793968228391, 0.0761036009268887), effects = c(2.20501570892343, -1.54449206927569, 0.0117771051112884, 0.0569287950298202, -0.107848791054261, 0.113636697325728), rank = 2, fitted.values = c(0.0228166604302383, -0.346387561187437, -0.715591782805115, 
## -1.08479600442279, -1.45400022604047, -1.82320444765814), assign = 0:1, qr = list(qr = c(-2.44948974278318, 0.408248290463863, 0.408248290463863, 0.408248290463863, 0.408248290463863, 0.408248290463863, -4.24464227255166, 2.89964269239652, -0.0537243000176811, -0.29277002188456, -0.531815743751439, -0.770861465618317), qraux = c(1.40824829046386, 1.1853214218492), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 4, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), 
##     terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0, -0.305459836922676, -0.712584016418536, -1.04622446734239, -1.58979419426886, -1.74710084673126), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973)))) TS1Random
## list(sd = c(1, 0.736784495767938, 0.490375420758547, 0.351261447772413, 0.203967585112868, 0.174278471745666, 0.11978842024717, 0.0421380514854265, 0.0493334286396002), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256))

cat(paste0("\nTS2\n",fd_sda(TS2$TS2[1:2^L2],  doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-5.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-6.png)<!-- -->

```
## 
## TS2
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256), bulk = c(1, 0.972331062337949, 0.963231894533936, 0.948785258529033, 0.921847818034698, 0.853003358071085, 0.791059338742827, 0.733445343515011, 0.892498770258937)) 
## TS2
## list(sap = -0.0433051795240074, H = 0.956694820475993, FD = 1.04330517952401, fitlm1 = list(coefficients = c(0.00711474437520617, -0.0433051795240074), residuals = c(-0.00711474437520613, -0.00515681468378995, 0.0154578899262668, 0.0303630570740441, 0.0315775825772835, -0.0160222236425169, -0.061395862485113, -0.106998901550999, 0.119290017160031), effects = c(0.338858123962878, -0.232509621711401, 0.0175831941336534, 0.0321417431678456, 0.0330096505574998, -0.0149367737758857, -0.0606570307320669, 
## -0.106606687911538, 0.119335612685907), rank = 2, fitted.values = c(0.00711474437520613, -0.0229021187155019, -0.0529189818062099, -0.0829358448969179, -0.112952707987626, -0.142969571078334, -0.172986434169042, -0.20300329725975, -0.233020160350458), assign = 0:1, qr = list(qr = c(-3, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, -8.31776616671934, 5.36909497355859, 0.129099444873581, 0, -0.129099444873581, 
## -0.258198889747161, -0.387298334620742, -0.516397779494322, -0.645497224367903), qraux = c(1.33333333333333, 1.25819888974716), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 7, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0, -0.0280589333992919, -0.0374610918799431, -0.0525727878228738, -0.0813751254103425, -0.158991794720851, -0.234382296654155, -0.310002198810749, -0.113730143190427), `log(out$scale)` = c(0, 
## 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956)))) 
## TS2
## list(sap = -0.0399840558618744, H = 0.960015944138126, FD = 1.03998405586187, fitlm2 = list(coefficients = c(0.00954380009780702, -0.0399840558618744), residuals = c(-0.00954380009780702, -0.00988789790908932, 0.00842477919826909, 0.021027918843348, 0.019940416843889, -0.0299614168786098), effects = c(0.146340573292628, -0.115939475392258, 0.0108687426087248, 0.022035744212768, 0.0195121041722732, -0.0318258675912613), rank = 2, fitted.values = c(0.00954380009780702, -0.0181710354902026, -0.0458858710782122, 
## -0.0736007066662219, -0.101315542254232, -0.129030377842241), assign = 0:1, qr = list(qr = c(-2.44948974278318, 0.408248290463863, 0.408248290463863, 0.408248290463863, 0.408248290463863, 0.408248290463863, -4.24464227255166, 2.89964269239652, -0.0537243000176811, -0.29277002188456, -0.531815743751439, -0.770861465618317), qraux = c(1.40824829046386, 1.1853214218492), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 4, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), 
##     terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0, -0.0280589333992919, -0.0374610918799431, -0.0525727878228738, -0.0813751254103425, -0.158991794720851), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973)))) 
## TS2
## list(sd = c(1, 0.972331062337949, 0.963231894533936, 0.948785258529033, 0.921847818034698, 0.853003358071085, 0.791059338742827, 0.733445343515011, 0.892498770258937), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256))
cat(paste0("TS2Random\n",fd_sda(TS2Random[1:2^L2],  doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-7.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-8.png)<!-- -->

```
## TS2Random
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256), bulk = c(1, 0.665027044107143, 0.498299235385665, 0.373757666310699, 0.262220805464774, 0.163762410631456, 0.142106384140075, 0.147867088013552, 0.146118627467492)) TS2Random
## list(sap = -0.373617816073593, H = 0.626382183926407, FD = 1.37361781607359, fitlm1 = list(coefficients = c(-0.188833006866722, -0.373617816073593), residuals = c(0.188833006866721, 0.0398775713621911, 0.0102227703617322, -0.0183982282976663, -0.113846811061646, -0.32564493126434, -0.208513496017177, 0.0901964949227921, 0.337273623127393), effects = c(3.67416465042067, -2.00598953831267, -0.0362333055487046, -0.0656064800143465, -0.16180723858457, -0.374357534593507, -0.257978275152588, 0.039979539981138, 
## 0.286304492379496), rank = 2, fitted.values = c(-0.188833006866721, -0.447805142685098, -0.706777278503472, -0.965749414321848, -1.22472155014022, -1.4836936859586, -1.74266582177697, -2.00163795759535, -2.26061009341372), assign = 0:1, qr = list(qr = c(-3, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, -8.31776616671934, 5.36909497355859, 0.129099444873581, 0, -0.129099444873581, -0.258198889747161, 
## -0.387298334620742, -0.516397779494322, -0.645497224367903), qraux = c(1.33333333333333, 1.25819888974716), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 7, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(-1.11022302462516e-16, -0.407927571322906, -0.69655450814174, -0.984147642619514, -1.33856836120187, -1.80933861722294, -1.95117931779415, -1.91144146267256, -1.92333647028633), `log(out$scale)` = c(0, 
## 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956)))) TS2Random
## list(sap = -0.499840599940258, H = 0.500159400059742, FD = 1.49984059994026, fitlm2 = list(coefficients = c(-0.00659836030654118, -0.499840599940258), residuals = c(0.00659836030654096, -0.0548661084383844, 0.00297005732076395, 0.0618400254209716, 0.0538824094165979, -0.07042474402649), effects = c(2.13780715593407, -1.44935914297986, -0.00151628129190563, 0.0459029805918213, 0.0264946583709669, -0.109263201288602), rank = 2, fitted.values = c(-0.00659836030654108, -0.353061462884522, -0.699524565462504, 
## -1.04598766804049, -1.39245077061847, -1.73891387319645), assign = 0:1, qr = list(qr = c(-2.44948974278318, 0.408248290463863, 0.408248290463863, 0.408248290463863, 0.408248290463863, 0.408248290463863, -4.24464227255166, 2.89964269239652, -0.0537243000176811, -0.29277002188456, -0.531815743751439, -0.770861465618317), qraux = c(1.40824829046386, 1.1853214218492), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 4, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), 
##     terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(-1.11022302462516e-16, -0.407927571322906, -0.69655450814174, -0.984147642619514, -1.33856836120187, -1.80933861722294), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973)))) TS2Random
## list(sd = c(1, 0.665027044107143, 0.498299235385665, 0.373757666310699, 0.262220805464774, 0.163762410631456, 0.142106384140075, 0.147867088013552, 0.146118627467492), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256))

cat(paste0("\nTS3\n",fd_sda(TS3$TS3[1:2^L3],  doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-9.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-10.png)<!-- -->

```
## 
## TS3
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256), bulk = c(1, 0.703818699352563, 0.455103059103604, 0.329441465069497, 0.187434951507007, 0.124643457994431, 0.0825233008058861, 0.0608710690260373, 0.0274579031268894)) 
## TS3
## list(sap = -0.62782532225638, H = 0.37217467774362, FD = 1.62782532225638, fitlm1 = list(coefficients = c(0.0857884150540169, -0.62782532225638), residuals = c(-0.0857884150540172, -0.00184754836707971, -0.00266909319655301, 0.1093810524031, -0.0194104260895578, 0.00779039158993378, 0.0305891054751376, 0.161441774803668, -0.199486841564632), effects = c(4.96473897891173, -3.37085378199953, 0.0167669678438442, 0.130828156166604, 0.00404772039705353, 0.0332595807996522, 0.0580693374079631, 0.190933049459601, 
## -0.167984524185592), rank = 2, fitted.values = c(0.0857884150540171, -0.349386936952133, -0.784562288958281, -1.21973764096443, -1.65491299297058, -2.09008834497673, -2.52526369698288, -2.96043904898902, -3.39561440099517), assign = 0:1, qr = list(qr = c(-3, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, -8.31776616671934, 5.36909497355859, 0.129099444873581, 0, -0.129099444873581, -0.258198889747161, 
## -0.387298334620742, -0.516397779494322, -0.645497224367903), qraux = c(1.33333333333333, 1.25819888974716), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 7, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(-1.11022302462516e-16, -0.351234485319213, -0.787231382154834, -1.11035658856133, -1.67432341906014, -2.08229795338679, -2.49467459150774, -2.79899727418536, -3.5951012425598), `log(out$scale)` = c(0, 
## 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956)))) 
## TS3
## list(sap = -0.606091923370856, H = 0.393908076629144, FD = 1.60609192337086, fitlm2 = list(coefficients = c(0.049369964864608, -0.606091923370856), residuals = c(-0.0493699648646081, 0.0195064576608416, 0.00362046866988547, 0.100606170108053, -0.0432497525460894, -0.031113379028083), effects = c(2.45171217645466, -1.75745001652285, 0.0194655419737456, 0.123271518151916, -0.0137641297622249, 0.00519251849578373), rank = 2, fitted.values = c(0.049369964864608, -0.370740942980055, -0.790851850824719, 
## -1.21096275866938, -1.63107366651405, -2.05118457435871), assign = 0:1, qr = list(qr = c(-2.44948974278318, 0.408248290463863, 0.408248290463863, 0.408248290463863, 0.408248290463863, 0.408248290463863, -4.24464227255166, 2.89964269239652, -0.0537243000176811, -0.29277002188456, -0.531815743751439, -0.770861465618317), qraux = c(1.40824829046386, 1.1853214218492), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 4, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), 
##     terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(-1.11022302462516e-16, -0.351234485319213, -0.787231382154834, -1.11035658856133, -1.67432341906014, -2.08229795338679), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973)))) 
## TS3
## list(sd = c(1, 0.703818699352563, 0.455103059103604, 0.329441465069497, 0.187434951507007, 0.124643457994431, 0.0825233008058861, 0.0608710690260373, 0.0274579031268894), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256))
cat(paste0("TS3Int\n",fd_sda(TS3Norm[1:2^L3],  doPlot = TRUE)))
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-11.png)<!-- -->![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-18-12.png)<!-- -->

```
## TS3Int
## list(freq.norm = c(1, 0.5, 0.25, 0.125, 0.0625, 0.03125, 0.015625, 0.0078125, 0.00390625), size = c(1, 2, 4, 8, 16, 32, 64, 128, 256), bulk = c(1, 0.703818699352563, 0.455103059103604, 0.329441465069497, 0.187434951507007, 0.124643457994431, 0.0825233008058861, 0.0608710690260373, 0.0274579031268894)) TS3Int
## list(sap = -0.62782532225638, H = 0.37217467774362, FD = 1.62782532225638, fitlm1 = list(coefficients = c(0.0857884150540169, -0.62782532225638), residuals = c(-0.0857884150540173, -0.00184754836707951, -0.00266909319655301, 0.1093810524031, -0.0194104260895579, 0.00779039158993371, 0.0305891054751375, 0.161441774803669, -0.199486841564632), effects = c(4.96473897891173, -3.37085378199953, 0.0167669678438442, 0.130828156166604, 0.00404772039705353, 0.0332595807996522, 0.0580693374079631, 0.190933049459601, 
## -0.167984524185592), rank = 2, fitted.values = c(0.0857884150540173, -0.349386936952133, -0.784562288958281, -1.21973764096443, -1.65491299297058, -2.09008834497673, -2.52526369698288, -2.96043904898902, -3.39561440099517), assign = 0:1, qr = list(qr = c(-3, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, 0.333333333333333, -8.31776616671934, 5.36909497355859, 0.129099444873581, 0, -0.129099444873581, -0.258198889747161, 
## -0.387298334620742, -0.516397779494322, -0.645497224367903), qraux = c(1.33333333333333, 1.25819888974716), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 7, xlevels = list(), call = stats::lm(formula = log(out$sd) ~ log(out$scale)), terms = log(out$sd) ~ log(out$scale), model = list(`log(out$sd)` = c(0, -0.351234485319213, -0.787231382154834, -1.11035658856133, -1.67432341906014, -2.08229795338679, -2.49467459150774, -2.79899727418536, -3.5951012425598), `log(out$scale)` = c(0, 0.693147180559945, 
## 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973, 4.15888308335967, 4.85203026391962, 5.54517744447956)))) TS3Int
## list(sap = -0.606091923370856, H = 0.393908076629144, FD = 1.60609192337086, fitlm2 = list(coefficients = c(0.0493699648646084, -0.606091923370856), residuals = c(-0.049369964864608, 0.0195064576608418, 0.00362046866988527, 0.100606170108053, -0.0432497525460894, -0.0311133790280829), effects = c(2.45171217645466, -1.75745001652285, 0.0194655419737454, 0.123271518151916, -0.0137641297622249, 0.00519251849578395), rank = 2, fitted.values = c(0.049369964864608, -0.370740942980055, -0.790851850824719, 
## -1.21096275866938, -1.63107366651405, -2.05118457435871), assign = 0:1, qr = list(qr = c(-2.44948974278318, 0.408248290463863, 0.408248290463863, 0.408248290463863, 0.408248290463863, 0.408248290463863, -4.24464227255166, 2.89964269239652, -0.0537243000176811, -0.29277002188456, -0.531815743751439, -0.770861465618317), qraux = c(1.40824829046386, 1.1853214218492), pivot = 1:2, tol = 1e-07, rank = 2), df.residual = 4, xlevels = list(), call = stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins])), 
##     terms = log(out$sd[bins]) ~ log(out$scale[bins]), model = list(`log(out$sd[bins])` = c(0, -0.351234485319213, -0.787231382154834, -1.11035658856133, -1.67432341906014, -2.08229795338679), `log(out$scale[bins])` = c(0, 0.693147180559945, 1.38629436111989, 2.07944154167984, 2.77258872223978, 3.46573590279973)))) TS3Int
## list(sd = c(1, 0.703818699352563, 0.455103059103604, 0.329441465069497, 0.187434951507007, 0.124643457994431, 0.0825233008058861, 0.0608710690260373, 0.0274579031268894), scale = c(1, 2, 4, 8, 16, 32, 64, 128, 256))

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
## 1  1.000000000    1 1.00000000
## 2  0.500000000    2 0.97964924
## 3  0.250000000    4 0.97396271
## 4  0.125000000    8 0.72396897
## 5  0.062500000   16 0.51906450
## 6  0.031250000   32 0.36878538
## 7  0.015625000   64 0.26097822
## 8  0.007812500  128 0.18454456
## 9  0.003906250  256 0.13049271
## 10 0.001953125  512 0.09227228
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
##         0.3418         -0.4134  
## 
## 
## 
## $fitRange
## $fitRange$sap
## log(out$scale[bins]) 
##            -0.340747 
## 
## $fitRange$H
## log(out$scale[bins]) 
##             0.659253 
## 
## $fitRange$FD
## log(out$scale[bins]) 
##             1.340747 
## 
## $fitRange$fitlm2
## 
## Call:
## stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins]))
## 
## Coefficients:
##          (Intercept)  log(out$scale[bins])  
##               0.2276               -0.3407  
## 
## 
## 
## $info
## $info$sd
##  [1] 1.00000000 0.97964924 0.97396271 0.72396897 0.51906450 0.36878538
##  [7] 0.26097822 0.18454456 0.13049271 0.09227228
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
## 1  1.000000000    1 1.00000000
## 2  0.500000000    2 0.70356884
## 3  0.250000000    4 0.45264868
## 4  0.125000000    8 0.33468674
## 5  0.062500000   16 0.21348389
## 6  0.031250000   32 0.12925009
## 7  0.015625000   64 0.09955857
## 8  0.007812500  128 0.05392432
## 9  0.003906250  256 0.04313288
## 10 0.001953125  512 0.01371841
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
##         0.1399         -0.6376  
## 
## 
## 
## $fitRange
## $fitRange$sap
## log(out$scale[bins]) 
##           -0.5699375 
## 
## $fitRange$H
## log(out$scale[bins]) 
##            0.4300625 
## 
## $fitRange$FD
## log(out$scale[bins]) 
##             1.569937 
## 
## $fitRange$fitlm2
## 
## Call:
## stats::lm(formula = log(out$sd[bins]) ~ log(out$scale[bins]))
## 
## Coefficients:
##          (Intercept)  log(out$scale[bins])  
##              0.02287              -0.56994  
## 
## 
## 
## $info
## $info$sd
##  [1] 1.00000000 0.70356884 0.45264868 0.33468674 0.21348389 0.12925009
##  [7] 0.09955857 0.05392432 0.04313288 0.01371841
## 
## $info$scale
##  [1]   1   2   4   8  16  32  64 128 256 512
```



###  Spectral Slope {.tabset .tabset-fade .tabset-pills}


#### Questions {-}

* Common data preparation before running fluctuation analyses:
    + Normalize the time series (using `sd` based on `N`, not `N-1`)
    + Check whether time series length is a power of `2`. If you use `N <- log2(length(y))`, the number you get is `2^N`. You need an integer power for the length in order to create equal bin sizes. You can pad the series with 0s, or make it shorter before analysis.
* Perform `psd` on the 3 HRV time series, or any of the other series you already analysed.
* Compare to what you find for `psd` to the other measures (`RR`,`SampEn`, `acf`, `pacf`)


#### Answers {-}

See `sda`

###  Detrended Fluctuation Analysis {.tabset .tabset-fade .tabset-pills}


#### Questions {-}

* Common data preparation before running fluctuation analyses:
    + Normalize the time series (using `sd` based on `N`, not `N-1`)
    + Check whether time series length is a power of `2`. If you use `N <- log2(length(y))`, the number you get is `2^N`. You need an integer power for the length in order to create equal bin sizes. You can pad the series with 0s, or make it shorter before analysis.
* Perform `dfa` on the 3 HRV time series, or any of the other series you already analysed.
* Compare to what you find for `dfa` to the other measures (`RR`,`SampEn`, `acf`, `pacf`)


#### Answers {-}

See `sda`



## **Surrogate testing: Beyond the straw-man null-hypothesis** 

Look at the explanation of surrogate analysis on the [TiSEAN website](https://www.pks.mpg.de/~tisean/Tisean_3.0.1/)
(Here is [direct link](https://www.pks.mpg.de/~tisean/Tisean_3.0.1/docs/surropaper/node5.html) to the relevant sections)


### Constrained realisations of complex signals {.tabset .tabset-fade .tabset-pills}

We'll look mostly at three different kinds of surrogates:

* *Randomly shuffled*: $H_0:$ The time series data are independent random numbers drawn from some probability distribution.
* *Phase Randomised*: $H_0:$ The time series data were generated by a stationary linear stochastic process
* *Amplitude Adjusted ,Phase Randomised*: $H_0:$ The time series data were generated by a rescaled linear stochastic process


#### Questions {-}

* Figure out how many surrogates you minimally need for a 2-sided test.
* Package `nonlinearTseries` has a function `FFTsurrogate` and package `fractal` `surrogate`. Look them up and try to create a surrogate test for some of the time series of the previous assignments.
    + If you use `fractal::surrogate()`, choose either `aaft` (amplitude adjusted Fourier transform) or `phase` (phase randomisation)
    + `nonlinearTseries::FFTsurrogates` will calculate phase randomised surrogates.
* In package `casnet` there's a function that will calculate and display a point-probability based on a distribution of surrogate measures and one observed measure: `plotSUR_hist`



#### Answers {-}


Create a number of surrogates, calulate the slopes and plot the results.

* First let's get the values we found earlier (we'll use the FD from `sda`, then we do the same for `psd`,but you can take any of the measures as well)



```r
library(casnet)
library(fractal)
library(plyr)

# RR assignment data `TS1,TS2,TS3`
L1 <- floor(log2(length(TS1$TS1)))
L2 <- floor(log2(length(TS2$TS2)))
L3 <- floor(log2(length(TS2$TS2)))

TS1_FDsda <- fd_sda(TS1$TS1[1:2^L1])$fitRange$FD
TS2_FDsda <- fd_sda(TS2$TS2[1:2^L2])$fitRange$FD
TS3_FDsda <- fd_sda(TS3$TS3[1:2^L3])$fitRange$FD

y1<-growth_ac(r = 2.9,type="logistic",N = 2^L1)
TSlogMapr29 <- fd_sda(y1)$fitRange$FD

y2<-growth_ac(r = 4,type="logistic", N = 2^L1)
TSlogMapr4 <- fd_sda(y2)$fitRange$FD


TS1R_FDsda <- fd_sda(TS1Random[1:2^L1])$fitRange$FD
TS2R_FDsda <- fd_sda(TS1Random[1:2^L2])$fitRange$FD
TS3R_FDsda <- fd_sda(TS1Random[1:2^L3])$fitRange$FD
```


* To create the surrogates using `fractal::surrogate()`
    + You'll need to repeatedly call the function and store the result
    + To get into a dataframe we have to use `unclass()` otherwise `R` doesn't recognise the object
    + Function `t()` trnasposes the data from 39 rows to 39 columns
* Once you have the surrogates in a datafram, repeatedly calculate the measure you want to compare, in this case `fd_sda()`.


```r
# NOW CREATE SURROGATES
library(dplyr)

# For a two-sided test at alpha = .05 we need N=39
Nsurrogates <- 39

TS1surrogates <- t(ldply(1:Nsurrogates, function(s) unclass(surrogate(x=TS1$TS1[1:2^L1] ,method="aaft"))))
colnames(TS1surrogates) <- paste0("aaftSurr",1:NCOL(TS1surrogates))

TS1surrogates_FD <- laply(1:Nsurrogates,function(s) fd_sda(y=TS1surrogates[,s])$fitRange$FD)


TS2surrogates <- t(ldply(1:Nsurrogates, function(s) unclass(surrogate(x=TS2$TS2[1:2^L2] ,method="aaft"))))
colnames(TS2surrogates) <- paste0("aaftSurr",1:NCOL(TS2surrogates))

TS2surrogates_FD <- laply(1:Nsurrogates,function(s) fd_sda(y=TS2surrogates[,s])$fitRange$FD)


TS3surrogates <- t(ldply(1:Nsurrogates, function(s) unclass(surrogate(x=TS3$TS3[1:2^L3] ,method="aaft"))))
colnames(TS3surrogates) <- paste0("aaftSurr",1:NCOL(TS3surrogates))

TS3surrogates_FD <- laply(1:Nsurrogates,function(s) fd_sda(y=TS3surrogates[,s])$fitRange$FD)


TSr29surrogates <- t(ldply(1:Nsurrogates, function(s) unclass(surrogate(x=y1, method="aaft"))))
colnames(TSr29surrogates) <- paste0("aaftSurr",1:NCOL(TSr29surrogates))

TSr29surrogates_FD <- laply(1:Nsurrogates,function(s) fd_sda(y=TSr29surrogates[,s])$fitRange$FD)


TSr4surrogates <- t(ldply(1:Nsurrogates, function(s) unclass(surrogate(x=y2, method="aaft"))))
colnames(TSr4surrogates) <- paste0("aaftSurr",1:NCOL(TSr4surrogates))

TSr4surrogates_FD <- laply(1:Nsurrogates,function(s) fd_sda(y=TSr4surrogates[,s])$fitRange$FD)
```

* Collect the results in a dataframe, so we can compare.


```r
x <- data.frame(Source = c("TS1", "TS2", "TS3", "TSlogMapr29", "TSlogMapr4"), 
                FDsda = c(TS1_FDsda, TS2_FDsda, TS3_FDsda, TSlogMapr29, TSlogMapr4), 
                FDsdaRandom =  c(TS1R_FDsda, TS2R_FDsda, TS3R_FDsda,NA,NA), 
                FDsdaAAFT.median= c(median(TS1surrogates_FD),median(TS2surrogates_FD),median(TS3surrogates_FD),median(TSr29surrogates_FD),median(TSr4surrogates_FD)))
```


* Call function `plotSUR_hist()` to see the results of the test.


```r
plotSUR_hist(surrogateValues = TS1surrogates_FD, observedValue = TS1_FDsda, sides = "two.sided", doPlot = TRUE, measureName = "sda FD TS1")
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-22-1.png)<!-- -->

```r
plotSUR_hist(surrogateValues = TS2surrogates_FD, observedValue = TS2_FDsda, sides = "two.sided", doPlot = TRUE, measureName = "sda FD TS2")
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-22-2.png)<!-- -->

```r
plotSUR_hist(surrogateValues = TS3surrogates_FD, observedValue = TS3_FDsda,sides = "two.sided", doPlot = TRUE, measureName = "sda FD TS3")
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-22-3.png)<!-- -->

```r
plotSUR_hist(surrogateValues = TSr29surrogates_FD, observedValue = TSlogMapr29,sides = "two.sided", doPlot = TRUE, measureName = "sda FD logMap r=2.9")
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-22-4.png)<!-- -->

```r
plotSUR_hist(surrogateValues = TSr4surrogates_FD, observedValue = TSlogMapr4, sides = "two.sided", doPlot = TRUE, measureName = "sda FD logMap r=4")
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-22-5.png)<!-- -->

**FD: SPECTRAL SLOPE**


```r
# RR assignment data `TS1,TS2,TS3`
L1 <- floor(log2(length(TS1$TS1)))
L2 <- floor(log2(length(TS2$TS2)))
L3 <- floor(log2(length(TS2$TS2)))

TS1_FDpsd <- fd_psd(TS1$TS1[1:2^L1])$low25$FD
TS2_FDpsd <- fd_psd(TS2$TS2[1:2^L2])$low25$FD
TS3_FDpsd <- fd_psd(TS3$TS3[1:2^L3])$low25$FD

# Logistic map - make it the length of L1
y1<-growth_ac(r = 2.9,type="logistic",N = 2^L1)
# Turn standardisation and detrending off!
TSlogMapr29 <- fd_psd(y1, standardise = FALSE, detrend = FALSE)$low25$FD
y2<-growth_ac(r = 4,type="logistic", N = 2^L1)
TSlogMapr4 <- fd_psd(y2, standardise = FALSE, detrend = FALSE)$low25$FD

TS1R_FDpsd <- fd_psd(TS1Random[1:2^L1])$low25$FD
TS2R_FDpsd <- fd_psd(TS1Random[1:2^L2])$low25$FD
TS3R_FDpsd <- fd_psd(TS1Random[1:2^L3])$low25$FD
```


* To create the surrogates using `fractal::surrogate()`
    + You'll need to repeatedly call the function and store the result
    + To get into a dataframe we have to use `unclass()` otherwise `R` doesn't recognise the object
    + Function `t()` trnasposes the data from 39 rows to 39 columns
* Once you have the surrogates in a datafram, repeatedly calculate the measure you want to compare, in this case `fd_sda()`.


```r
# NOW CREATE SURROGATES
library(dplyr)

# For a two-sided test at alpha = .05 we need N=39
Nsurrogates <- 39

TS1surrogates <- t(ldply(1:Nsurrogates, function(s) unclass(surrogate(x=TS1$TS1[1:2^L1] ,method="aaft"))))
colnames(TS1surrogates) <- paste0("aaftSurr",1:NCOL(TS1surrogates))

TS1surrogates_FD <- laply(1:Nsurrogates,function(s) fd_psd(y=TS1surrogates[,s])$low25$FD)


TS2surrogates <- t(ldply(1:Nsurrogates, function(s) unclass(surrogate(x=TS2$TS2[1:2^L2] ,method="aaft"))))
colnames(TS2surrogates) <- paste0("aaftSurr",1:NCOL(TS2surrogates))

TS2surrogates_FD <- laply(1:Nsurrogates,function(s) fd_psd(y=TS2surrogates[,s])$low25$FD)


TS3surrogates <- t(ldply(1:Nsurrogates, function(s) unclass(surrogate(x=TS3$TS3[1:2^L3] ,method="aaft"))))
colnames(TS3surrogates) <- paste0("aaftSurr",1:NCOL(TS3surrogates))

TS3surrogates_FD <- laply(1:Nsurrogates,function(s) fd_psd(y=TS3surrogates[,s])$low25$FD)


TSr29surrogates <- t(ldply(1:Nsurrogates, function(s) unclass(surrogate(x=y1, method="aaft"))))
colnames(TSr29surrogates) <- paste0("aaftSurr",1:NCOL(TSr29surrogates))

TSr29surrogates_FD <- laply(1:Nsurrogates,function(s) fd_psd(y=TSr29surrogates[,s])$low25$FD)


TSr4surrogates <- t(ldply(1:Nsurrogates, function(s) unclass(surrogate(x=y2, method="aaft"))))
colnames(TSr4surrogates) <- paste0("aaftSurr",1:NCOL(TSr4surrogates))

TSr4surrogates_FD <- laply(1:Nsurrogates,function(s) fd_psd(y=TSr4surrogates[,s])$low25$FD)
```


* Call function `plotSUR_hist()` to get the results of the test.


```r
plotSUR_hist(surrogateValues = TS1surrogates_FD, observedValue = TS1_FDpsd, sides = "two.sided", doPlot = TRUE, measureName = "psd FD TS1")
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-25-1.png)<!-- -->

```r
plotSUR_hist(surrogateValues = TS2surrogates_FD, observedValue = TS2_FDpsd,sides = "two.sided", doPlot = TRUE, measureName = "psd FD TS2")
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-25-2.png)<!-- -->

```r
plotSUR_hist(surrogateValues = TS3surrogates_FD, observedValue = TS3_FDpsd,sides = "two.sided", doPlot = TRUE, measureName = "psd FD TS3")
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-25-3.png)<!-- -->

```r
plotSUR_hist(surrogateValues = TSr29surrogates_FD, observedValue = TSlogMapr29,sides = "two.sided", doPlot = TRUE, measureName = "psd FD logMap r=2.9")
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-25-4.png)<!-- -->

```r
plotSUR_hist(surrogateValues = TSr4surrogates_FD, observedValue = TSlogMapr4, sides = "two.sided", doPlot = TRUE, measureName = "psd FD logMap r=4")
```

![](ASSIGNMENTS_P2_files/figure-html/unnamed-chunk-25-5.png)<!-- -->


 * Let's print the results into a table
 


```r
x$FDpsd <- c(TS1_FDpsd,TS2_FDpsd,TS3_FDpsd,TSlogMapr29,TSlogMapr4)
x$FDpsdRandom <- c(TS1R_FDpsd, TS2R_FDpsd, TS3R_FDpsd,NA,NA)
x$FDpsdAAFT.median <- c(median(TS1surrogates_FD),median(TS2surrogates_FD),median(TS3surrogates_FD),median(TSr29surrogates_FD),median(TSr4surrogates_FD))
knitr::kable(x, digits = 2, booktabs=TRUE,formt="html")
```



Source         FDsda   FDsdaRandom   FDsdaAAFT.median   FDpsd   FDpsdRandom   FDpsdAAFT.median
------------  ------  ------------  -----------------  ------  ------------  -----------------
TS1             1.14          1.53               1.19    1.17          1.52               1.19
TS2             1.04          1.53               1.05    1.12          1.52               1.13
TS3             1.61          1.53               1.58    1.66          1.52               1.59
TSlogMapr29     1.30            NA               1.38    1.13            NA               1.28
TSlogMapr4      1.59            NA               1.56    1.60            NA               1.57


