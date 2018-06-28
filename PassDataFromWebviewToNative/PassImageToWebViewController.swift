import UIKit
import WebKit

class PassImageToWebViewController: UIViewController, WKNavigationDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate{

  var webView: WKWebView!
  @IBOutlet weak var cameraStatusLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    cameraStatusLabel.text = "[Shwo Album]を押して画像を選択する"

    let cgRect: CGRect = CGRect(
      x: 0,
      y: 0,
      width: self.view.frame.size.width,
      height: self.view.frame.size.height / 1.5
    )

    webView = WKWebView(frame: cgRect, configuration: WKWebViewConfiguration())
    webView.navigationDelegate = self
    webView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(webView)

    let request = URLRequest(url: URL(string: "http://localhost:8080/#/image")!)
    self.webView.load(request)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func showAlbum(_ sender: Any) {
    let sourceTypePhotoLibrary: UIImagePickerControllerSourceType
      = UIImagePickerControllerSourceType.photoLibrary

    if UIImagePickerController.isSourceTypeAvailable(sourceTypePhotoLibrary) {
      let cameraPicker = UIImagePickerController()
      cameraPicker.sourceType = sourceTypePhotoLibrary
      cameraPicker.delegate = self
      self.present(cameraPicker, animated: true, completion: nil)
    } else {
      cameraStatusLabel.text = "Can't use Album"
    }
  }

  func imagePickerController(_ imagePicker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String: Any]) {

    guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
      imagePicker.dismiss(animated: true, completion: nil)
      cameraStatusLabel.text = "Can't set pickecImage"
      return
    }

    guard let pngData = UIImagePNGRepresentation(pickedImage) else {
      imagePicker.dismiss(animated: true, completion: nil)
      cameraStatusLabel.text = "PickedImage Can't convert to Data"
      return
    }

    let base64DataUrl = pngData.base64EncodedString()
    // optionを指定すると描画されない
    // let base64DataUrl = pngData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)

    webView.evaluateJavaScript(
      "document.getElementById('img').src = 'data:image/png;base64,\(base64DataUrl)'",
      completionHandler: nil
    )

    imagePicker.dismiss(animated: true, completion: nil)
    cameraStatusLabel.text = "Choosed a picture"
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
    cameraStatusLabel.text = "Canceled"
  }
}
