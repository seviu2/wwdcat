import Publish
import Plot

extension Theme {
    static func wwdcatTheme() -> Self {
        Theme(
            htmlFactory: WWDCatHTMLFactory(),
            resourcePaths: [
                "Theme/styles.css",
                "Theme/fonts/SourceSansPro-Bold.ttf",
                "Theme/fonts/SourceSansPro-Regular.ttf",
                "Theme/fonts/SourceCodePro-Regular.ttf",
            ]
        )
    }
}

private struct WWDCatHTMLFactory<Site: Website>: HTMLFactory {
    func makeIndexHTML(for index: Index, context: PublishingContext<Site>) throws -> HTML {
        let header = Node.header(for: context, selectedSection: nil)
        let footer = Node.footer(for: context.site)
        let bodyContent = Node.div(
            .class("wrapper content clearfix"),
            .div(
                .class("section-header float-container"),
                .a(
                    .href("/posts"),
                    .h1("🙀 A Cats Life")
                )
            ),
            .itemList(
                for: Array(context.allItems(sortedBy: \.date, order: .descending).filter { $0.sectionID.rawValue == "posts" }.prefix(3)),
                on: context.site
            ),
            .if(context.allItems(sortedBy: \.date, order: .descending).filter { $0.sectionID.rawValue == "posts" }.count > 1,
                .a(
                    .class("browse-all"),
                    .href("/posts"),
                    .text("Browse all \(context.allItems(sortedBy: \.date, order: .descending).filter { $0.sectionID.rawValue == "posts" }.count) posts")
                )
            )
        )
        let aboutMe = Node.div(
            .div(
                .class("wrapper contentFooter clearfix"),
                .id("aboutMeAnchor"),
                .img(.class("avatar"), .src("/tx_sticker.png")),
                .div(
                    .class("introduction"),
                    .contentBody(index.body)
                )
            )
        )
        return HTML(
            .lang(context.site.language),
            .head(for: index, on: context.site),
            .body(header, bodyContent, aboutMe, footer)
        )
    }
    
    func makeSectionHTML(for section: Section<Site>,
                         context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: section, on: context.site),
            .body(
                .header(for: context, selectedSection: section.id),
                .wrapper(
                    .h1(.text(section.title)),
                    .if(section.id.rawValue == "posts",
                        .div(
                            .class("introduction"),
                            .text("Kitty so himalayan puma. Havana brown cougar so kitten so bombay siamese or havana brown or birman.")
                        )
                    ),
                    .itemList(for: section.items.filter { $0.sectionID == section.id }, on: context.site)
                ),
                .footer(for: context.site)
            )
        )
    }
    
    func makeItemHTML(for item: Item<Site>,
                      context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: item, on: context.site),
            .body(
                .class("item-page"),
                .header(for: context, selectedSection: item.sectionID),
                .wrapper(
                    .article(
                        .div(
                            .class("content"),
                            .contentBody(item.body)
                        ),
                        .br(),
                        .br(),
                        .p(.text("Published on \(item.date)")),
                        .span("Tagged with: "),
                        .tagList(for: item, on: context.site)
                    )
                ),
                .footer(for: context.site)
            )
        )
    }
    func makePageHTML(for page: Page, context: PublishingContext<Site>) throws -> HTML {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site))
    }
    
    func makeTagListHTML(for page: TagListPage, context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site))
    }
    
    func makeTagDetailsHTML(for page: TagDetailsPage, context: PublishingContext<Site>) throws -> HTML? {
        HTML(
            .lang(context.site.language),
            .head(for: page, on: context.site))
    }
    
}
