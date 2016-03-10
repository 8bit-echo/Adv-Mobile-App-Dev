//
//  WebView_ViewController.swift
//  Midterm
//
//  Created by Matt Dickey on 3/10/16.
//  Copyright © 2016 Matt Dickey. All rights reserved.
//

import UIKit

class WebView_ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    var loadedStoreName = ""
    var url = ""
    
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

    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = loadedStoreName
        
        switch loadedStoreName{
            case "Home Depot":
                url = "http://www.homedepot.com"
            case "King Soopers":
                url = "https://www.homedepot.com"
        default:
            break
        }
        
        loadWebPage(url)
        
        

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
