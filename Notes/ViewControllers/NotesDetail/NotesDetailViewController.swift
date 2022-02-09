//
//  NotesDetailViewController.swift
//  Notes + CoreData
//
//  Created by Dinara Alagozova on 06.02.2022.
//

import UIKit
import CoreData

class NotesDetailViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var selectedNote: Note? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedNote != nil {
            titleTextField.text = selectedNote?.title as String?
            contentTextView.text = selectedNote?.content as String?
        }
        
    }
    
    @IBAction func cancelTappedButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTappedButton(_ sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if selectedNote == nil {
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
                   let newNote = Note(entity: entity!, insertInto: context)
                   newNote.id = noteList.count as NSNumber
                   newNote.title = titleTextField.text as NSString?
                   newNote.content = contentTextView.text as NSString?
                   do {
                       try context.save()
                       noteList.append(newNote)
                       navigationController?.dismiss(animated: true)
                   }
                   catch {
                       print("context save error occured")
                   }
        } else {
            // editNote
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results: NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let note = result as! Note
                    if note == selectedNote {
                        note.title = titleTextField.text as NSString?
                        note.content = contentTextView.text as NSString?
                        try context.save()
                        navigationController?.dismiss(animated: true)
                    }
                }
            } catch {
                print("Fetch failed")
            }
        }
       
    }
    
    
}
