package ApplicationsModels

import Domain.Restriction
import Domain.Scheduler
import java.io.Serializable
import java.util.ArrayList
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Observable
class SeeRestrictions implements Serializable{
	@Property var ArrayList<Restriction> restrictions
	@Property var Restriction selectedRestriction
	@Property var scheduler = Scheduler.getInstance()
	
	new(){
		restrictions = scheduler.seeRestrictions
	}
	
	def delete(){
		this.selectedRestriction.employee.removeRestriction(this.selectedRestriction)
	} 
	
	def update(){
		restrictions = new ArrayList<Restriction>
		restrictions = scheduler.seeRestrictions
		ObservableUtils.firePropertyChanged(this, "scheduler", scheduler) 
	}

}