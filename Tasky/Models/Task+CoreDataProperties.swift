import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var date: Date?
    @NSManaged public var descript: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var title: String?

}

extension Task : Identifiable {

}
