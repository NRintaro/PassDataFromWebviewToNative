import UIKit
import WebKit

class PassDataIosToWebViewController: UIViewController, WKNavigationDelegate {

  var webView: WKWebView!

  override func viewDidLoad() {
    super.viewDidLoad()

    // WKWebViewの設定を行う為WKWebViewConfigurationを生成
    let webConfiguration = WKWebViewConfiguration()

    // WebViewを表示する座標とサイズ(高さ/幅）の設定を行う為CGRectを生成
    let cgReact: CGRect = CGRect(
      x: 0,
      y: 0,
      width: self.view.frame.size.width,
      height: self.view.frame.size.height / 1.5
    )

    // WKWebViewの生成
    webView = WKWebView(frame: cgReact, configuration: webConfiguration)

    webView.navigationDelegate = self
    webView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(webView)

    // 表示するアドレスを設定
    let request = URLRequest(url: URL(string: "http://localhost:8080/#/greet")!)
    self.webView.load(request)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
