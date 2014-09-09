package Domain

import java.io.Serializable
import org.joda.time.DateTime
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
class Availability implements Serializable{
	
	@Property DateTime day
	@Property int from
	@Property int to
	@Property String dayOfWeek = null
	
	new(){}
	
	new (DateTime day,int from, int to){
		this.day = day
		this.from = from
		this.to = to
	}
	
	def setFrom(int from){
		_from = from
		if(from < 0){
			throw new UserException("El horario no puede ser negativo")
		}
	}
	
	def setTo(int to){
		_to = to
		if(to > 24){
			throw new UserException("El horario no puede ser mayor a 24")
		}
	}
	
	def availableInThePeriod(int start, int end){
		return (start >= from && end <= to)
	}
	
	def validate(){
		if(from >= to){
			throw new UserException("¨Desde¨ debe ser menor que ¨hasta¨")
		}
		if((to-from) < 4){
			throw new UserException("La disponibilidad minima es de 4hs")
		}
		if(dayOfWeek == null){
			throw new UserException("Debe elegir un dia de la semana")
		}
	}
}
	