import UIKit

class EditTaskViewController: UITableViewController {
    
    @IBOutlet weak var titleTF: UITextView!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var selectedDateDP: UIDatePicker!
    
    var delegate: TasksTableViewController?
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let task = task else { return }
        titleTF.text = task.title
        descriptionTV.text = task.descript
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
            isComplete: task.isComplete
        )
        delegate?.fetchTasks(of: selectedDateDP.date)
        
        let alert = UIAlertController(title: "Edit", message: "Task was success edited", preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "Ok, sure", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(submitAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
}
