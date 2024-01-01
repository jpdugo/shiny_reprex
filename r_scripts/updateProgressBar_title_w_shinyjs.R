# Showcases the use of the shinyjs package to dynamically update the progress bar and display
# fontawesome icons in the title.
box::use(
  shiny[...],
  shinyWidgets[
    progressSweetAlert, closeSweetAlert, useSweetAlert, updateProgressBar
  ],
  shinyjs[useShinyjs, html],
  htmltools[doRenderTags]
)
ui <- fluidPage(
  useSweetAlert(),
  useShinyjs(),
  actionButton("btn", "Click me")
)

server <- function(input, output, session) {
  observeEvent(input$btn, {
    progressSweetAlert(
      id      = "progress",
      title   = tagList("Progress", icon("spinner", class = "fa-spin")),
      value   = 0,
      striped = TRUE
    )

    Sys.sleep(1)

    updateProgressBar(
      id    = "progress",
      value = 50,
      title = "Progress 2 "
    )

    shinyjs::html(
      id     = "progress-title",
      html   = doRenderTags(icon("check")),
      asis   = TRUE,
      add    = TRUE
    )

    Sys.sleep(2)
    closeSweetAlert(session)
  })
}

shinyApp(ui, server)
