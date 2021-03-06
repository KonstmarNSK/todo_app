package views

import com.kostya.taskboard.shared.Model.Project
import scalatags.Text.all._
import views.internal._
import views.internal.tagsFunctions._

private[views] object Home {
  def homepage(message: String, projects: Seq[Project]) = scalatags.Text.all.html(
    head(
      title := "Hello, Scala",
      styles(links.styles.bootstrap.min),
    ),
    body(
      h2("Play and Scala.js share a same message"),
      ul(
        li(
          "Play shouts out: ",
          em(message),
        ),
        li(
          "Scala.js shouts out: ",
          em(id := "scalajsShoutOut"),
        )
      ),
      script(src := links.scripts.main),

      for(
        project <- projects
      ) yield {
        div(
          a(href := links.projectBoard(project.id), project.projectName)
        )
      }
    )
  )
}