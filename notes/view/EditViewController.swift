//
//  EditViewController.swift
//  notes
//
//  Created by ORCUN BAYINDIR on 13.07.2021.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var defaultNoteData:ModelNote?
    var refreshMethod:Callback?
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let content = defaultNoteData?.noteContent {
            textView.text = content
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { timer in
            self.textView.becomeFirstResponder()
        }
        
    }
    @IBAction func updateClick(_ sender: Any) {
        
        if defaultNoteData != nil {
            userDefaults.setValue(textView.text, forKey: defaultNoteData!.positionIndex)
            
            self.dismissPage()
        }
    }
    @IBAction func deleteClick(_ sender: Any) {
        
        let alert = UIAlertController(title: "Alert", message: "You sure you want to delete ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.userDefaults.removeObject(forKey: self.defaultNoteData!.positionIndex)
            
            self.dismissPage()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func dismissPage(){
        self.dismiss(animated: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("EDIT LIFE : viewDidAppear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("EDIT LIFE : viewWillDisappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("EDIT LIFE : viewDidDisappear")
        if(self.refreshMethod != nil) {
            self.refreshMethod!()
        }
    }
    override func willMove(toParent parent: UIViewController?) {
        print("EDIT LIFE : willMove")
    }
    override func didMove(toParent parent: UIViewController?) {
        print("EDIT LIFE : didMove")
    }
    
    
}
