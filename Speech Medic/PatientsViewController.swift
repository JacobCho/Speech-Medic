//
//  PatientsViewController.swift
//  Speech Medic
//
//  Created by Jacob Cho on 2015-02-26.
//  Copyright (c) 2015 Jacob. All rights reserved.
//

import UIKit
import CoreData

class PatientsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    var patients = [Patient]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.fetchPatients()
        
    }
    
    @IBAction func addPatient(sender: UIBarButtonItem) {
        var alert = UIAlertController(title: "New Patient",
            message: "Please enter the patient's name",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction!) -> Void in
                
                let textField = alert.textFields![0] as UITextField
                self.saveName(textField.text)
                self.tableView.reloadData()
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return patients.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("PatientCell")
                as UITableViewCell
            
            let patient = patients[indexPath.row]
            cell.textLabel!.text = patient.name
            return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            // Save in managedObjectContext
            let patient = self.patients[indexPath.row]
            self.managedObjectContext?.deleteObject(patient)
            var error : NSError?
            self.managedObjectContext?.save(&error)
            
            // Remove from array
            patients.removeAtIndex(indexPath.row)
            
            // Animate
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        }
    }
    
    // MARK: Core Data Methods
    
    func saveName(name: String) {

        let managedContext = self.managedObjectContext!
        
        let patient = Patient.newPatient(managedContext, name: name)
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }

        patients.append(patient)
    }
    
    func fetchPatients() {
        
        let managedContext = self.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Patient")
        
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [Patient]?
        
        if let results = fetchedResults {
            patients = results
            self.tableView.reloadData()
            
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    

}
