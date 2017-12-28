//
//  OpenOfficeViewController.swift
//  BaseApp
//
//  Created by nguyen.duy.phong on 1/3/18.
//  Copyright © 2018 Phong Nguyen. All rights reserved.
//

import UIKit
import WebKit

class OpenOfficeViewController: UIViewController, WKNavigationDelegate {
    
    let stringUrl = "https://www.tutorialspoint.com/design_pattern/design_pattern_tutorial.pdf"
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ///loadFromUrl()
        ///loadFromLocal()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    }
    
    
    fileprivate func loadFromUrl() {
        if let url = URL(string: stringUrl) {
            let urlRequest = URLRequest(url: url)
            self.webView.allowsLinkPreview = true
            self.webView.load(urlRequest)
        }
    }

    fileprivate func loadFromLocal() {
        let pdfPath = URL(fileURLWithPath: Bundle.main.path(forResource: "demo", ofType: "xlsx")!)
        let urlRequest = URLRequest(url: pdfPath)
        webView.load(urlRequest)
    }
}
