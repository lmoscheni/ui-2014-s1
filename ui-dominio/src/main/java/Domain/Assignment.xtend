package Domain

import java.io.Serializable
import org.joda.time.DateTime
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
class Assignment implements Serializable{
	@Property var Employee employee
	@Property var DateTime day
	@Property var int start
	@Property var int end
	
	new(Employee employee,DateTime day,int start, int end){
		this.employee = employee
		this.day = day
		this.start = start
		this.end = end
	}
	
	new(){
		
	}
	
	def validate(){
		if(end < start){
			throw new UserException("El inicio del horario no puede superar al final")
		}
		if(end-start < 4){
			throw new UserException("Horario minimo de turno es 4hs")
		}
		if(end-start > 8){
			throw new UserException("Horario maximo de turno es 8hs")
		}
	}

}
