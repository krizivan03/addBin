//
//  ViewController.swift
//  addBin
//
//  Created by Christopher Canales on 6/28/20.
//  Copyright © 2020 Christopher Canales. All rights reserved.
//

import UIKit
import Canvas
class ViewController: UIViewController {

    @IBOutlet weak var binTextField: UITextField! // Change to insertBinTF
    @IBOutlet weak var yourNumStatement: UILabel!
    @IBOutlet weak var theTape: UISegmentedControl!
    @IBOutlet weak var nextState: UIButton!
    @IBOutlet weak var resetStatesButton: UIButton!
    
    @IBOutlet weak var acceptState: UIButton!
    @IBOutlet weak var acceptStateA: CSAnimationView!
    @IBOutlet weak var startState: UIButton!
    @IBOutlet weak var startStateA: CSAnimationView!
    @IBOutlet weak var stateOne: UIButton!
    @IBOutlet weak var stateOneA: CSAnimationView!
    @IBOutlet weak var stateTwo: UIButton!
    @IBOutlet weak var stateTwoA: CSAnimationView!
    @IBOutlet weak var stateThree: UIButton!
    @IBOutlet weak var stateThreeA: CSAnimationView!
    @IBOutlet weak var stateFour: UIButton!
    @IBOutlet weak var stateFourA: CSAnimationView!
    @IBOutlet weak var stateFive: UIButton!
    @IBOutlet weak var stateFiveA: CSAnimationView!
    @IBOutlet weak var stateSix: UIButton!
    @IBOutlet weak var stateSixA: CSAnimationView!
    @IBOutlet weak var stateSeven: UIButton!
    @IBOutlet weak var stateSevenA: CSAnimationView!
    

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
            "a":self.acceptState
        ]
        theTape.removeAllSegments()
        nextState.setTitle("Start Turing Machine", for: .normal)
        nextState.isHidden = true
        yourNumStatement.isHidden = true
        resetStatesButton.isHidden = true
        
        
    }
    

    @IBAction func insertButton(_ sender: UIButton) {
            if isBinary(theArg: binTextField.text!) {
                nextState.isHidden = false
                yourNumStatement.isHidden = false
                resetStatesButton.isHidden = false
                setCircle()
                curState = "p"
                nextState.setTitle("Start Turing Machine", for: .normal)
                /*-------------FILLING IN TAPE WITH INPUT-------------*/
                theTape.removeAllSegments()
                for i in binTextField.text!  {
                    theTape.insertSegment(withTitle: "\(i)" , at: (binTextField.text?.count)!, animated: true)
                }
                theTape.insertSegment(withTitle: "U" , at: (binTextField.text?.count)!+1, animated: true)
                /*-------------FILLING IN TAPE WITH INPUT-------------*/
                /*-------------LABEL TEXT-------------*/
                if binTextField.text != ""{
                    let theBin = binTextField.text
                    let toDec = Int(theBin!, radix: 2)!
                    yourNumStatement.text = "You entered \(toDec) in binary"
                }
                else{
                    yourNumStatement.text = "You entered 0 in binary"
                }
                /*-------------LABEL TEXT-------------*/
                
            }
            else{
                noBinAlert()
            }
                
    }
    
    
    @IBAction func nextState(_ sender: UIButton) {
        switch curState {
        case "p":
            theTape.selectedSegmentIndex = 0
            nextState.setTitle("Next State", for: .normal)
            setCircleFill()
            curState = "s"
            startStateA.startCanvasAnimation()
        case "s":
            if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "0" {
                moveRight()
                setCircle()
                curState = "1"
                setCircleFill()
                stateOneA.startCanvasAnimation()
            }
            else if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "1"{
                theTape.setTitle("$", forSegmentAt: theTape.selectedSegmentIndex)
                moveRight()
                setCircle()
                curState = "3"
                setCircleFill()
                stateThreeA.startCanvasAnimation()
            }
            else{
                setTapeToOne()
                setCircle()
                curState = "a"
                setCircleFill()
                acceptStateA.startCanvasAnimation()
            }
        case "1":
            if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "0" || theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "1" {
                moveRight()
                stateOneA.startCanvasAnimation()
            }
            else{
                moveLeft()
                setCircle()
                curState = "2"
                setCircleFill()
                stateTwoA.startCanvasAnimation()
            }
        case "2":
            if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "0" {
                setTapeToOne()
                moveRight()
                setCircle()
                curState = "a"
                setCircleFill()
                acceptStateA.startCanvasAnimation()
            }
            else{
                setTapeToZero()
                moveLeft()
                stateTwoA.startCanvasAnimation()
            }
        case "3":
            if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "1"{
                moveRight()
                stateThreeA.startCanvasAnimation()
            }
            else if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "0" {
                moveRight()
                setCircle()
                curState = "5"
                setCircleFill()
                stateFiveA.startCanvasAnimation()
            }
            else{
                setTapeToZero()
                moveLeft()
                setCircle()
                curState = "4"
                setCircleFill()
                stateFourA.startCanvasAnimation()
            }
        case "4":
            if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "1"{
                setTapeToZero()
                moveLeft()
                stateOneA.startCanvasAnimation()
            }
            else{
                setTapeToOne()
                moveRight()
                setCircle()
                curState = "a"
                setCircleFill()
                acceptStateA.startCanvasAnimation()
            }
        case "5":
            if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "0" || theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "1" {
                moveRight()
                stateFiveA.startCanvasAnimation()
            }
            else{
                moveLeft()
                setCircle()
                curState = "6"
                setCircleFill()
                stateSixA.startCanvasAnimation()
            }
        case "6":
            if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "1"{
                setTapeToZero()
                moveLeft()
                stateSixA.startCanvasAnimation()
            }
            else{
                setTapeToOne()
                moveLeft()
                setCircle()
                curState = "7"
                setCircleFill()
                stateSevenA.startCanvasAnimation()
            }
        case "7":
            if theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "0" || theTape.titleForSegment(at: theTape.selectedSegmentIndex) == "1" {
                moveLeft()
                stateSevenA.startCanvasAnimation()
            }
            else{
                setTapeToOne()
                moveRight()
                setCircle()
                curState = "a"
                setCircleFill()
                acceptStateA.startCanvasAnimation()
            }
        default:
            accepted()
        }
    }
    @IBAction func resetStatesAction(_ sender: UIButton){
        resetStates()
    }
    @IBAction func nextTM(_ sender: UIButton) {
        resetStates()
    }
    /*--------------------------------Functions-------------------------------------**/
    func noBinAlert(){
        /*ACTUAL ALERT**/
        let alertController = UIAlertController(title: "Alert", message: "Be Sure to Insert Binary Digit", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
        /*ACTUAL ALERT**/
        resetStates()
    }
    func resetStates(){
        nextState.isHidden = true
        resetStatesButton.isHidden = true
        yourNumStatement.isHidden = true
        nextState.setTitle("Start Turing Machine", for: .normal)
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
        let alertController = UIAlertController(title: "", message: "You're binary was incremented by 1", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
        /*ACTUAL ALERT**/
    }
    func isBinary(theArg: String) -> Bool{
            var isitBinary = true
            for abit in theArg{
                if abit == "0" || abit == "1" {
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
    func setTapeToOne(){
        theTape.setTitle("1", forSegmentAt: theTape.selectedSegmentIndex)
    }
    func setTapeToZero(){
        theTape.setTitle("0", forSegmentAt: theTape.selectedSegmentIndex)
    }
    
}

