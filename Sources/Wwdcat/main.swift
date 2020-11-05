import Foundation
import Publish
import Plot
import SplashPublishPlugin

// This type acts as the configuration for your website.
struct Wwdcat: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }
    
    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }
    
    // Update these properties to configure your website:
    var url = URL(string: "https://wwdcat.com")!
    var name = "wwdcat"
    var description = "WorldWide Developer Cat"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

extension Theme where Site == Wwdcat {
    static var WWDCatTheme: Self {
        .wwdcatTheme()
    }
}

// This will generate your website using the built-in Foundation theme:
try Wwdcat().publish(
    using: [
        .installPlugin(.splash(withClassPrefix: "")),
        .copyResources(),
        .addMarkdownFiles(),
        .generateHTML(withTheme: .WWDCatTheme, indentation: .spaces(2)),
        .generateRSSFeed(including: [.posts]),
        .generateSiteMap(),
        .deploy(using: .gitHub("seviu2/seviu2.github.io", useSSH: true))
    ]
)
