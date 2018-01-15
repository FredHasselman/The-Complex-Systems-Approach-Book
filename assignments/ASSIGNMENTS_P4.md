---
title: "Complex Networks"
author: "Fred Hasselman & Maarten Wijnants"
date: "1/14/2018"
output: 
  html_document: 
    fig_caption: yes
    highlight: pygments
    keep_md: yes
    number_sections: no
    theme: spacelab
    toc: yes
    toc_float: true
    collapsed: false
    smooth_scroll: true
    code_folding: show

---

# **Complex Networks** {#nets}

To complete these assignments you need:

```r
library(igraph)
library(qgraph)
library(devtools)
source_url("https://raw.githubusercontent.com/FredHasselman/DCS/master/functionLib/nlRtsa_SOURCE.R")
```

## Basic graphs

1. Create a small ring graph in `igraph` and plot it.


```r
g <- graph.ring(20)
```

    - Look in the manual of `igraph` for a function that will get you the degree of each node.
    - ALso, get the average path length.


2. Create a "Small world" graph and plot it.
     - Get the degree, average path length and transitivity



```r
g <- watts.strogatz.game(1, 20, 5, 0.05)
```


3. Directed scale-free  graph
     - Get the degree, average path length and transitivity


```r
g <- barabasi.game(20)
```

     - There should be a power law relation between nodes and degree ... (but this is a very small network)

```r
plot(log(1:20),log(degree(g)))
```

## Social Networks 

The package igraph contains data on a Social network of friendships between 34 members of a karate club at a US university in the 1970s.

> See W. W. Zachary, An information flow model for conflict and fission in small groups, *Journal of Anthropological Research 33*, 452-473 (1977).


1. Get a graph of the cpmmunities within the social network. 
    - Check the manual, or any online source to figure out what these measures mean and how they are calulated.


```r
# Community membership
karate <- graph.famous("Zachary")
wc <- walktrap.community(karate)
plot(wc, karate)
modularity(wc)
membership(wc)
```


2. It is also possible to get the adjacency matrix


```r
get.adjacency(karate)
```

     - What do the columns, rows and 0s and 1s stand for?


## Small World Index and Degree Distribution 

Select and run all the code below
This will compute the *Small World Index* and compute the Power Law slope of Small world networks and Scale-free networks

1. Compare the measures!

2. Try to figure out how these graphs are constructed by looking at the functions in `nlRtsa_SOURCE.R`


```r
# Initialize
set.seed(660)
layout1=layout.kamada.kawai
k=3
n=50

# Setup plots
par(mfrow=c(2,3))
# Strogatz rewiring probability = .00001
p   <- 0.00001
p1  <- plotSW(n=n,k=k,p=p)
PLF1<- PLFsmall(p1)
p11 <- plot(p1,main="p = 0.00001",layout=layout1,xlab=paste("FON = ",round(mean(neighborhood.size(p1,order=1)),digits=1),"\nSWI = ", round(SWtestE(p1,N=100)$valuesAV$SWI,digits=2),"\nPLF = NA",sep=""))

# Strogatz rewiring probability = .01
p   <- 0.01
p2  <- plotSW(n=n,k=k,p=p)
PLF2<- PLFsmall(p2)
p22 <- plot(p2,main="p = 0.01",layout=layout1,xlab=paste("FON = ",round(mean(neighborhood.size(p2,order=1)),digits=1),"\nSWI = ", round(SWtestE(p2,N=100)$valuesAV$SWI,digits=2),"\nPLF = ",round(PLF2,digits=2),sep=""))
# Strogatz rewiring probability = 1
p   <- 1
p3  <- plotSW(n=n,k=k,p=p)
PLF3<- PLFsmall(p3)
p33 <- plot(p3,main="p = 1",layout=layout1,xlab=paste("FON = ",round(mean(neighborhood.size(p3,order=1)),digits=1),"\nSWI = ", round(SWtestE(p3,N=100)$valuesAV$SWI,digits=2),"\nPLF = ",round(PLF3,digits=2),sep=""))

set.seed(200)
# Barabasi power = 0
p4  <- plotBA(n=n,pwr=0,out.dist=hist(degree(p1,mode="all"),breaks=(0:n),plot=F)$density)
PLF4<- PLFsmall(p4)
p44 <- plot(p4,main="power = 0",layout=layout1,xlab=paste("FON = ",round(mean(neighborhood.size(p4,order=1)),digits=1),"\nSWI = ", round(SWtestE(p4,N=100)$valuesAV$SWI,digits=2),"\nPLF = ",round(PLF4,digits=2),sep=""))

# Barabasi power = 2
p5  <- plotBA(n=n,pwr=2,out.dist=hist(degree(p2,mode="all"),breaks=(0:n),plot=F)$density)
PLF5<- PLFsmall(p5)
p55 <- plot(p5,main="power = 2",layout=layout1,xlab=paste("FON = ",round(mean(neighborhood.size(p5,order=1)),digits=1),"\nSWI = ", round(SWtestE(p5,N=100)$valuesAV$SWI,digits=2),"\nPLF = ",round(PLF5,digits=2),sep=""))

# Barabasi power = 4
p6  <- plotBA(n=n,pwr=4,out.dist=hist(degree(p3,mode="all"),breaks=(0:n),plot=F)$density)
PLF6<- PLFsmall(p6)
p66 <- plot(p6,main="power = 4",layout=layout1,xlab=paste("FON = ",round(mean(neighborhood.size(p6,order=1)),digits=1),"\nSWI = ", round(SWtestE(p6,N=100)$valuesAV$SWI,digits=2),"\nPLF = ",round(PLF6,digits=2),sep=""))
par(mfrow=c(1,1))
```


[| Jump to solutions |](#netssol)


## Package `qgraph`

Learn about the functionality of the `qgraph` frm its author Sacha Epskamp.

Try running the examples, e.g. of the `Big 5`: 

[http://sachaepskamp.com/qgraph/examples](http://sachaepskamp.com/qgraph/examples)


## `qgraph` tutorials / blog

Great site by Eiko Fried:
[http://psych-networks.com ](http://psych-networks.com )


## EXTRA - early warnings

Have a look at the site [Early Warning Systems](http://www.early-warning-signals.org/home/)

There is an accompanying [`R` package `earlywarnings`](https://cran.r-project.org/web/packages/earlywarnings/index.html)
