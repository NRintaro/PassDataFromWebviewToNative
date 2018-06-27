//
//  CameraViewController.swift
//  PassDataFromWebviewToNative
//
//  Created by 中村麟太郎 on 2018/06/27.
//  Copyright © 2018年 中村麟太郎. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController,
  UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var cameraView: UIImageView!
  @IBOutlet weak var label: UILabel!


  override func viewDidLoad() {
    super.viewDidLoad()

    label.text = "Tap the [start] to take a picture"
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // カメラを起動する
  @IBAction func startUpCamera(_ sender: Any) {

    let sourceTypeCamera: UIImagePickerControllerSourceType
      = UIImagePickerControllerSourceType.camera

    // カメラが利用可能なら起動する
    if UIImagePickerController.isSourceTypeAvailable(sourceTypeCamera) {

      let cameraPicker = UIImagePickerController()
      cameraPicker.sourceType = sourceTypeCamera
      cameraPicker.delegate = self
      self.present(cameraPicker, animated: true, completion: nil)
    } else {

      label.text = "Can't use camera"
    }
  }

  // カメラロールを起動する
  @IBAction func showAlbum(_ sender: Any) {

    let sourceTypePhotoLibrary: UIImagePickerControllerSourceType
      = UIImagePickerControllerSourceType.photoLibrary

    // カメラロールが利用可能なら起動する
    if UIImagePickerController.isSourceTypeAvailable(sourceTypePhotoLibrary) {

      let cameraPicker = UIImagePickerController()
      cameraPicker.sourceType = sourceTypePhotoLibrary
      cameraPicker.delegate = self
      self.present(cameraPicker, animated: true, completion: nil)
    } else {

      label.text = "Can't use Album"
    }
  }

  // 写真が選択された時に呼ばれる
  func imagePickerController(_ imagePicker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [String: Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {

      cameraView.contentMode = .scaleAspectFit
      cameraView.image = pickedImage
    }
    imagePicker.dismiss(animated: true, completion: nil)
    label.text = "Choosed a picture"
  }

  // 撮影または、アルバムがキャンセルされた時に呼ばれる
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
    label.text = "Canceled"
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */

}
