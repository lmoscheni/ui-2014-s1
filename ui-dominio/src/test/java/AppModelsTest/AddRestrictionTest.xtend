package AppModelsTest

import ApplicationsModels.AddRestriction
import Domain.Employee
import Domain.Restriction
import org.junit.Before
import org.junit.Test
import org.uqbar.commons.model.UserException
import static org.junit.Assert.*
import org.joda.time.DateTime

class AddRestrictionTest {
	AddRestriction appModel
	Restriction restriction
	Restriction notValidRestriction
	Employee employee

	@Before
	def void init() {
		restriction = new Restriction
		restriction.date = new DateTime("3000-04-04")
		
		notValidRestriction = new Restriction //not valid because is before todays date
		notValidRestriction.date = new DateTime("2014-03-10")
		
		employee = new Employee

		appModel = new AddRestriction
		appModel.restriction = restriction
		appModel.selected = employee
	}
	
	@Test
	def void addRestrictionTest() {
		assertTrue(appModel.selected.restrictions.isEmpty)
		appModel.addRestriction
		assertEquals(appModel.selected.restrictions.length, 1)
		assertEquals(appModel.selected.restrictions.get(0), restriction)
	}

	@Test
	def void addNotValidRestrictionTest() {
		appModel.restriction = notValidRestriction
		try {
			appModel.addRestriction
		} catch (UserException msg) {
			assertTrue(appModel.selected.restrictions.isEmpty)
			assertTrue(true)
		}
	}
}
