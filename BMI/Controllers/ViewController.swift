//
//  ViewController.swift
//  BMI
//
//  Created by 유상민 on 2023/07/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    
    var bmiManager = BMICalculatorManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    func makeUI() {
        // 텍스트 필드를 사용하면 반드시 델리게이트패턴을 사용하여 self를 지정해줘야함.
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        mainLabel.text = "키와 몸무게를 입력해 주세요."
        
        // 버튼 외각선을 둥글게
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 5
        
        calculateButton.setTitle("BMI 계산하기", for: .normal)
        
        heightTextField.placeholder = "cm단위로 입력해 주세요."
        weightTextField.placeholder = "kg단위로 입력해 주세요."
    }

    // BMI계산하기 - 버튼 누르면(다음화면으로 데이터 전달)
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        // BMI 결과값
        print(#function)
//        bmiManager.calculateBMI(height: heightTextField.text!, weight: weightTextField.text!)
    }
    
    // 다음화면으로 넘어가기
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무게를 입력해야합니다!!!"
            mainLabel.textColor = UIColor.red
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해 주세요."
        mainLabel.textColor = UIColor.black
        return true
    }
    
    // 다음화면으로 데이터를 전달하기 위함.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController
            // 결과값 데이터 전달하기
//            secondVC.bmiNumber = bmiManager.getBMIResult()
//            secondVC.bmiColor = bmiManager.getBackgroundColor()
//            secondVC.adviceString = bmiManager.getBMIAdviceString()
            
            secondVC.bmi = bmiManager.getBMI(height: heightTextField.text!, weight: weightTextField.text!)
        }
        
        // 데이터 전달 후 다음화면으로 가기전에 텍스트필드 비우기
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == "" {
            return true // 글자 입력을 허용.
        }
        return false // 글자입력 허용하지 않음.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두개의 텍스트필드를 모두 종료 (키보드 내려가기)
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        // 두번째 텍스트 필드로 넘어가도록 처리
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
}
