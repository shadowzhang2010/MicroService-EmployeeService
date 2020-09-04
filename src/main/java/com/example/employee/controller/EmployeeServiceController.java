package com.example.employee.controller;

import java.util.HashMap;
import java.util.Map;
 
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.example.employee.beans.Employee;
 

 
@RestController
public class EmployeeServiceController {
	 private static final Map<Integer, Employee> employeeData = new HashMap<Integer,Employee>();      
     static{
    	 employeeData.put(111,new Employee(111,"Employee1"));
    	 employeeData.put(222,new Employee(222,"Employee2"));
     }
 
  
    @RequestMapping(value = "/findEmployeeDetails/{employeeId}", method = RequestMethod.GET)
    public Employee getEmployeeDetails(@PathVariable int employeeId) {
        System.out.println("Getting Employee details for " + employeeId);
  
        Employee employee = employeeData.get(employeeId);
        if (employee == null) {
             
            employee = new Employee(0, "N/A");
        }
        return employee;
    }
}
