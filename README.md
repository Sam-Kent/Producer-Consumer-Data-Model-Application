# Producer-Consumer-Data-Model-Application
A mobile app (using Solar2D and Lua )that simulates and displays the behavior of a simple producer-consumer model. 
The app has three main components.
First, the input of the parameters to the system (described below).

Second, the calculation of the number of producers and consumers in the market over time.

Finally, the correctly scaled display of the number of producers and consumers in the
market over time, on-screen with the calculated parameters.


# Equations
The equations used to calculate the numbers of future producers and consumers are:
p(t + 1) = p(t) + br p(t) − dr p(t) c(t) 
c(t + 1) = c(t) + bf dr · p(t) c(t) − df c(t) 

where: 
p(t) is the number of producers at the start of a time period t. 

c(t) is the number of consumers at the start of a time period t. br is the rate of entry into the market of new producers.

dr is the rate of removal from the market per encounter of producers due to a consumer consuming the good/service.

df is the rate of exit from the market of consumers due to the absence of the good/service (represented by producers). 

bf is the efficiency of turning the good/service (producers) into consumers.
