package Domain

import Exceptions.RepeatedRestrictionException
import java.io.Serializable
import java.util.ArrayList
import java.util.List
import org.joda.time.DateTime
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
class Employee implements Serializable{
	
	@Property String name
	@Property String file
	@Property String surname
	@Property List<Restriction> restrictions
	@Property List<Availability> availabilitys
	
	
	//********************************** Constructor ************************************************
	new(){
		this.restrictions = new ArrayList<Restriction>()
		this.availabilitys = new ArrayList<Availability>
	}
	
	new (String name, String surname, String file){
		this.name = name
		this.file = file
		this.surname = surname
		this.availabilitys = new ArrayList<Availability>
		this.restrictions  = new ArrayList<Restriction>
	}
	
	//***********************************************************************************************
	
	
	//************************ Methods of restrictions **********************************************
	def addRestriction(Restriction res){
		if(this.restrictions.empty && this.restrictions.exists[restriction | (this.sonElMismoDia(restriction.date, res.date))]){
			throw new RepeatedRestrictionException("Restriccion repetida")
		}
		else{
			restrictions.add(res)	
		}
	}
	
	def removeRestriction(Restriction restriction){
		this.restrictions.remove(restriction)
	}
	//***********************************************************************************************
	
	//************************ Methods of Availability **********************************************
	def addAvailability(Availability av){
		if(this.availabilitys.exists[availability | availability.dayOfWeek.equals(av.dayOfWeek)]){
			throw new UserException("Disponibilidad ya existe")
		}else{
			this.availabilitys.add(av)
			ObservableUtils.firePropertyChanged(this, "availabilityDays", availabilityDays)
		}
	}
	
	def removeAvailability(Availability a){
		availabilitys = (availabilitys.filter[date | !date.dayOfWeek.equals(a.dayOfWeek)]).toList
		ObservableUtils.firePropertyChanged(this, "availabilityDays", availabilityDays)
	}
	//*********************************************************************************************
	
	//******************************** Other methods **********************************************
	private def tienenElMismoAño(DateTime d1,DateTime d2){
		d1.year().equals(d2.year())
	}

	private def tienenElMismoMes(DateTime d1, DateTime d2){
		d1.monthOfYear().equals(d2.monthOfYear())
	}
	
	private def tienenElMismoDia(DateTime d1, DateTime d2){
		d1.dayOfMonth().equals(d2.dayOfMonth())
	}
	
	private def sonElMismoDia(DateTime d1, DateTime d2){
	  (this.tienenElMismoAño(d1, d2) && this.tienenElMismoMes(d1, d2) && this.tienenElMismoDia(d1, d2))
	}
	
	def String availabilityDays(){
		var b = " "
		for(Availability av : this.availabilitys){
			b = (b.concat(" ")).concat(av.dayOfWeek)
		}
		b
	}
	
	def validate(){
		if(name == null){
			throw new UserException("Debe ingresar un nombre")
		}
		if(surname == null){
			throw new UserException("Debe ingresar un apellido")
		}
		if(file == null){
			throw new UserException("Debe ingresar un legajo")
		}
		if(availabilitys.length == 0){
			throw new UserException("Debe ingresar al menos una disponibilidad")
		}
	}
	
	def isAvailabilityToDay(DateTime day, int start, int end ){
		availabilitys.exists[ availability | ((availability.dayOfWeek).equals(day.dayOfWeek().getAsText) && 
			                                  availability.availableInThePeriod(start,end))
		]
	}
	
	def hasRestriction(DateTime d){
		restrictions.exists[ r | this.sonElMismoDia(r.date,d)]
	}
	
	override def toString(){
		name.concat(" ").concat(surname)
	}
	//*********************************************************************************************
}








