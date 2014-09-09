package ApplicationsModels

import Domain.Assignment
import Domain.Employee
import Domain.Planification
import java.util.ArrayList
import java.util.List
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.ObservableUtils
import Domain.Scheduler

@Observable
class CreateAssignment {

	@Property var Assignment assignment
	@Property var List<Assignment> assignments
	@Property var List<Employee> employees
	@Property var Employee employee
	@Property var Planification planification
	@Property val scheduler = Scheduler.getInstance
	@Property val hours = new ArrayList<Integer>()
	
	new(Planification p){
		this.planification = p
		this.assignments = p.assignments
		this.assignment = new Assignment
		_hours.addAll(0..23)
		
	}
	
	def stateOfEmployee(){
		var ret = ""
		if(employee.hasRestriction(planification.day)) {
		ret ="No-Tiene restriccion"
		} else { if(planification.isAssigned(employee)) {
				 	ret = "No-Ya esta asignado"
				 	}else{ if(employee.isAvailabilityToDay(planification.day,assignment.start,assignment.end)) {
				 			ret = "Si"
				 		   }else {ret = "No"}
			        }
			        
			   }				
		ret
	}
	
	def update(){
		ObservableUtils.firePropertyChanged(this, "scheduler", scheduler);
	}
	
	def addAssignment(){
		planification.addAssignment(this.assignment)
		ObservableUtils.firePropertyChanged(this, "assignments", assignments)
	}
	
	
	def search(){
		assignment.validate
		employees = new ArrayList<Employee>()
		employees = scheduler.employees
	}	
}