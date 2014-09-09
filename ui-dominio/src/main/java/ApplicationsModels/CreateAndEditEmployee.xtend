package ApplicationsModels

import Domain.Availability
import Domain.Employee
import Domain.Scheduler
import java.io.Serializable
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Observable
class CreateAndEditEmployee implements Serializable{
	@Property var Employee employee
	@Property val scheduler = Scheduler.getInstance
	@Property var Availability selectedAvailability
	@Property var boolean create
	
	new(Employee e, boolean create){
		this.employee = e
		this.create = create
	}
	
	def addEmployee() {
		scheduler.addEmployee(employee)
	}
	
	def deleteAvailabilityToEmployee(){
		this.employee.removeAvailability(this.selectedAvailability)
	}
	
	def deleteAvailabilityToEmployee(Availability av){
		this.employee.removeAvailability(av)
	}
	
	def saveChanges(){
		if(this.create == true) this.addEmployee
	}
	
	def update(){
		ObservableUtils.firePropertyChanged(this, "employee", employee);
	}
}