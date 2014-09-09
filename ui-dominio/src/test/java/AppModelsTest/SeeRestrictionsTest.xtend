package AppModelsTest

import ApplicationsModels.AddRestriction
import ApplicationsModels.SeeRestrictions
import Domain.Employee
import Domain.Restriction
import org.joda.time.DateTime
import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*

class SeeRestrictionsTest {
	AddRestriction restrictionAppModel
	SeeRestrictions appModel
	Employee employee
	DateTime day
	Restriction restriction
	
	@Before
	def void init(){
		day = new DateTime("3000-12-12")
		employee = new Employee
		
		restriction = new Restriction
		restriction.date = day
		restriction.employee = employee
		
		appModel = new SeeRestrictions
		appModel.selectedRestriction = restriction
		
		restrictionAppModel = new AddRestriction
		restrictionAppModel.restriction = restriction
		restrictionAppModel.selected = employee
	}
	
	@Test
	def void deleteTest(){
		assertTrue(appModel.restrictions.isEmpty)
		restrictionAppModel.addRestriction
		assertEquals(appModel.selectedRestriction.employee.restrictions.length, 1)
		assertTrue(appModel.selectedRestriction.employee.restrictions.contains(restriction))
		
		appModel.delete
		assertTrue(appModel.restrictions.isEmpty)
	}
}