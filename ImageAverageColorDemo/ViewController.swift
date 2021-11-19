//
//  ViewController.swift
//  ImageAverageColorDemo
//
//  Created by XaoflySho on 2021/11/19.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction
    func selectImage(_ sender: Any) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        let imagePicker = PHPickerViewController(configuration: config)
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                        if let color = image.averageColor {
                            self.view.backgroundColor = color
                            self.label.textColor = color.isBright ? .darkText : .lightText
                            self.label.text = color.isBright ? "Bright color" : "Dark color"
                        }
                    }
                }
            }
        }
    }
    
    
}


