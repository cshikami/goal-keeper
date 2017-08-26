//
//  CurrentGoalViewController.swift
//  ShikamiC_FinalProject
//
//  Created by Christopher Shikami on 3/7/17.
//  Copyright © 2017 Chris. All rights reserved.
//

import UIKit

let defaults = UserDefaults.standard
var checkedBoxTotal = 0

class CurrentGoalViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    var currentGoal: Goal?
    
    var uncheckedBox = UIImage(named: "checkbox")
    var checkedBox = UIImage(named: "checkedbox")
    
    var isboxclicked: Bool!
    var isbox2clicked: Bool!
    var isbox3clicked: Bool!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var goalCompletedLabel: UILabel!
    
    @IBOutlet weak var deadlineLabel: UILabel!
    
    @IBOutlet weak var uncheckBox: UIButton!
    @IBOutlet weak var uncheckBox2: UIButton!
    @IBOutlet weak var uncheckBox3: UIButton!
    
    private var checkMarkItems = [CheckmarkItem]()
    
    ///when box 1 button is clicked, make box image either checked or unchecked, and save state
    @IBAction func clickBox(_ sender: UIButton) {
        
        
        print("clickbox: \(defaults)")
        
        ///if box is checked, make it unchecked
        if isboxclicked == true {
            
            isboxclicked = false
            //save state with key checkboxstatus
            defaults.set(isboxclicked, forKey:"checkboxstatus")
            
            //set image to unchecked box
            uncheckBox.setImage(uncheckedBox, for: UIControlState.normal)
            
            //decrease checkbox total by 1
            checkedBoxTotal = checkedBoxTotal - 1
            
            //save checkbox total amount in user defaults
            defaults.set(checkedBoxTotal, forKey: "checkboxtotal")
            
            //if checkboxtotal is == 3, show complete label (should not happen)
            showCompleteLabel()
            
            //set progress bar equal to fraction of current checkbox total to 3
            progressView.progress = Float(checkedBoxTotal)/Float(3)

            //save progress amount in userdefaults for key progressviewprogress
            defaults.set(progressView.progress, forKey:"progressviewprogress")

            
            print("check - 1")
            print("\(isboxclicked)")
            print("\(checkedBoxTotal)")
            

        } else {
            
            ///if box button image is unchecked, change it to the checked button box
            isboxclicked = true
            
            //save state in userdefaults
            defaults.set(isboxclicked, forKey: "checkboxstatus")
            
            //set unchecked box image to checked box image
            uncheckBox.setImage(checkedBox, for:UIControlState.normal)
            
            //increment checkedBoxTotal by 1
            checkedBoxTotal = checkedBoxTotal + 1
            
            //save checkedBoxTotal in userdefaults with key checkboxtotal
            defaults.set(checkedBoxTotal, forKey: "checkboxtotal")
            
            //set progress bar equal to fraction of current checkbox total to 3
            progressView.progress = Float(checkedBoxTotal)/Float(3)
            
            //if checkboxtotal is == 3, show complete label
            showCompleteLabel()
            
            //save progress bar progress in userdefaults
            defaults.set(progressView.progress, forKey:"progressviewprogress")
            
            print("check + 1")
            print("\(isboxclicked)")
            print("\(checkedBoxTotal)")
            
            }
    }
    
    ///same logic as for box1, except for box2
    @IBAction func clickBox2(_ sender: UIButton) {
        if isbox2clicked == true {
            
            isbox2clicked = false

            sender.setImage(#imageLiteral(resourceName: "checkbox"), for: UIControlState.normal)
            defaults.set(isbox2clicked, forKey: "checkboxstatus2")
            checkedBoxTotal = checkedBoxTotal - 1
            
            defaults.set(checkedBoxTotal, forKey: "checkboxtotal")
            
            progressView.progress = Float(checkedBoxTotal)/Float(3)
            showCompleteLabel()
            
            defaults.set(progressView.progress, forKey:"progressviewprogress")
            
            print("check - 1")
            print("\(isbox2clicked)")
            print("\(checkedBoxTotal)")
            
        } else {
            
            isbox2clicked = true
            defaults.set(isbox2clicked, forKey: "checkboxstatus2")
            
            sender.setImage(#imageLiteral(resourceName: "checkedbox"), for:UIControlState.normal)
            checkedBoxTotal = checkedBoxTotal + 1
            
            defaults.set(checkedBoxTotal, forKey: "checkboxtotal")
            
            progressView.progress = Float(checkedBoxTotal)/Float(3)
            showCompleteLabel()
            
            defaults.set(progressView.progress, forKey:"progressviewprogress")
            
            print("check + 1")
            print("\(isbox2clicked)")
            print("\(checkedBoxTotal)")
            
        }

        
    }
    
    ///same logic as for box2, except for box3
    @IBAction func clickBox3(_ sender: UIButton) {
        if isbox3clicked == true {
            
            isbox3clicked = false
            
            
            sender.setImage(#imageLiteral(resourceName: "checkbox"), for: UIControlState.normal)
            defaults.set(isbox3clicked, forKey: "checkboxstatus3")
            checkedBoxTotal = checkedBoxTotal - 1
            
            defaults.set(checkedBoxTotal, forKey: "checkboxtotal")
            
            progressView.progress = Float(checkedBoxTotal)/Float(3)
            showCompleteLabel()
            
            defaults.set(progressView.progress, forKey:"progressviewprogress")
            
            print("check - 1")
            print("\(isbox3clicked)")
            print("\(checkedBoxTotal)")
            
        } else {
            
            isbox3clicked = true
            sender.setImage(#imageLiteral(resourceName: "checkedbox"), for:UIControlState.normal)
            
            defaults.set(isbox3clicked, forKey: "checkboxstatus3")
            checkedBoxTotal = checkedBoxTotal + 1
            
            defaults.set(checkedBoxTotal, forKey: "checkboxtotal")
            
            progressView.progress = Float(checkedBoxTotal)/Float(3)
            showCompleteLabel()
            
            defaults.set(progressView.progress, forKey:"progressviewprogress")
            
            print("check + 1")
            print("\(isbox3clicked)")
            print("\(checkedBoxTotal)")
            
        }
    }
    
    ///if all three checkboxes are checked, unhide the goal completed text
    /**
     append graph point integer 1 to graphPoints (this is used simply to test the graph interface, will build this out further in the future
 */
    func showCompleteLabel() {
        if checkedBoxTotal == 3 {
            goalCompletedLabel.isHidden = false
                graphPoints.append(1)
            print(graphPoints)
            
        }
        else {
            //if not all three checkboxes are checked, keep goal complete text hidden
            goalCompletedLabel.isHidden = true
        }
    }
    
    
    @IBOutlet weak var currentGoalNameLabel: UILabel!

    @IBOutlet weak var goalPoint1Label: UILabel!
    
    @IBOutlet weak var goalPoint2Label: UILabel!
    
    @IBOutlet weak var goalPoint3Label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Current Goal"
        
        isboxclicked = false
        isbox2clicked = false
        isbox3clicked = false
        
        ///background gradient
        let topColor = UIColor(red: (15/255.0), green: (118/255.0), blue: (128/255.0), alpha: 1)
        let bottomColor = UIColor(red: (84/255.0), green: (187/255.0), blue: (187/255.0), alpha: 0.5)
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = colorView.bounds
        colorView.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        showCompleteLabel()
        
        
        isboxclicked = defaults.bool(forKey: "checkboxstatus")
        
        ///using userdefaults, if isboxclicked state set as true, change unchecked image to checked
        if isboxclicked == true {
            
            uncheckBox.setImage(checkedBox, for: .normal)
        }
        
        isbox2clicked = defaults.bool(forKey: "checkboxstatus2")
        
        if isbox2clicked == true {
            uncheckBox2.setImage(checkedBox, for: .normal)
        }
        
        isbox3clicked = defaults.bool(forKey: "checkboxstatus3")
        
        if isbox3clicked == true {
            uncheckBox3.setImage(checkedBox, for: .normal)
        }
        
        //checkbox total upon view appearing
        
        checkedBoxTotal = defaults.integer(forKey: "checkboxtotal")
        
        print("checkedboxtotal: \(checkedBoxTotal)")
        
        progressView.progress = defaults.float(forKey: "progressviewprogress")
        
        
        print(isboxclicked)
        print(isbox2clicked)
        
        
        //textfields set to corresponding strings from Goal object
        if let g = currentGoal {
            
            currentGoalNameLabel.text = g.name
            goalPoint1Label.text = g.goalPoint1
            goalPoint2Label.text = g.goalPoint2
            goalPoint3Label.text = g.goalPoint3
            deadlineLabel.text = g.deadline
            
        }
        
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
