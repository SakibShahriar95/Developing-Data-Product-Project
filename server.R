#libraries
library(shiny)
library(HistData)
library(dplyr)
library(ggplot2)

data(GaltonFamilies)

#inch to cm
Galt <- GaltonFamilies %>% mutate(father=father*2.54,mother=mother*2.54,childHeight=childHeight*2.54)

#Linear model based on factors of father and mothers height and gender
lmModel <- lm(childHeight ~ father + mother + gender, data=Galt)

shinyServer(function(input, output) {
    output$text <- renderText({
        paste("Father's Height:",
              strong(input$heightF),
              "cm, and Mothers Height:",strong(input$heightM),"cm, Child:")
    })
    output$predict <- renderText({
        Outcome <- data.frame(father=input$heightF,mother=input$heightM,
                         gender=factor(input$GenVal, levels=levels(Galt$gender)))
        chRes <- predict(lmModel, newdata=Outcome)
        kid <- ifelse(  input$GenVal=="male","Son","Daughter")
        paste0(em(strong(kid))," predicted height is going to be around ", em(strong(round(chRes)))," cm"
        )
    })
    output$plot <- renderPlot({
        kid <- ifelse(
            input$GenVal=="male","Son", "Daughter"
        )
        Outcome <- data.frame(father=input$heightF,mother=input$heightM,
                         gender=factor(input$GenVal, levels=levels(Galt$gender)))
        chRes <- predict(lmModel, newdata=Outcome)
        fact <- c("Father", kid, "Mother")
        Outcome <- data.frame(
            x = factor(fact, levels = fact, ordered = TRUE), y = c(input$heightF, chRes, input$heightM))
        ggplot(Outcome, aes(x=x, y=y,fill = c("green","blue","green"))) +
            geom_bar(stat="identity", width=0.5) +xlab("Individual") + ylab("Height cm")+
            theme(legend.position="none")
    })
})