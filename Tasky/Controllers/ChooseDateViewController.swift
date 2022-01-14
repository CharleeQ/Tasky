import UIKit

class ChooseDateViewController: UIViewController {
    
    var delegate: TasksTableViewController?

    @IBOutlet weak var datePicker: UIDatePicker!

    
    @IBAction func acceptDateTapped(_ sender: UIButton) {
        delegate?.fetchTasks(of: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
