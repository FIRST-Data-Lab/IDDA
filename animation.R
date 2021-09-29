rm(list = ls())

library(devtools)
install_github('covid19-dashboard-us/slid')
library(slid)
library(ggplot2)
library(plotly)
library(gapminder)

data(state.long)
names(state.long)

state.long$DATE = as.Date(substring(state.long$DATE, 2), "%Y.%m.%d") 
state.long.DEC = state.long[state.long$DATE > as.Date("2020-11-30"), ]

state.long.DEC$log.Infected = log10(state.long.DEC$Infected)
state.long.DEC$log.Death = log10(state.long.DEC$Death)

gg <- ggplot(state.long.DEC, aes(log.Infected, log.Death, color = State)) +
  geom_point(aes(size = pop, frame = as.numeric(DATE), ids = State)) +
  scale_x_log10() 
ggplotly(gg)


base <- state.long.DEC %>%
  plot_ly(x = ~log.Infected, y = ~log.Death, size = ~pop, 
          text = ~State, hoverinfo = "text") %>%
  layout(xaxis = list(type = "log"))

base %>%
  add_markers(color = ~State, frame = ~DATE, ids = ~State) %>%
  animation_opts(1000, easing = "elastic", redraw = FALSE) %>%
  animation_button(
    x = 1, xanchor = "right", y = 0, yanchor = "bottom"
  ) %>%
  animation_slider(
    currentvalue = list(type = "date", font = list(color="red"))
  )

library(gapminder)
library(ggplot2)
library(plotly)

data(gapminder, package = "gapminder")

gapminder[1,]


# Libraries
library(ggplot2)
library(dplyr)

library(plotly)
df <- data.frame(
  Date = seq(as.Date("2017-01-01"), as.Date("2017-01-05"), by = 1),
  Hour = rep(1:24, 5),
  Value = rnorm(24 * 5)
)
p1 <- ggplot(aes(Hour, Value, frame = Date), data = df) +
  geom_line() # not working
ggplotly(p1)
p2 <- ggplot(aes(Hour, Value, frame = as.numeric(Date)), data = df) +
  geom_line() # working
ggplotly(p2)


gg <- ggplot(state.long.DEC, aes(Infected, Death, color = State)) +
  geom_point(aes(size = pop, frame = as.numeric(DATE), ids = State)) +
  scale_x_log10() 
ggplotly(gg)

gg <- ggplot(gapminder, aes(gdpPercap, lifeExp, color = Region)) +
  geom_point(aes(size = pop, frame = year, ids = State)) +
  scale_x_log10()
ggplotly(gg)

as.numeric(state.long$DATE)



base %>%
  add_markers(color = ~State, frame = ~DATE, ids = ~State) %>%
  animation_opts(1000, easing = "elastic", redraw = FALSE) %>%
  animation_button(
    x = 1, xanchor = "right", y = 0, yanchor = "bottom"
  ) %>%
  animation_slider(
    currentvalue = list(type = "date", font = list(color="red"))
  )

base <- state.long.DEC %>%
  plot_ly(x = ~DATE, y = ~Infected, frame = ~Region,
          text = ~State, hoverinfo = "text") %>%
  add_lines(linetype = ~State, colors = ~State)

base %>% 
  layout(xaxis = list(type = "date", range=c('2020-12-01', '2020-12-11'))) %>% 
  animation_opts(1000, easing = "elastic", redraw = FALSE, transition = 0)



