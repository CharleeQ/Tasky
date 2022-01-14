import UIKit

class EditTaskViewController: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var selectedDateDP: UIDatePicker!
    @IBOutlet weak var completeSwitch: UISwitch!
    
    var delegate: TasksTableViewController?
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let task = task else { return }
        titleTF.text = task.title
        descriptionTV.text = task.descript
        completeSwitch.isOn = task.isComplete
        if let date = task.date {
            selectedDateDP.date = date
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func saveTaskTappeed(_ sender: UIBarButtonItem) {
        
        guard let task = task else { return }
        DataManager.shared.update(
            task: task,
            title: titleTF.text,
            description: descriptionTV.text,
            date: selectedDateDP.date,
            isComplete: completeSwitch.isOn
        )
        delegate?.fetchTasks(of: selectedDateDP.date)
        
        let alert = UIAlertController(title: "Edit", message: "Task was success edited", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Ok, sure", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(submitAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}
