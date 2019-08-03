//
//  ViewController.swift
//  Task Machine!
//
//  Created by Aleksander  on 02/08/2019.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var data:[String] = []
    var selectedRow:Int = -1
    var newRowText:String = "" 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.dataSource = self
        taskTableView.delegate = self
        self.title = "To Do List"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newTask))
        self.navigationItem.rightBarButtonItem = addButton
        
        hello(title: "Good day", message: "Let's organize your day")
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        if selectedRow == -1 {
            return
        }
        
        data[selectedRow] = newRowText
        if newRowText == "" {
            
            data.remove(at: selectedRow)
            
        }
        
        taskTableView.reloadData()
        saveData()
        
    }
    
    @objc func newTask() {
        
        let name:String = ""
        data.insert(name, at: 0)
        
        let indexPath:IndexPath = IndexPath(row: 0, section: 0)
        taskTableView.insertRows(at: [indexPath], with: .fade)
        taskTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "detailViewSegue", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.textLabel?.text = data[indexPath.row]
        cell.selectionStyle = .none
        cell.checkedBox.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
        
        return cell
        
    }
    
    @objc func checkMarkButtonClicked (sender: UIButton) {
        
        print("Button Clicked!")
        
        if sender.isSelected {
            
            sender.isSelected = false
            
        } else {
            
            sender.isSelected = true
            
        }
        taskTableView.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        super.setEditing(editing, animated: animated)
        taskTableView.setEditing(editing, animated: animated)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        taskTableView.deleteRows(at: [indexPath], with: .fade)
        SoundService.playSounds(.tear)
        saveData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "detailViewSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let detailView:DetailViewController = segue.destination as! DetailViewController
        selectedRow = taskTableView.indexPathForSelectedRow!.row
        detailView.masterView = self
        detailView.setText(t: data[selectedRow])
    }
    
    func saveData() {
        
        UserDefaults.standard.set(data, forKey: "tasks")
        
    }
    
    func loadData() {
        
        if let loadedData:[String] = UserDefaults.standard.value(forKey: "tasks") as? [String] {
            data = loadedData
            taskTableView.reloadData()
            
        }
    }
    
    func hello (title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Great!", style: UIAlertAction.Style.default, handler: { (action) in alert.dismiss(animated: true, completion: nil )
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}

