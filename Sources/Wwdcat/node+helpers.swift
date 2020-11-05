
import Publish
import Plot

extension Node where Context == HTML.BodyContext {
    static func tagList<T: Website>(for item: Item<T>, on site: T) -> Node {
        return .ul(.class("tag-list"), .forEach(item.tags) { tag in
            .li(.a(
                .href(site.path(for: tag)),
                .text(tag.string)
            ))
        })
    }
    
    static func itemList<T: Website>(for items: [Item<T>], on site: T) -> Node {
        return .ul(
            .class("item-list"),
            .forEach(items.sorted(by: {$0.date.compare($1.date) == .orderedDescending})) { item in
                .li(.article(
                    .a(.href(item.path),
                       .h1(.text(item.title)),
                       .p(.text(item.description)))
                )
                )
            }
        )
    }
    
    static func wrapper(_ nodes: Node...) -> Node {
        .div(.class("wrapper"), .group(nodes))
    }
    
    static func footer<T: Website>(for site: T) -> Node {
        return .footer(
            .p(
                .text("This website was made in Swift thanks to all the cats at"),
                .a(
                    .text("TX Conference"),
                    .href("https://conf.tx.group")
                )
            ),
            .p(
                .text("©2020 Meow")
            ),
            .p(
                .text("Subscribe via "),
                .a(.class("rss"), .text("RSS"), .href("/feed.rss"))
            )
        )
    }
    
    static func header<T: Website>(for context: PublishingContext<T>, selectedSection: T.SectionID?) -> Node {
        let sectionIDs = T.SectionID.allCases
        
        return .header(
            .div(
                .class("wrapper"),
                .a(.class("site-name"), .href("/"), .img(.class("logo"), .class("logo"))),
                
                .h4(.text(context.site.description)),
                .nav(
                    .ul(
                        .forEach(sectionIDs) { section in
                            .li(
                                .class(section == selectedSection ? "selected" : ""),
                                .a(
                                    .href(context.sections[section].path),
                                    .text(context.sections[section].title)
                                ))
                        }
                        
                    )
                )
            )
        )
    }
}
