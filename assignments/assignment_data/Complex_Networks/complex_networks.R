# SETUP ---------------------------------------------------------------------------------------------------------------------------
#
# This script will source the latest 'Dynamics of Complex Systems Toolbox' (DCSTB.R)
# It is stored in a GitHub repository and can be accessed using the RCurlpackage
# as is implemented in the function source_https() found on Tony Breyal's blog:
# http://tonybreyal.wordpress.com/2011/11/24/source_https-sourcing-an-r-script-from-github/

source_https <- function(url, ...) {
  # load the package
  require(RCurl)

  # parse and evaluate each .R script
  sapply(c(url, ...), function(u) {
    eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
  })
}

# Source the DCSTB.R toolbox!
source_https("https://raw2.github.com/FredHasselman/toolboxR/master/DCSTB.R")

# This installs packages that are needed in case they are not present on your system [function defined in DCSTB.R]
init(c("igraph"))


# 1. Basic graphs ---------------------------------------------------------
# Create a small graph and plot it
g <- graph.ring(20)
plot(g)
# Get the degree of each node
degree(g)
# Get the average path length
average.path.length(g)

# Create a "Small world" graph
g <- watts.strogatz.game(1, 20, 5, 0.05)
# Get the degree of each node
degree(g)
# Get the average path length
average.path.length(g)
# Get the transitivity
transitivity(g)


# Directed "scale free" graph
set.seed(456)
g <- barabasi.game(20)
plot(g)
# Get the degree of each node
degree(g)
# Get the average path length
average.path.length(g)
# Get the transitivity
transitivity(g)
# Power law?
plot(log(1:20),log(degree(g)))

#
# # Add some more nodes and a nice layout with function plotBA() [function defined in DCSTB.R]
# gBA <- plotBA(n=100,pwr=1,out.dist=NULL)
# plot(gBA)
# plot(log(1:100),log(degree(gBA,mode="in")))
# # Perform a power law fit
# str(power.law.fit(degree(gBA,mode="in")+1,10))
# # Alpha = 3.43 (this should be similar to the Alpha of the cocktail model)


# 2. Social Networks ---------------------------------------------------------

# Social network of friendships between 34 members of a karate club at a US university in the 1970s.
# See W. W. Zachary, An information flow model for conflict and fission in small groups, Journal of Anthropological Research 33, 452-473 (1977).

# Community membership
karate <- graph.famous("Zachary")
wc <- walktrap.community(karate)
plot(wc, karate)
modularity(wc)
membership(wc)

# What does this matrix look like?
get.adjacency(karate)
# 34 people in the karate class, a 1 if they know each other
# You can do this for any 0-1 matrix!


# 3. Small World Index and Degree Distribution ----------------------------

# Select and run all the code below
# This will compute the Small World Index and compute the Power Law slope for:
# Small world networks and Scale-free networks
# Compare the measures!

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

