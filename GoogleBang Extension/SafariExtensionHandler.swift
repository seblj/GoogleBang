//
//  SafariExtensionHandler.swift
//  GoogleBang Extension
//
//  Created by Sebastian Lyng Johansen on 18/06/2022.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    // Credit goes to https://gist.github.com/patrickshox/7c74d23dd453176775f59d65f97a078a
    
    // Add these functions to your SafariExtensionHandler subclass:
    // Given a Google, Yahoo, or Bing URL, this function will return the url encoding
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

    // Before every page navigaion, this code checks if it's navigating to a search engine site. If so, it parses the url in order to instead navigate to that same seach term on DuckDuckGo.
    override func page(_ page: SFSafariPage, willNavigateTo url: URL?) {
        let hostnames = ["www.google.com", "www.bing.com", "search.yahoo.com"]
        let url = url!
        if hostnames.contains(url.host!) {
            if let query = self.getQueryStringParameter(url: url.absoluteString) {
                let redirectedURL = URL(string: "https://duckduckgo.com/?q=\(query)&ia=web")!
                page.getContainingTab { (tab) in
                    tab.navigate(to: redirectedURL)
                }
            }
        }
    }
}
