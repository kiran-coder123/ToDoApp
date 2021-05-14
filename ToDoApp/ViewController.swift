//
//  ViewController.swift
//  ToDoApp
//
//  Created by Satinder Panesar on 4/4/21.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController{
    @IBOutlet weak var tblview: UITableView!
    
    var arrTaskData = [String]()
    var databaseHandler: DatabaseHandle?
    var ref: DatabaseReference?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set the firebase referance
        ref = Database.database().reference()
        
        // retrieve the post and listen for changes
        
       databaseHandler = ref?.child("task").observe(.childAdded, with: { (Snapshot) in
             
            // code to execute when child is added under posts
        
        let task = Snapshot.value as? String
        
        if let actualTask = task{
            self.arrTaskData.append(actualTask)
            self.tblview.reloadData()
         }
       })
    }

    @IBAction func btnAddTaskView(_ sender: Any) {
        
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTaskData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblview.dequeueReusableCell(withIdentifier: "taskCell")
        cell?.textLabel?.text = arrTaskData[indexPath.row]
        return cell!
    }
    
    
    
}
