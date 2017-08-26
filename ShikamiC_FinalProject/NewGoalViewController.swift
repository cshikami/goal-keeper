//
//  NewGoalViewController.swift
//  ShikamiC_FinalProject
//
//  Created by Christopher Shikami on 3/4/17.
//  Copyright © 2017 Chris. All rights reserved.
//

import UIKit

class NewGoalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var colorView: UIView!

    
    @IBOutlet weak var newGoalNameTextField: UITextField!
    
    @IBOutlet weak var newGoalPoint1: UITextField!
    
    @IBOutlet weak var newGoalPoint2: UITextField!
    
    @IBOutlet weak var newGoalPoint3: UITextField!

    @IBOutlet weak var setDeadlineTextField: UITextField!
    
    @IBOutlet var textFields: [UITextField]!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    ///Appends the user input from the text fields to goals, which is the Goal object
    
    /**
     Appends text from the textfields to Goal
     Sets the fields back to empty
     If the name and goal point 1 have less than 1 character, an alert message will pop up
 */
    @IBAction func addGoalButton(_ sender: UIButton) {
        if(newGoalNameTextField.text!.characters.count >= 1 && newGoalPoint1.text!.characters.count >= 1 &&
            newGoalPoint2.text!.characters.count >= 1 &&
            newGoalPoint3.text!.characters.count >= 1) {
            goals.append(Goal(name: newGoalNameTextField.text!,
                              goalPoint1: newGoalPoint1.text!, goalPoint2: newGoalPoint2.text!, goalPoint3: newGoalPoint3.text!,deadline: setDeadlineTextField.text!))
            let title = "Alert"
            let message = "\(newGoalNameTextField.text!) Goal Added"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            
    
            newGoalNameTextField.text = ""
            newGoalPoint1.text = ""
            newGoalPoint2.text = ""
            newGoalPoint3.text = ""
            setDeadlineTextField.text = ""
            photoImageView.image = #imageLiteral(resourceName: "defaultImage")
            
            print("\(goals)")
            print("\(goals.count)")
        }
        else {
            let title = "Alert"
            let message = "Must have at least 1 letter for the goal name and goals"
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    
    }
    ///click on the background to exit the keyboard
    @IBAction func backgroundTouched(_ sender: UIControl) {
        for tf in textFields {
            tf.resignFirstResponder()
        }
    }
    
    
    let datePicker = UIDatePicker()
    ///create date picker that pops up when user clicks on deadline text field
    func createDatePicker(){
        
        //format for picker
        datePicker.datePickerMode = .dateAndTime
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //bar button done item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        setDeadlineTextField.inputAccessoryView = toolbar
        
        ///Assign date picker to deadline text field
        setDeadlineTextField.inputView = datePicker
    }
    
    ///format date in the allow to resign first responder upon clicking done bar button
    func donePressed() {
        
        //format date in the short style
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        setDeadlineTextField.text = dateFormatter.string(from: datePicker.date)

        self.view.endEditing(true)
    }
    
    ///set up photo library image controller
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        for tf in textFields {
        tf.resignFirstResponder()
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        //Set the photoImageView to display the selected image.
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    
    func configureGradientBackground(colors:CGColor...){
        
        let gradient: CAGradientLayer = CAGradientLayer()
        
        
        gradient.colors = colors
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New Goal"
    
        createDatePicker()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.navigationItem.title = "New Goal"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
