//
//  EnterScorePopupViewController.swift
//  ScrollingGolfers
//
//  Created by Keith Bamford on 17/02/2018.
//  Copyright © 2018 AKA Consultants. All rights reserved.
//

import UIKit

class EnterScorePopupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
        //MARK: - Outlets and Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var enterScorePicker: UIPickerView!
    @IBOutlet weak var saveScoreButton: UIButton!
    @IBOutlet weak var titleImage: UIImageView!
    
    
    var scoresForPicker = [Int]()
    var golfer: GolferStruct?
    
    //MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //DEBUG
        print("AWAKE FROM NIB CALLED")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterScorePicker.delegate = self

        for index in 10...50 {
            scoresForPicker.append(index)
        }
        //DEBUG
        //print("scoresForPicker.count \(scoresForPicker.count)")
        print("VIEW DID LOAD CALLED")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        enterScorePicker.selectRow(scoresForPicker.count/2, inComponent: 0, animated: false)
        //DEBUG
        print("VIEW DID APPEAR CALLED")
        titleLabel.text = golfer?.name
        titleImage.image = golfer?.image
        titleImage.contentMode = .scaleAspectFill
        titleImage.layer.cornerRadius = 22
        titleImage.clipsToBounds = true
    }

    //MARK: - PickerView
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return scoresForPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.frame.height/3
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
                let pickerLabel = UILabel()
                pickerLabel.textColor = UIColor.richRed
                pickerLabel.text = String(scoresForPicker[row])
                pickerLabel.font = UIFont(name: pickerLabel.font.fontName, size: 15)
                pickerLabel.font = UIFont(name: "Chalkduster", size: 36)
                pickerLabel.textAlignment = NSTextAlignment.center

                // Try set size of label
                pickerLabel.bounds.size = CGSize(width: pickerView.frame.width, height: pickerView.frame.height/3)
        
                //DEBUG
                //print(pickerLabel)
                return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected Value: \(row+10)")
    }
    
    
    @IBAction func enterScoreTouchUpInside(_ sender: UIButton) {

        let selectedRow = enterScorePicker.selectedRow(inComponent: 0)
        //DEBUG
        let score = selectedRow+10
        print("Selected Value to Save \(score)")
        
        
        let today = Date.dateAsString(Date())
        
        
        let oldScore = golfer!.scores?.updateValue(score, forKey: today)
        //print(oldScore)
        print(golfer!)
        
        dismiss(animated: true, completion: nil)
    }
    
}










