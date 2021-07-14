//
//  ViewController.swift
//  notes
//
//  Created by ORCUN BAYINDIR on 13.07.2021.
//

import UIKit

typealias Callback = ()->Void

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    let userDefaults = UserDefaults.standard
    
    let cellReuseIdentifier = "cell"
    
    var dataList = [ModelNote]()
    var selectedNote:ModelNote?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func btnAddNote(_ sender: Any) {
        performSegue(withIdentifier: "toForm", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit" {
            let view = segue.destination as! EditViewController
            view.refreshMethod = {
                self.loadData()
            }
            if self.selectedNote != nil {
                view.defaultNoteData = self.selectedNote
            }
            
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return        self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        
        // set the text from the data model
        cell.textLabel?.text = self.dataList[indexPath.row].noteContent
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedNote = self.dataList[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "toEdit",sender:self)
    }
    
    
    func loadData()  {
        print("LoadData is working")
        
        self.dataList.removeAll()
        let dict = userDefaults.dictionaryRepresentation()
        
        for (key,value) in Array(dict).sorted(by: {$0.0 > $1.0}) {
            
            if(key.contains("AHMET.NOTE")){
                print(key , value)
                self.dataList.append(ModelNote(positionIndex: key,noteContent: value as! String))
            }
        }
        
        self.tableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("LIFE : viewDidAppear")
        loadData()
    }
    
}

