
import UIKit

class WebView_Controller: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    func loadWebPage(urlString: String){
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL:url!)
        webView.loadRequest(request)
    }
    
    
    //    func webViewDidStartLoad(webView: UIWebView) {
    //        spinner.startAnimating()
    //    }
    //    func webViewDidFinishLoad(webView: UIWebView) {
    //        spinner.stopAnimating()
    //    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        loadWebPage("https://apple.com")
        
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
