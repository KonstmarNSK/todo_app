import play.api.http.{ContentTypeOf, ContentTypes, Writeable}
import play.api.mvc.{Codec, RequestHeader}
import scalatags.Text.all._

package object views {

  object implicits {

    // map scalatags' tags into Writable to make it possible to return the pages in controllers
    object scalatags {
      implicit def contentTypeOfTag(implicit codec: Codec): ContentTypeOf[Tag] = {
        ContentTypeOf[Tag](Some(ContentTypes.HTML))
      }

      implicit def writeableOfTag(implicit codec: Codec): Writeable[Tag] = {
        Writeable(tag => codec.encode("<!DOCTYPE html>\n" + tag.render))
      }
    }
  }

  // views
  object pages{

    def createTicketView(implicit req : RequestHeader) : scalatags.Text.TypedTag[String] = CreateTicket.createTicketPage
    def homepageView(s: String) : scalatags.Text.TypedTag[String] = Home.homepage(s)
    def getAllTicketsView = ???

  }

  object forms {
      import com.kostya.taskboard.shared.Model.Ticket
      import internal.formParamNames._
      import play.api.data.Forms._
      import play.api.data._

      val createTicketForm = Form(
        mapping(
          createTicket.ticketTitle -> nonEmptyText,
          createTicket.ticketDescription -> nonEmptyText,
        )
        // id isn't in form parameters
        (Ticket.apply(_, _, 0L))
        (Ticket.unapply(_).map({ case (title, desc, id) => (title, desc) }))
      )
    }

  // things that are specific for classes in this package
  private[views] object internal {

    object paths {

      object scripts {
        val main = "/assets/client-fastopt.js"
      }

      object styles {

        object bootstrap {
          val min = "/assets/stylesheets/bootstrap/bootstrap.min.css"

          val grid = "/assets/stylesheets/bootstrap/bootstrap-grid.css"
          val gridMin = "/assets/stylesheets/bootstrap/bootstrap-grid.min.css"
        }

      }

      object api{
        val createTicket = "/api-rest/create-ticket"
      }
    }

    object tagsFunctions {

      def styles(path: String) = link(
        rel := "stylesheet",
        href := path,
      )

      def csrfFormElement(requestHeader: RequestHeader) =
        input(
          `type` := "hidden",
          name := "csrfToken",
          // fixme: not good
          value := requestHeader.session.get("csrfToken").getOrElse("NoToken")
        )
    }

    object formParamNames{
      object createTicket{
        val ticketTitle = "ticketTitle"
        val ticketDescription = "ticketDescription"
      }
    }
  }
}
