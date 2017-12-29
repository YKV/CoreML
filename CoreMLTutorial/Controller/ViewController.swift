//
//  ViewController.swift
//  CoreML
//
//  Created by Eugene on 2017-12-28.
//  Copyright © 2017 Eugene. All rights reserved.
//

import UIKit
import CoreML
import Vision
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var classificationLabel: UILabel!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodImages.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        let image = foodImages[indexPath.row]
        cell.configureCell(image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCell else {
            return
        }
        
        makePredictionFor(cell.imageView.image!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if picker.sourceType == .camera {
            imagePicker.dismiss(animated: true, completion: nil)
            let justTakenPic = info[UIImagePickerControllerOriginalImage] as? UIImage
            makePredictionFor(justTakenPic ?? UIImage())
        }
        
    }
    
    func makePredictionFor(_ image: UIImage) {
        guard let model = try? VNCoreMLModel(for: MobileNet().model) else {return}
        let request = VNCoreMLRequest(model: model, completionHandler: handleResults)
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        
        do {
            try handler.perform([request])
        }catch {
            debugPrint("Error: ", error)
        }
    }
    
    func handleResults(request: VNRequest, error: Error?)  {
        guard let results = request.results as? [VNClassificationObservation] else {
            return
        }
        let bestResult = results[0]
        let id = bestResult.identifier.capitalized
        let confidence = bestResult.confidence * 100
        classificationLabel.text = "\(id): \(String.init(format: "%.2f", confidence))%"

    }
    
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
}

