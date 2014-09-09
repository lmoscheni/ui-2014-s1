package Domain

import java.io.Serializable
import java.util.ArrayList
import org.joda.time.DateTime
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
class Planification implements Serializable{
	@Property DateTime day
	@Property val assignments = new ArrayList<Assignment>
	@Property var boolean confirm = false
	@Property var String statePlanification = "Sin planificar"

	new(DateTime aDay) {
		this.day = aDay
	}

	def confirmPlanification() {
		confirm = true
		statePlanification = "Planificada"
	}
	
	def boolean isConfirmed(){
		confirm
	}
	
	def isAvailable(Employee employee,int start, int end){
		employee.isAvailabilityToDay(day,start,end)
	}
	
	def isAssigned(Employee e){
		assignments.exists[a | a.employee.name.equals(e.name) && a.employee.surname.equals(e.surname)]
	}
	
	def addEmployeeToPlanificationForTheDay(Employee employee, int start, int end){
		if (this.isAvailable(employee,start,end)){
			this.assignments.add(new Assignment(employee,day,start,end))
		}
	}
	
	
	def deleteAssignment(Assignment a){
		this.assignments.remove(a)	
	}
	
	def addAssignment(Assignment a){
		if(a.employee.hasRestriction(day)){
			throw new UserException("Posee restriccion")
		}
		if(this.isAssigned(a.employee)){
			throw new UserException("Ya esta asignado")
		}
		this.assignments += a
		_assignments.sortBy[ assign | assign.start ]
	}
	
	def viewDate(){
		day.toString("dd-MMMM-yyyy")
	}
	
	def isBeforeToday(){ 
		if(day.beforeNow){
			throw new UserException("No podés planificar una fecha anterior a la actual")
		}
	}
}
