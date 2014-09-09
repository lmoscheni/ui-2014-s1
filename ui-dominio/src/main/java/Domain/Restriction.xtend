package Domain

import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.Entity
import org.uqbar.commons.model.UserException

@Observable
class Restriction extends Entity{
	@Property Employee employee
	@Property DateTime date
	
	new(Employee emp,DateTime d){
		employee = emp
		date = d
	}
	
	new(){
		employee = null
		this.date = null
	}
	
	def String nameEmployee(){
		employee.name.concat(" ").concat(employee.surname)
	}
	
	def validate(){
		if(this.date == null){
			throw new UserException("Debe ingresar una fecha")
		}
		if(this.date.beforeNow){	
			throw new UserException("Fecha anterior a la actual")
		}
	}
	
	def viewDate(){
		date.toString("dd-MMMM-yyyy")
	}
}