//
//  NewNoteViewController.swift
//  notes
//
//  Created by ORCUN BAYINDIR on 13.07.2021.
//

import UIKit

class FormViewController: UIViewController {

    let userDefaults = UserDefaults.standard
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.becomeFirstResponder()
        
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
        let text = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if !text.isEmpty {
            
            let date = Date()
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd:HH:mm:ss"
            let keyyy = df.string(from: date)
            let key = "AHMET.NOTE\(keyyy)"
            print("key: \(key) , text: \(text)")
            
            userDefaults.setValue(text, forKey: key)
            
            self.navigationController?.popViewController(animated: true)


        }
        
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
