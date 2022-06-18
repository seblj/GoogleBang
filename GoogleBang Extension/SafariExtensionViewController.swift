//
//  SafariExtensionViewController.swift
//  GoogleBang Extension
//
//  Created by Sebastian Lyng Johansen on 18/06/2022.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:240)
        return shared
    }()

}
