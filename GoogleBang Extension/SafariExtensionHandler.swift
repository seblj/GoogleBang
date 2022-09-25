//
//  SafariExtensionHandler.swift
//  GoogleBang Extension
//
//  Created by Sebastian Lyng Johansen on 18/06/2022.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    // https://gist.github.com/patrickshox/7c74d23dd453176775f59d65f97a078a
    func getQueryStringParameter(url: String) -> String? {
        var param = "q"
        if url.contains("search.yahoo.com") {
            param = "p"
        }
        guard let url = URLComponents(string: url) else { return nil }
        let rawString = url.queryItems?.first(where: { $0.name == param })?.value
        let percentEncoding = rawString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.replacingOccurrences(of: "&", with: "%26")
        return percentEncoding
    }

    // Use duckduckgo if there is ! in the query parameters
    override func page(_ page: SFSafariPage, willNavigateTo url: URL?) {
        if url!.query!.contains("!") && !url!.host!.contains("duckduckgo.com") {
            if let query = self.getQueryStringParameter(url: url!.absoluteString) {
                let redirectedURL = URL(string: "https://duckduckgo.com/?q=\(query)&ia=web")!
                page.getContainingTab { (tab) in
                    tab.navigate(to: redirectedURL)
                }
            }
        }
    }
}
