import UIKit
import CoreData

class TasksTableViewController: UITableViewController {
    
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var tasks = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchTasks(of: .now)
        
    }
    
    func fetchTasks(of date: Date) {
        
        // Clear array
        tasks.removeAll()
        
        // Fetch tasks
        tasks = DataManager.shared.read(of: date)
        
        // Edit UI
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        dayOfWeekLabel.text = formatter.string(from: date)
        formatter.dateFormat = "MMMM d, yyyy"
        dateLabel.text = formatter.string(from: date)
//        navigationItem.title = formatter.string(from: date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func chooseDateTapped(_ sender: Any) {
        
        guard let chooseDateVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChooseDateVCID") as? ChooseDateViewController else { return }
        chooseDateVC.delegate = self
        navigationController?.present(chooseDateVC, animated: true, completion: nil)
        
    }
    
    @IBAction func addTaskTapped(_ sender: Any) {
        
        guard let addTaskVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddTaskVCID") as? AddTaskTableViewController else { return }
        addTaskVC.delegate = self
        navigationController?.pushViewController(addTaskVC, animated: true)
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        cell.titleLabel.text = tasks[indexPath.row].title
        cell.descriptionLabel.text = tasks[indexPath.row].descript
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            guard let editTaskVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditTaskVCID") as? EditTaskViewController else { return }
            editTaskVC.delegate = self
            editTaskVC.task = tasks[indexPath.row]
            navigationController?.pushViewController(editTaskVC, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {

            let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions -> UIMenu in
                
                let deleteButton = UIAction(
                    title: "Delete",
                    image: UIImage(systemName: "trash"),
                    attributes: .destructive,
                    state: .off
                ) { _ in
                    guard let date = self.tasks[indexPath.row].date else { return }
                    DataManager.shared.delete(task: self.tasks[indexPath.row])
                    self.fetchTasks(of: date)
                }
                
                return UIMenu.init(children: [deleteButton])
                
            }
            return config
    }
    
}
