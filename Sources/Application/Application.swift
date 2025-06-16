import Foundation
import Shared
import WebUI

@main
struct Application: Website {
    var metadata: Metadata {
        Metadata(from: PersonalData.metadata)
    }

    @WebsiteRouteBuilder
    var routes: [any Document] {
        get throws {
            // Fetch articles
            let articles = try ArticleService.fetchAllArticles()

            // Static routes and Home with articles
            Home(articles: articles)
            Missing()
            Notes()
            Projects()

            // Dynamic article routes
            for article in articles {
                article as any Document
            }
        }
    }

    var baseURL: String? {
        "https://tunji.io"
    }

    static func main() async throws {
        do {
            let application = Application()
            try application.build()

            // Fetch and Update Cloud Functions
            //await CloudFunctions.fetchAndUpdate()
            print("✓ Application built very successfully.")
        } catch {
            print("⨉ Failed to build application: \(error)")
        }
    }
}
