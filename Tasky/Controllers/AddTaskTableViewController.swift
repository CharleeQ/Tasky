import UIKit

class AddTaskTableViewController: UITableViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var selectDateDP: UIDatePicker!
    
    var delegate: TasksTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTaskTapped(_ sender: UIBarButtonItem) {
        
        DataManager.shared.create(
            title: titleTF.text,
            description: descriptionTF.text,
            date: selectDateDP.date.stripTime()
        )
        delegate?.fetchTasks(of: selectDateDP.date)
        
        let alert = UIAlertController(title: "New task", message: "Task was success added", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Ok, sure", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(submitAction)
        
        present(alert, animated: true, completion: nil)
        
    }
}
