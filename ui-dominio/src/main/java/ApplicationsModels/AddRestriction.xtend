package ApplicationsModels

import Domain.Employee
import Domain.Restriction
import Domain.Scheduler
import java.io.Serializable
import org.apache.commons.lang.StringUtils
import org.joda.time.DateTime
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.Observable

@Observable
class AddRestriction implements Serializable{
	@Property var scheduler = Scheduler.getInstance()
	@Property Restriction restriction
	@Property String date
	@Property Employee selected
	
	new(){
		this.restriction = new Restriction
	}
	
	def setDate(String s){
		if(StringUtils.isEmpty(s)){
			null
		}else{
			try{
				var datesParse = s.split("/")
				var stringDate = datesParse.get(0).concat("-").concat(datesParse.get(1)).concat("-").concat(datesParse.get(2)).concat("T23:59:59")
				this.restriction.date = new DateTime(stringDate)
			}catch(Exception e){
				throw new UserException("Formato: yyyy/mm/dd")	
			}
		}
	}
	
	def addRestriction(){
		restriction.validate
		restriction.setEmployee(selected)
		selected.addRestriction(restriction)
	}
}