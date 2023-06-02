import CoreData



struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Cookbook")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "user.csv")
        }
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load persistent store: \(error)")
            }
        }
    }
}

