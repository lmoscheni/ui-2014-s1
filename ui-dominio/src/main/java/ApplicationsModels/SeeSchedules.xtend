package ApplicationsModels

import java.util.List
import Domain.Assignment
import Domain.Planification
import org.uqbar.commons.utils.Observable

@Observable
class SeeSchedules {
	@Property var List<Assignment> assignments
	@Property var Assignment selected
	
	new(Planification p){
		this.assignments = p.assignments
	}
}