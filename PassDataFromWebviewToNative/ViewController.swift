//
//  ViewController.swift
//  PassDataFromWebviewToNative
//
//  Created by 中村麟太郎 on 2018/06/27.
//  Copyright © 2018年 中村麟太郎. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate,
  WKScriptMessageHandler, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  var webView: WKWebView!

  override func viewDidLoad() {
    super.viewDidLoad()

    // javaScriptを呼び出し可能にするWKUserContentControllerクラスの生成
    let userController = WKUserContentController()
    userController.add(self, name: "callbackHandler")
    userController.add(self, name: "showAlbum")

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
  func userContentController(_ userContentController: WKUserContentController,
                             didReceive message: WKScriptMessage) {

    let actionName = message.name

    switch actionName {
    case "callbackHandler":
      print(message.body)

    case "showAlbum":
      print(message.body)
      showAlbum()

    default:
      print("該当するアクションが存在しません.")
    }
  }

  func showAlbum() {
    let sourceTypePhotoLibrary: UIImagePickerControllerSourceType
      = UIImagePickerControllerSourceType.photoLibrary

    guard UIImagePickerController.isSourceTypeAvailable(sourceTypePhotoLibrary) else {
      print("カメラロールが利用できません.")
      return
    }

    let cameraPicker = UIImagePickerController()
    cameraPicker.sourceType = sourceTypePhotoLibrary
    cameraPicker.delegate = self
    self.present(cameraPicker, animated: true, completion: nil)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
