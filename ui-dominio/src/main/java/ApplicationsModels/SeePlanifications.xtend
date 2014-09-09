package ApplicationsModels

import Domain.Assignment
import Domain.Employee
import Domain.Planification
import Domain.Scheduler
import java.io.Serializable
import java.util.ArrayList
import java.util.List
import org.joda.time.DateTime
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Observable
class SeePlanifications implements Serializable {
	
	@Property Scheduler scheduler = Scheduler.getInstance
	@Property DateTime day
	@Property var Employee employeeSelector
	@Property var Planification selectedPlanning
	@Property var Assignment assignment
	@Property var ArrayList<Planification> planifications
	
	new(){
		planifications = scheduler.planifications
	}
	
	def isPuedePlanificar(){
		!selectedPlanning.confirmed
	}
	
	def setselectedPlanning(Planification p){
		_selectedPlanning = p
		ObservableUtils.firePropertyChanged(this, "puedePlanificar", puedePlanificar)
	}
	
	def confirmSelectedPlanning(){
		selectedPlanning.confirmPlanification
	}
	
	def addSelectedPlanning() {
		scheduler.addPlanification(selectedPlanning)
	}
	
	def assignments() {
		selectedPlanning.assignments
	}
	
	def update(){
		planifications = new ArrayList<Planification>
		planifications = scheduler.planifications
		ObservableUtils.firePropertyChanged(this, "scheduler", scheduler)
	}
}
