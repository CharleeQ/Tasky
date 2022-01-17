import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkBtn: CheckButton!
    
    private var task: Task?
    
    func config(task: Task) {
        titleLabel.text = task.title
        descriptionLabel.text = task.descript
        checkBtn.isComplete = task.isComplete
        self.task = task
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func checkBtnTapped(_ sender: CheckButton) {
        
        guard let task = task else { return }
        sender.changeStatus(task: task)
        
    }
    
}
