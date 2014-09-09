package ApplicationsModels

import Domain.Assignment
import Domain.Planification
import Domain.Scheduler
import org.uqbar.commons.utils.Observable

@Observable
class AddPlanification{
	@Property var scheduler = Scheduler.getInstance()
	
	@Property var Planification selected
	@Property var Assignment assignmentSelector
		
	def addPlanification() {
		scheduler.addPlanification(selected)
	}
	
	def addAssignment() {
		this.selected.assignments.add(assignmentSelector)
	}
	
	def assignments() {
		selected.assignments
	}
	
}