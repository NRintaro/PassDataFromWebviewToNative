//
//  ViewController.swift
//  PassDataFromWebviewToNative
//
//  Created by 中村麟太郎 on 2018/06/27.
//  Copyright © 2018年 中村麟太郎. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {

  var webView: WKWebView!

  override func viewDidLoad() {
    super.viewDidLoad()

    // javaScriptを呼び出し可能にするWKUserContentControllerクラスの生成
    let userController = WKUserContentController()
    userController.add(self, name: "callbackHandler")

    // WKWebViewの設定を行う為のWKWebViewConfigurationクラスの生成
    let webConfiguration = WKWebViewConfiguration()
    webConfiguration.userContentController = userController

    // WKWebViewの生成
    webView = WKWebView(frame: CGRect(x: 0,
                                      y: 0,
                                  width: self.view.frame.size.width,
                                 height: self.view.frame.size.height),
                configuration: webConfiguration)

    webView.navigationDelegate = self
    webView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(webView)

    // 表示するアドレスを設定
    let request = URLRequest(url: URL(string: "http://localhost:8080")!)
    self.webView.load(request)
  }

  // WKScriptMessageHandlerプロトコル
  func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    if (message.name == "callbackHandler") {
      print(message.body)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
