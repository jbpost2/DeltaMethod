###########################################################################
##R Shiny App to investigate the Delta method
##Justin Post - 2017
###########################################################################

#Load package
library(shiny)
library(shinydashboard)

# Define UI for application that draws the prior and posterior distributions given a value of y
dashboardPage(skin="red",
  dashboardHeader(title="Comparison of First and Second Order Delta Method",titleWidth=750),
  
  #define sidebar items
  dashboardSidebar(sidebarMenu(
    menuItem("About", tabName = "about", icon = icon("archive")),
    menuItem("Application", tabName = "app", icon = icon("laptop"))
  )),
  
  #define the body of the app
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "about",
        fluidRow(
          #add in latex functionality if needed
          withMathJax(),
                
          #two columns for each of the two items
          column(6,
            #Description of App
            h1("What does this app do?"),
            #box to contain description
            box(background="red",width=12,
              h4("This applet allows for the visualization of the first and second order delta method approximations of a function."),
              h4("For this applet the Random Variable, X, is assumed to follow a Gamma distribution.  The function to be approximated is Y=1/X."),
              h4("The exact distribution of this function can be derived to follow the Inverse Gamma distribution."),
              h4("The true mean of this distribution is compared to the first order and second order Delta method approximations and a measure of the error in approximation is given."),
              h4("The mean of the random variable X is given by $$E(X)=\\alpha/\\lambda$$ and the variance is given by $$Var(X)=\\alpha/\\lambda^2$$"),
              h4("The exact mean of \\(Y=1/X\\) is given by $$E(Y)=\\lambda/(\\alpha-1) \\mbox{  for }\\alpha>1 \\mbox{  (undefined otherwise)}$$"),
              h4("The first order approximation is given by $$E(Y)\\approx g(\\mu_X)=1/\\mu_X = \\lambda/\\alpha$$"),
              h4("The second order approximation is given by $$E(Y)\\approx g(\\mu_X)+\\frac{1}{2}g''(\\mu_X)\\sigma^2_X = \\lambda(\\alpha+1)/\\alpha^2$$")
            )
          ),
        
          column(6,
            #How to use the app
            h1("How to use the app?"),
            #box to contain description
            box(background="red",width=12,
              h4("The controls for the app are located to the left, the visualization appears in the middle, and the approximation information is given on the right."), 
              h4("The parameters of the Gamma random variable can be adjusted using the boxes on the left."),
              h4("The graph in the middle displays this distribution, the function \\(y=\\frac{1}{x}\\), and the first and second order Taylor polynomials about the mean of the Gamma distribution."),
              h4("The box on the right displays the true mean of the distribution of \\(Y=1/X\\) and the approximations.")
            )
          )
        )
      ),
      
      #actual app layout      
      tabItem(tabName = "app",        
        fluidRow(
          column(3,
            box(width=12,title="Parameters of the Gamma distribution",
              background="red",solidHeader=TRUE,
              h5("(Set to 1 if blank.)"),
              numericInput("alpha",label=h5("Alpha Value (> 0, 'Shape')"),value=1,min=0,step=0.25),
              numericInput("lambda",label=h5("Lambda Value (> 0, 'Rate')"),value=1,min=0,step=0.25)
            )
          ),
          column(width=6,
            fluidRow(
              box(width=12,
                plotOutput("plots"),
                br(),
                h4("The plot above displays the function 1/X, the first and second order Taylor approximations to 1/X and overlays the assumed distribution of X (not to scale).")
              )
            )
          ),
          column(width=3,
            fluidRow(
              box(width=12,
                tableOutput("vals"),
                br(),
                h4("The first column provides the Method of approximation (or truth)."),
                h4("The second column provides the approximation to the mean."),
                h4("The third column provides the percent difference (Estimate-Truth)/Truth*100%.")
              )
            )
          )
        )
      )
    )
  )
)

