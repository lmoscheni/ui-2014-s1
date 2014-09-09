package ApplicationsModels

import Domain.Assignment
import Domain.Planification
import Domain.Scheduler
import java.io.Serializable
import java.util.ArrayList
import java.util.List
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Observable
class SeeAssignments implements Serializable {
	
	@Property var List<ShowAssignment> assignments
	@Property var ShowAssignment selectedShowAssignment
	@Property var Assignment selectedAssignment
	@Property var Planification planification
	@Property val scheduler = Scheduler.getInstance
	@Property var hour = 0
	
	new(Planification p){
		this.planification = p
		this.assignments = planification.assignments.map[ e | new ShowAssignment(e)]
	}
	
	def deleteAssignment(){
		planification.deleteAssignment(selectedShowAssignment.assignment)
		ObservableUtils.firePropertyChanged(this, "assignments", assignments);
	}
	
	def update(){
		ObservableUtils.firePropertyChanged(this, "assignments", assignments);
	}
	
}
