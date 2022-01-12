import UIKit

class ChooseDateViewController: UIViewController {
    
    var delegate: TasksTableViewController?

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func acceptDateTapped(_ sender: UIButton) {
        delegate?.fetchTasks(of: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
