#############
# Objective #
#############
In this work we seek to identify prevalent time lapses between lab test measurements from a patient 
population in an automated fashion. Finding time gaps between lab tests in large patient populations 
can inform us about how well clinical guidelines are followed and clue us in to the context under 
which such tests were ordered. 
 
##########
# Method #
##########

To identify significant spikes in the lab-measurment gaps anomaly detection analysis is implemented 
using the R package BreakoutDetection [1]. The method combines a time-series decomposition [2] and 
the generalized Extreme Studentized Deviate (ESD) test [3]. The hybrid method was proposed by Vallis 
et al. [4] for long term anomaly detection in the Cloud and named Seasonal Hybrid ESD (S-H-ESD). 
The method removes any seasonal and trend detected in the data before implementing the ESD 
estimating, since anomalies are more difficult to detect with such forces at play. While the data is 
not truly a time series with time seasonality and a time trend, it exhibits similar characteristics 
that make the method appropriate. The seasonality in our data is seen in that the gap frequency 
oscillate between fixed time intervals since patients are more likely to return for testing in 
intervals of weeks. Furthermore, most tests exhibit a downward trend as the time-gap lengths 
increase.  

The data is segmented into periods specified by the package long term period option and the anomaly
analysis is performed on one segment of data at a time. The maximum number of anomalies allowed for 
each long-term period is specified  in a percentage format. The method also allows to specify a 
short-term period, which influences the period used for the time series
decomposition.


######################
# Inputs and outputs #
######################

Sample inputs are available in files lab1.txt, lab2.txt, and lab3.txt. Each file contains two 
columns. The first column is the number of days lapsed between the specific lab measurement for a 
patient. The second column contains the number of patients that exhibit this time lapse in the data. 
The program outputs a file with each row containing the measurment gaps per lab found by the program. 
The program creates such a file for each long term and short term specifications. The specifications are the following: 
    short-term period  	    long-term period
1.	30 days									180 days
2.	30 days									90 days
3.	365 days								none

##############
# References #
##############
[1] A. Kejariwal. Introducing practical and robust anomaly detection in a time series.
https://blog.twitter.com/2015/introducing-practical-and-robust-anomaly-detection-in-a-time-series,
Accessed: 12-05-2015.

[2] R.B. Cleveland, W.S. Cleveland, J.E. Mcrae, I. Terpenning. Stl: A seasonal-trend decomposition 
procedure based on loess. Journal of Ocial Statistics, 6(1):3{73, 1990.

[3] B. Rosner. Percentage points for a generalized esd many-outlier procedure. Technometrics, 25
(2):165-172, 1983.

[4] O. Vallis, J. Hochenbaum, A. Kejariwal. A novel technique for long-term anomaly detection in the
cloud. In Proceedings of the 6th USENIX Conference on Hot Topics in Cloud Computing, HotCloud'14,
pages 15{15. USENIX Association, 2014.

