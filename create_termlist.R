library(plyr)
library(tidyverse)



df1 <- openxlsx::read.xlsx("/Users/Fred/Library/Mobile Documents/com~apple~CloudDocs/GitHub/Cursusboek IWO/1718/docs/CEREGO_HFST1_5.xlsx")
#
# df2 <- openxlsx::read.xlsx("/Users/Fred/Library/Mobile Documents/com~apple~CloudDocs/GitHub/Cursusboek IWO/1718/docs/CEREGO_HFST6_8.xlsx")
#
#
# df3 <- openxlsx::read.xlsx("/Users/Fred/Library/Mobile Documents/com~apple~CloudDocs/GitHub/Cursusboek IWO/1718/docs/CEREGO_HFST9_12.xlsx")


dftot <- rbind(df1[,1:2],df2,df3)

dftot <- arrange(dftot, Begrip.NL)

set.seed(321)
cnt=0
dftot$lab <- laply(dftot$Begrip.NL, function(b){
  cnt<<-cnt+1
  bp <- paste0(strsplit(x = b,split = "(\\s)",perl = TRUE)[[1]][1])
  return(paste0(substr(bp, 1, min(4, nchar(bp))),cnt))
  })

unique(dftot$lab)

#"\n(ref:",dftot$lab[b],")    \n",
dftot$rmd <- ldply(seq_along(dftot$Begrip.NL), function(b) paste0("### **",dftot$Begrip.NL[b],"** {- #",dftot$lab[b],"}\n\n+ ",dftot$Uitleg.NL[b],"\n"))

rio::export(print(dftot$rmd),"/Users/Fred/Library/Mobile Documents/com~apple~CloudDocs/GitHub/Cursusboek IWO/1718/docs/appendix_tot.csv")




# -----

df3 <- openxlsx::read.xlsx("/Users/Fred/Library/Mobile Documents/com~apple~CloudDocs/GitHub/Cursusboek IWO/1718/docs/CEREGO_HFST9_12.xlsx")

dftot <- arrange(df3, Begrip.NL)

set.seed(321)
cnt=0
dftot$lab <- laply(dftot$Begrip.NL, function(b){
  cnt<<-cnt+1
  bp <- paste0(strsplit(x = b,split = "(\\s)",perl = TRUE)[[1]][1])
  return(paste0(substr(bp, 1, min(4, nchar(bp))),cnt))
})

unique(dftot$lab)

#"\n(ref:",dftot$lab[b],")    \n",
dftot$rmd <- ldply(seq_along(dftot$Begrip.NL), function(b) paste0("### **",dftot$Begrip.NL[b],"** {- #",dftot$lab[b],"}\n\n+ ",dftot$Uitleg.NL[b],"\n"))


dftot2 <- read.csv2("/Users/Fred/Library/Mobile Documents/com~apple~CloudDocs/GitHub/Cursusboek IWO/1718/docs/appendix.csv", header = F)


rio::export(print(dftot$rmd),"/Users/Fred/Library/Mobile Documents/com~apple~CloudDocs/GitHub/Cursusboek IWO/1718/docs/appendix2.csv")
