# Sankey

# Packages
library(dplyr)
library(readxl)
library(networkD3)
library(tidyverse)

# Data
Fourth_Iteration_Clean_Dataset_5_Lads_4_Humanity_with_extra_data_ <- read_excel("Fourth Iteration - Clean Dataset - 5 Lads 4 Humanity (with extra data).xlsx")
dat <- Fourth_Iteration_Clean_Dataset_5_Lads_4_Humanity_with_extra_data_

# Calculate the Values
# How many got accepted
a.fil <- filter(dat,dat$Approved==1)
a <- nrow(a.fil)
a
# How many got rejected
b.fil <- filter(dat, dat$Approved==0)
b <- nrow(b.fil)
b
# How many graduated
c.fil <- filter(a.fil, a.fil$Graduated==1)
c <- nrow(c.fil)
c
# How many did not graduate
d.fil <- filter(a.fil, a.fil$Graduated!=1)
d <- nrow(d.fil)
d
# How many continued to their master
e.fil <- filter(c.fil, c.fil$`Bachelor and Master Present`==1)
e <- nrow(e.fil)
e
# How many did not continue to master
f.fil <- filter(c.fil, c.fil$`Bachelor and Master Present`==0)
f <- nrow(f.fil)
f

# Create Main Data Shit (link and node)
# The Link
zelda <- data.frame(source=c("Applied", "Applied", "Admitted", "Admitted", "Graduated", "Graduated"), 
                    target=c("Admitted", "Rejected", "Graduated", "Drop Out/Incomplete Record", "Master", "Bye Bye"), 
                    value=c(a,b,c,d,e,f))
zelda

# The node 
nose <- data.frame(name=c("Applied","Admitted","Rejected","Graduated","Drop Out/Incomplete Record","Master", "Bye Bye"))
nose$group <- as.factor(c("a", "a", "b", "a", "b", "a", "b"))
nose


# volt that shit in
zelda$IDsource <- match(zelda$source, nose$name)-1
zelda$IDtarget <- match(zelda$target, nose$name)-1
zelda


# color 
my_color <- 'd3.scaleOrdinal() .domain(["a", "b"]) .range(["green", "red"])'

# do the magic, baby
monkey <- sankeyNetwork(Links= zelda,
              Nodes= nose,
              Source="IDsource",
              Target="IDtarget",
              Value="value",
              NodeID="name",
              sinksRight=FALSE,
              colourScale=my_color,
              NodeGroup="group")
monkey

### Old Value ###
# Data
Cleaned_Adm_Reg_of_Bach_Mas <- read_excel("Cleaned Adm + Reg of Bach + Mas.xlsx")
dat2 <- Cleaned_Adm_Reg_of_Bach_Mas


# Calculate the Values
# How many got accepted
a.fil2 <- filter(dat2,dat2$Approved==1)
a2 <- nrow(a.fil2)
a2
# How many got rejected
b.fil2 <- filter(dat2, dat2$Approved==0)
b2 <- nrow(b.fil2)
b2
# How many graduated
c.fil2 <- filter(a.fil2, a.fil2$Graduated==1)
c2 <- nrow(c.fil2)
c2
# How many did not graduate
d.fil2 <- filter(a.fil2, a.fil2$Graduated!=1)
d2 <- nrow(d.fil2)
d2
# How many continued to their master
e.fil2 <- filter(c.fil2, c.fil2$`Bachelor and Master Present`==1)
e2 <- nrow(e.fil2)
e2
# How many did not continue to master
f.fil2 <- filter(c.fil2, c.fil2$`Bachelor and Master Present`==0)
f2 <- nrow(f.fil2)
f2

# Create Main Data Shit (link and node)
# The Link
zelda2 <- data.frame(source=c("Applied", "Applied", "Admitted", "Admitted", "Graduated", "Graduated"), 
                    target=c("Admitted", "Rejected", "Graduated", "Drop Out/Incomplete Record", "Master", "Bye Bye"), 
                    value=c(a2,b2,c2,d2,e2,f2))
zelda2

# The node 
nose2 <- data.frame(name=c("Applied","Admitted","Rejected","Graduated","Drop Out/Incomplete Record","Master", "Bye Bye"))
nose2$group <- as.factor(c("a", "a", "b", "a", "b", "a", "b"))
nose2

# volt that shit in
zelda2$IDsource <- match(zelda2$source, nose2$name)-1
zelda2$IDtarget <- match(zelda2$target, nose2$name)-1
zelda2

# do the magic, baby
monkey2 <- sankeyNetwork(Links= zelda2,
                        Nodes= nose2,
                        Source="IDsource",
                        Target="IDtarget",
                        Value="value",
                        NodeID="name",
                        sinksRight=FALSE,
                        colourScale=my_color,
                        NodeGroup="group")
monkey2

png(filename="old_plot.png")
monkey2
dev.off()

