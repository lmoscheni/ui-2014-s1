package AppModelsTest

import ApplicationsModels.AddPlanification
import Domain.Assignment
import Domain.Planification
import org.joda.time.DateTime
import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*

class AddPlanificationTest {
	AddPlanification appModel
	Planification planification
	Assignment assignment
	
	@Before
	def void init() {
		planification = new Planification(new DateTime)
		assignment = new Assignment
		
		appModel = new AddPlanification
		appModel.selected = planification
		appModel.assignmentSelector = assignment
	}
	
	@Test
	def void addPlanificationTest() {
		assertTrue(appModel.scheduler.planifications.isEmpty)
		appModel.addPlanification
		assertEquals(appModel.scheduler.planifications.length, 1)
		assertEquals(appModel.scheduler.planifications.get(0), planification)
	}
	
	@Test
	def void addAssignmentTest() {
		assertTrue(appModel.selected.assignments.isEmpty)
		appModel.addAssignment
		assertEquals(appModel.selected.assignments.length, 1)
		assertEquals(appModel.selected.assignments.get(0), assignment)
	}
}