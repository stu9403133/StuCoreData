//
//  CoredataManager.swift
//  StuCoreData
//
//  Created by stu on 2024/3/20.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager() // singleton
 
    let employee = Employee()
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StuCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    //CRUD func
    
    // create
    @discardableResult
    func createEmployee(name: String) -> Employee? {
        let context = persistentContainer.viewContext
        
        // 在Entity之中新增物件
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        
        employee.name = name
        
        do{
            try context.save()
            return employee
        } catch let createError{
            print(createError)
        }
        return nil
    }
    
    // Read(fetch employees)
    func fetchEmployees() -> [Employee]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        
        do{
            let employees = try context.fetch(fetchRequest)
            return employees
        } catch let fetchError{
            print("Failed to fetch employee", fetchError)
        }
        return nil
    }
    
    //Read (fetch employee)
    func fetchEmployee(name: String) -> Employee? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do{
            let employee = try context.fetch(fetchRequest)
            return employee.first
        } catch let fetchError{
            print("Failed to fetch employee", fetchError)
        }
        return nil
    }
    
    //update
    func updateEmployee(employee: Employee) {
        let context = persistentContainer.viewContext
        do{
            try context.save()
        } catch let updateError{
            print(updateError)
        }
    }
    
    //delete
    func deleteemployee(employee: Employee) {
        let context = persistentContainer.viewContext
        context.delete(employee)
        do{
            try context.save()
        } catch let deleteError{
            print(deleteError)
        }
        
    }
    
    
}
