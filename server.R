library(shiny)

# Define server logic required to draw the plots
shinyServer(function(input, output) {
  
  output$plots<-renderPlot({
    #get alpha and lambda values from input
    alphaVal<-input$alpha
    lambdaVal<-input$lambda
    meanVal<-alphaVal/lambdaVal
    varVal<-alphaVal/lambdaVal^2
    maxVal<-alphaVal/lambdaVal+3*sqrt(alphaVal/lambdaVal^2)
    
    #Plotting sequence
    x    <- seq(from=0,to=maxVal,by=0.001)
    
    if (is.na(alphaVal)){alphaVal<-1}
    if (is.na(lambdaVal)){lambdaVal<-1}
    gamMax<-max(dgamma(x,shape=alphaVal,rate=lambdaVal))
    
    if(alphaVal>=1){
      #draw the plot of 1/X and the taylor expansions
      plot(x,y=1/x, ylab="Y=1/X",ylim=c(0,10*gamMax),main="Plot of Y=1/X and Taylor Approximations",type="l",lwd="3")
    }else{
      plot(x,y=1/x, ylab="Y=1/X",ylim=c(0,(1/meanVal)*2),main="Plot of Y=1/X and Taylor Approximations",type="l",lwd="3")
    }
    lines(x,y=(1/meanVal)-(1/(meanVal)^2)*(x-meanVal),type="l",lwd="3",col="Blue")
    lines(x,y=(1/meanVal)-(1/(meanVal)^2)*(x-meanVal)+2*(1/meanVal^3)*(x-meanVal)^2/2,type="l",lwd="3",col="Orange")
    legend(col=c("Black","Blue","Orange","Purple"),"topright",legend=c("True Curve","1st order","2nd order","Gamma Density"),pch=15)
    
    #overlay gamma density
    lines(x,y=10*dgamma(x,shape=alphaVal,rate=lambdaVal),type="l",col="Purple",lwd=3)
    
  })
  
  output$vals<-renderTable({
    #get alpha and lambda values from input
    alphaVal<-input$alpha
    lambdaVal<-input$lambda
    
    if(alphaVal>1){
      truth<-lambdaVal/(alphaVal-1)
    } else{
      truth<-Inf
    }
    first<-lambdaVal/alphaVal
    second<-lambdaVal*(alphaVal+1)/(alphaVal^2)
    data.frame(Method=c("Truth","1st Order Delta","2nd Order Delta"),
               Mean=c(truth,first,second),
               PerDiff=c(NA,(truth-first)/truth*100,(truth-second)/truth*100))
  }, include.rownames=FALSE)
  
})