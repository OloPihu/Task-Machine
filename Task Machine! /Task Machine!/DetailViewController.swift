//
//  DetailViewController.swift
//  Task Machine!
//
//  Created by Aleksander  on 02/08/2019.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var taskTextView: UITextView!
    
    var text:String = ""
    var masterView:ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTextView.text = text
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        taskTextView.becomeFirstResponder()
        
    }
    
    func setText(t:String) {
        
        text = t
        
        if isViewLoaded {
            
            taskTextView.text = t
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        masterView.newRowText = taskTextView.text
        taskTextView.resignFirstResponder()
        SoundService.playSounds(.newPage)
        
    }
}
