###########################################################################
##R Shiny App to plot different possible posterior distributions from coin example
##Justin Post - Fall 2016
###########################################################################

#Load package
library(shiny)
library(shinydashboard)

# Define UI for application that draws the prior and posterior distributions given a value of y
dashboardPage(skin="red",
    dashboardHeader(title="Comparison of First and Second Order Delta Method",titleWidth=1000),
    dashboardSidebar(disable = TRUE),
    dashboardBody(
        column(
            width=3,
            box(background="red",width=12,title="Description of Example",solidHeader=TRUE,
                h5("This applet allows for the visualization of the first and second order delta method."),
                h5("The Random Variable, X, is assumed to follow a Gamma distribution with shape and rate parameters adjustable by the sliders on the left."), 
                h5("The functions approximated is Y=1/X.  The true mean of Y is compared to that as found by the approximations")
            ),
            box(width=12,
                title="Parameters of the Gamma distribution",
                background="red",
                solidHeader=TRUE,
                h5("(Set to 1 if blank.)"),
                numericInput("alpha",label=h5("Alpha Value (> 0, 'Shape')"),value=1,min=0,step=0.25),
                numericInput("lambda",label=h5("Lambda Value (> 0, 'Rate')"),value=1,min=0,step=0.25)
            )
        ),
        column(width=6,
            fluidRow(
                box(
                    width=12,
                    plotOutput("plots"),
                    br(),
                    h4("The plot above displays the function 1/X, the first and second order Taylor approximations to 1/X and overlays the assumed distribution of X (not to scale).")
                )
            )
        ),
        column(width=3,
          fluidRow(
            box(
              width=12,
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

