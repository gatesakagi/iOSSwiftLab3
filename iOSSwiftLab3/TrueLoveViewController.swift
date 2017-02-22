//
//  TrueLoveViewController.swift
//  iOSSwiftLab3
//
//  Created by Gates on 2017/2/20.
//
//

import UIKit

class TrueLoveViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let randomNum = Int(arc4random_uniform(12))

    let starLists = ["白羊座 (3月21日 - 4月19日)", "金牛座 (4月21日 - 5月21日)", "雙子座 (5月22日 - 6月21日)","巨蟹座 (6月22日 - 7月22日)","獅子座 (7月23日 - 8月22日)","處女座 (8月23日 - 9月22日)","天秤座 (9月23日 - 10月23日)","天蠍座 (10月24日 - 11月21日)","射手座 (11月22日 - 12月20日)","魔羯座 (12月21日 - 1月20日)","水瓶座 (1月21日 - 2月18日)","雙魚座 (2月19日 - 3月20日)"];
    
    var timer = Timer()
    
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var starTextField: UITextField!
    @IBOutlet weak var genderSegement: UISegmentedControl!
    @IBOutlet weak var yesImgView: UIImageView!
    @IBOutlet weak var noImgView: UIImageView!
    
    @IBAction func btnPressed(_ sender: UIButton) {
        closeKeyboard()
        if (genderSegement.selectedSegmentIndex >= 0 && (starTextField.text?.characters.count)! > 0) {
            
            let indexOfStarTextField : Int! = starLists.index(of: starTextField.text!)
            if (indexOfStarTextField == randomNum) {
                yesImgView.isHidden = false
                noImgView.isHidden = true
            } else {
                yesImgView.isHidden = true
                noImgView.isHidden = false
            }
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.update), userInfo: nil, repeats: true);
        } else {
            let alertController = UIAlertController(title: "您尚有資料尚未選擇", message: "記得再檢查一下哦！", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "確認", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func update() {
        yesImgView.isHidden = true
        noImgView.isHidden = true
        starTextField.text = ""
        genderSegement.selectedSegmentIndex = -1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgImg.image = UIImage(named:"bg\(randomNum)")
        
        // 建立 UIPickerView
        let myPickerView = UIPickerView()

        // 設定 UIPickerView 的 delegate 及 dataSource
        myPickerView.delegate = self
        myPickerView.dataSource = self
        
        // 將 UITextField 原先鍵盤的視圖更換成 UIPickerView
        starTextField.inputView = myPickerView
        
        //加上手勢按鈕
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tap)
    }

    func closeKeyboard(){
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //有幾個區塊
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    //裡面有幾列
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return starLists.count
    }
    //選擇到的那列要做的事
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        starTextField.text = starLists[row]
    }
    //設定每列PickerView要顯示的內容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return starLists[row]
    }
}
