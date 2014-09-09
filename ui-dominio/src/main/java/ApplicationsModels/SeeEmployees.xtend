package ApplicationsModels

import Domain.Employee
import Domain.Scheduler
import java.io.Serializable
import java.util.ArrayList
import java.util.List
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Observable
class SeeEmployees implements Serializable {
	@Property val scheduler = Scheduler.getInstance
	@Property List<Employee> employees = scheduler.employees
	@Property var Employee selected
	
	def update(){
		ObservableUtils.firePropertyChanged(this, "employees", employees);
	}
	
	def search(){
		employees = new ArrayList<Employee>
		employees = scheduler.employees
	}
}