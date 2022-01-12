import Foundation
import CoreData
import UIKit

class DataManager {
    
    static let shared = DataManager()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    
    // MARK: - CRUD functions
    
    func create(
        title: String?,
        description: String?,
        date: Date
    ) {
        let newTask = Task(context: context)
        newTask.title = title
        newTask.descript = description
        newTask.date = date.stripTime()
        newTask.isComplete = false
        
        do {
            try context.save()
        }
        catch let err {
            print("Error: Context not saving in storage - \(err)")
        }
    }
    
    func read(of date: Date) -> [Task] {
        var tasks = [Task]()
        
        do {
            let tasksArr = try context.fetch(Task.fetchRequest())
            tasksArr
                .filter { $0.date == date.stripTime() }
                .forEach { tasks.append($0) }
        }
        catch let err {
            print("Error: task not fetching - \(err)")
        }
        
        return tasks
    }
    
    func update(
        task: Task,
        title: String?,
        description: String?,
        date: Date,
        isComplete: Bool
    ) {
        task.title = title
        task.descript = description
        task.isComplete = isComplete
        task.date = date.stripTime()
        
        do {
            try context.save()
        }
        catch let err {
            print("Error: no update item - \(err)")
        }
    }
    
    func delete(task: Task) {
        context.delete(task)
        do {
            try context.save()
        }
        catch let err {
            print("Error: Invalid delete item - \(err)")
        }
    }
    
}
