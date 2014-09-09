package Employees

import Domain.Availability
import Domain.Employee
import java.util.ArrayList

class MapEmployeeAvailabilities {
	
	@Property Employee employee
	@Property ArrayList<Availability> availabilities
	
	new(){
		availabilities = new ArrayList<Availability>
	}
	
	def addAvailability(Availability a){
		this.availabilities.add(a)
	}
}