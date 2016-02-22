//
//  DetailViewController.swift
//  DC Comics
//
//  Created by Matt Dickey on 2/22/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {
    
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!
    
    func webViewDidStartLoad(webView: UIWebView) {
        webSpinner.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webSpinner.stopAnimating()
    }
    
    func loadWebPage(urlString: String){
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView(){
        if let detail = self.detailItem{
            if let label = self.detailLabel{
                label.text = detail.description
                loadWebPage(detail.description)
            }
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webSpinner.stopAnimating()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
