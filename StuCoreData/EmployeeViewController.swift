//
//  EmployeeViewController.swift
//  StuCoreData
//
//  Created by stu on 2024/3/20.
//

import UIKit

class EmployeeViewController: UIViewController {

    
    @IBOutlet weak var employeeConut: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    

    func updateUI(){
        guard let employees = CoreDataManager.shared.fetchEmployees() else {return}
        employeeConut.text = String(employees.count)
    }
    
    
    @IBAction func addEmplo(_ sender: Any) {
        CoreDataManager.shared.createEmployee(name: "Stu")
        updateUI()
    }
    
    
    @IBAction func minusEmplo(_ sender: Any) {
        guard let employees = CoreDataManager.shared.fetchEmployees() else {return}
        guard let employee = employees.last else {return}
        CoreDataManager.shared.deleteemployee(employee: employee)
        updateUI() 
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
