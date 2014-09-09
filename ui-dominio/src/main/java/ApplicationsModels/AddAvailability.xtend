package ApplicationsModels

import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.Entity
import Domain.Employee
import Domain.Availability
import java.util.List
import java.util.ArrayList

@Observable
class AddAvailability extends Entity{
	
	@Property var Employee employee
	@Property var Availability availability
	@Property List<String> days = new ArrayList<String>
	
	new(Employee e){
		this.employee = e
		this.availability = new Availability
		this.days.add("lunes")
		this.days.add("martes")
		this.days.add("miércoles")
		this.days.add("jueves")
		this.days.add("viernes")
		this.days.add("sabado")
		this.days.add("domingo")
	}

	def addAvailability(){
		employee.addAvailability(availability)
	}
}