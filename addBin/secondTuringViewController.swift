//
//  secondTuringViewController.swift
//  addBin
//
//  Created by Christopher Canales on 7/2/20.
//  Copyright © 2020 Christopher Canales. All rights reserved.
//

import UIKit
import Canvas

class secondTuringViewController: UIViewController {
    @IBOutlet weak var startStateA: CSAnimationView!
    @IBOutlet weak var stateOneA: CSAnimationView!
    @IBOutlet weak var stateTwoA: CSAnimationView!
    @IBOutlet weak var stateThreeA: CSAnimationView!
    @IBOutlet weak var stateFourA: CSAnimationView!
    @IBOutlet weak var stateFiveA: CSAnimationView!
    @IBOutlet weak var stateSixA: CSAnimationView!
    @IBOutlet weak var stateSevenA: CSAnimationView!
    @IBOutlet weak var acceptStateA: CSAnimationView!
    @IBOutlet weak var rejectStateA: CSAnimationView!
    
    @IBOutlet weak var startState: UIButton!
    @IBOutlet weak var stateOne: UIButton!
    @IBOutlet weak var stateTwo: UIButton!
    @IBOutlet weak var stateThree: UIButton!
    @IBOutlet weak var stateFour: UIButton!
    @IBOutlet weak var stateFive: UIButton!
    @IBOutlet weak var stateSix: UIButton!
    @IBOutlet weak var stateSeven: UIButton!
    @IBOutlet weak var acceptState: UIButton!
    @IBOutlet weak var rejectState: UIButton!
    
    @IBOutlet weak var insertButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var nextStateButton: UIButton!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputStatement: UILabel!
    @IBOutlet weak var theTape: UISegmentedControl!
    
    var theStates:[String:UIButton] = [String:UIButton]()
    var curState = "p"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.theStates = [
            "p":self.startState,
            "s":self.startState,
            "1":self.stateOne,
            "2":self.stateTwo,
            "3":self.stateThree,
            "4":self.stateFour,
            "5":self.stateFive,
            "6":self.stateSix,
            "7":self.stateSeven,
            "a":self.acceptState,
            "r":self.rejectState
        ]
        theTape.removeAllSegments()
        nextStateButton.setTitle("Start Turing Machine", for: .normal)
        nextStateButton.isHidden = true
        inputStatement.isHidden = true
        resetButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    @IBAction func insertInput(_ sender: UIButton) {
        if isBinary(theArg: inputTextField.text!) {
            nextStateButton.isHidden = false
            inputStatement.isHidden = false
            resetButton.isHidden = false
            setCircle()
            curState = "p"
            nextStateButton.setTitle("Start Turing Machine", for: .normal)
            /*-------------FILLING IN TAPE WITH INPUT-------------*/
            theTape.removeAllSegments()
            for i in inputTextField.text!  {
                theTape.insertSegment(withTitle: "\(i)" , at: (inputTextField.text?.count)!, animated: true)
            }
            theTape.insertSegment(withTitle: "U" , at: (inputTextField.text?.count)!+1, animated: true)
            /*-------------FILLING IN TAPE WITH INPUT-------------*/
            /*-------------LABEL TEXT-------------*/
                let theBin = inputTextField.text!
                inputStatement.text = "You entered \(theBin)"
            /*-------------LABEL TEXT-------------*/
        }
        else{
            notInLang()
        }
        
    }
    
    
    @IBAction func nextStateAction(_ sender: UIButton) {
        switch curState {
        case "p":
            theTape.selectedSegmentIndex = 0
            nextStateButton.setTitle("Next State", for: .normal)
            setCircleFill()
            curState = "s"
            startStateA.startCanvasAnimation()
        case "s":
            if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "a" {
                setTapeToU()
                moveRight()
                setCircle()
                curState = "1"
                setCircleFill()
                stateOneA.startCanvasAnimation()
            }
            else if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "b"{
                theTape.setTitle("$", forSegmentAt: theTape.selectedSegmentIndex)
                setTapeToU()
                moveRight()
                setCircle()
                curState = "2"
                setCircleFill()
                stateTwoA.startCanvasAnimation()
            }
            else{
                setCircle()
                curState = "a"
                setCircleFill()
                acceptStateA.startCanvasAnimation()
            }
        
        case "1":
            if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "a" || theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "b" {
                moveRight()
                setCircle()
                curState = "3"
                setCircleFill()
                stateThreeA.startCanvasAnimation()
            }
            else{
                setCircle()
                curState = "a"
                setCircleFill()
                acceptStateA.startCanvasAnimation()
            }
        case "2":
        if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "a" || theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "b" {
            moveRight()
            setCircle()
            curState = "4"
            setCircleFill()
            stateFourA.startCanvasAnimation()
        }
        else{
            setCircle()
            curState = "a"
            setCircleFill()
            acceptStateA.startCanvasAnimation()
        }
        case "3":
        if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "a" || theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "b" {
            moveRight()
            stateThreeA.startCanvasAnimation()
        }
        else{
            moveLeft()
            setCircle()
            curState = "5"
            setCircleFill()
            stateFiveA.startCanvasAnimation()
            }
        case "4":
        if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "a" || theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "b" {
            moveRight()
            stateFourA.startCanvasAnimation()
        }
            else{
            moveLeft()
            setCircle()
            curState = "6"
            setCircleFill()
            stateSixA.startCanvasAnimation()
            }
        case "5":
            if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "a" {
                setTapeToU()
                moveLeft()
                setCircle()
                curState = "7"
                setCircleFill()
                stateSevenA.startCanvasAnimation()
            }
            else{
                moveRight()
                setCircle()
                curState = "r"
                setCircleFill()
                rejectStateA.startCanvasAnimation()
            }
        case "6":
        if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "b" {
            setTapeToU()
            moveLeft()
            setCircle()
            curState = "7"
            setCircleFill()
            stateSevenA.startCanvasAnimation()
        }
        else{
            moveRight()
            setCircle()
            curState = "r"
            setCircleFill()
            rejectStateA.startCanvasAnimation()
        }
        case "7":
            if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "a" || theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "b" {
                moveLeft()
                stateSevenA.startCanvasAnimation()
            }
            else{
                moveRight()
                setCircle()
                curState = "s"
                setCircleFill()
                startStateA.startCanvasAnimation()
            }
        case "a":
        accepted()
        resetStates()
        case "r":
        rejected()
        resetStates()
        default:
        resetStates()
        }
    }
    @IBAction func resetStatesAction(_ sender: UIButton) {
        resetStates()
    }
    /*-------------Functions-------------**/
    func notInLang(){
        /*ACTUAL ALERT**/
        let alertController = UIAlertController(title: "Alert", message: "Your input isn't 'a' or 'b'", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
        /*ACTUAL ALERT**/
        resetStates()
    }
    func resetStates(){
        nextStateButton.isHidden = true
        resetButton.isHidden = true
        inputStatement.isHidden = true
        nextStateButton.setTitle("Start Turing Machine", for: .normal)
        theTape.removeAllSegments()
        setCircle()
        curState = "p"
        
        acceptStateA.startCanvasAnimation()
        startStateA.startCanvasAnimation()
        stateOneA.startCanvasAnimation()
        stateTwoA.startCanvasAnimation()
        stateThreeA.startCanvasAnimation()
        stateFourA.startCanvasAnimation()
        stateFiveA.startCanvasAnimation()
        stateSixA.startCanvasAnimation()
        stateSevenA.startCanvasAnimation()
    }
    func accepted(){
        /*ACTUAL ALERT**/
        let alertController = UIAlertController(title: "", message: "Your input is a Palindrome!", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
        /*ACTUAL ALERT**/
    }
    func rejected(){
        /*ACTUAL ALERT**/
        let alertController = UIAlertController(title: "", message: "Your input is NOT a Palindrome!", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
        /*ACTUAL ALERT**/
    }
    func isBinary(theArg: String) -> Bool{
            var isitBinary = true
            for abit in theArg{
                if abit == "a" || abit == "b" {
                    continue
                }
                else{
                    isitBinary = false
                    break
                }
            }
            
            return isitBinary
    }
    func moveRight(){ // Moves cursor Right
        theTape.selectedSegmentIndex = theTape.selectedSegmentIndex + 1
    }
    func moveLeft(){ // Moves cursor Left
        theTape.selectedSegmentIndex = theTape.selectedSegmentIndex - 1
    }
    func setCircle(){ // Sets current state inactive
        theStates[curState]?.setImage(UIImage(systemName: "circle"), for:.normal)
    }
    func setCircleFill(){ // Sets new current state to active
        theStates[curState]?.setImage(UIImage(systemName: "circle.fill"), for:.normal)
    }
    func setTapeToA(){
        theTape.setTitle("a", forSegmentAt: theTape.selectedSegmentIndex)
    }
    func setTapeToB(){
        theTape.setTitle("b", forSegmentAt: theTape.selectedSegmentIndex)
    }
    func setTapeToU(){
        theTape.setTitle("U", forSegmentAt: theTape.selectedSegmentIndex)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
