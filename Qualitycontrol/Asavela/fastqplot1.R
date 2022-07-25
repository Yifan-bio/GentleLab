####FastQC#### plot1###

###call ggplot##
library(ggplot2)
library(dplyr)

####separate data according to  fastqc tests##
fastq_treated<-filter(fastq_tot, treatment=="treated")
fastq_untreated<-filter(fastq_tot, treatment=="untreated")
fastq_dup<-filter(fastq_tot, tests=="%Duplicates")
fastq_length<-filter(fastq_tot, tests=="Read length (bp)")
fastq_readno<-filter(fastq_tot, tests=="No. of reads (M)")

##plot duplicates##
fastq_plot1<-ggplot(data=fastq_dup,
                    aes(x=treatment,y=scores))+###Treatment might be time point for others
  geom_boxplot(aes(fill=treatment))+
  geom_point(aes(shape= replicate))+
  facet_wrap(cell_type~.,dir="v")+ #separate according to cell lines#
  labs(x= "Treatment", y= "%Duplication") #label the axes
fastq_plot1 

##plot read length#
fastq_plot2<-ggplot(data=fastq_length,
                   aes(x=treatment,y=scores))+ ##scores are the values for each sample 
  geom_boxplot(aes(fill=treatment))+
  geom_point(aes(shape= replicate))+
  facet_wrap(cell_type~.,dir="v")+
  labs(x= "Treatment", y= "Read length (bp)")
fastq_plot2

#plot total no. of reads#
fastq_plot3<-ggplot(data=fastq_readno,
                   aes(x=treatment,y=scores))+
  geom_boxplot(aes(fill=treatment))+
  geom_point(aes(shape= replicate))+
  facet_wrap(cell_type~.,dir="v")+
  labs(x="Treatment", y="No.reads (M)")
  
fastq_plot3

#display all the plots in one frame#
library(ggpubr)
fastqc_summary<-ggarrange(fastq_plot1, fastq_plot2, fastq_plot3,
          labels = c("A", "B", "C"),
          common.legend = TRUE,legend= "bottom")##to have one legend for all the grouped plots

fastqc_summary
ggsave("/media/studentsgh129/Elements1/fastq_plot1A/fastqc_summary.png",
       width=5, height=4,dpi=300) ## save plot



