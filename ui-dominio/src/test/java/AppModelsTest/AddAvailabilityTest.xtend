package AppModelsTest

import ApplicationsModels.AddAvailability
import Domain.Availability
import Domain.Employee
import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*
import org.joda.time.DateTime

class AddAvailabilityTest {
	AddAvailability appModel
	Employee anEmployee
	Availability anAvailability
	
	@Before
	def void init(){
		anEmployee = new Employee
		anAvailability = new Availability(new DateTime,12,18)

		appModel = new AddAvailability(anEmployee)		
		appModel.setAvailability(anAvailability)
	}
	
	@Test
	def void addAvailabilityTest() {
		assertTrue(appModel.employee.availabilitys.isEmpty)
		appModel.addAvailability
		assertTrue(appModel.employee.availabilitys.contains(anAvailability))
		assertEquals(appModel.employee.availabilitys.length, 1)
	}
}