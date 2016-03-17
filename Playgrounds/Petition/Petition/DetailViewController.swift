//
//  DetailViewController.swift
//  Petition
//
//  Created by Matt Dickey on 3/15/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var detailItem: String?
    
    
    func loadWebPage(urlString: String){
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        spinner.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        spinner.stopAnimating()
        
    }
    
    
    func configureView() {
        // Update the user interface for the detail item.
        
        if let url = detailItem{
            loadWebPage(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        
        webView.delegate = self
        spinner.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

