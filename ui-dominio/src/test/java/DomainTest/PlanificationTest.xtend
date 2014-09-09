package DomainTest

import Domain.Assignment
import Domain.Availability
import Domain.Employee
import Domain.Planification
import org.joda.time.DateTime
import org.junit.Before
import org.junit.Test

import static org.junit.Assert.*

class PlanificationTest {
	Planification planification
	DateTime aDay

	Employee anEmployeeA
	Employee anEmployeeB
	Assignment anAssignment

	@Before
	def void init() {
		aDay = new DateTime("2014-03-10")
		planification = new Planification(aDay)

		anEmployeeA = new Employee()
		anEmployeeA.addAvailability(new Availability(aDay, 15, 19))
		anEmployeeB = new Employee()
		anEmployeeB.addAvailability(new Availability(aDay, 15, 19))
		anAssignment = new Assignment
	}

	@Test
	def void confirmPlanificationTest() {
		assertFalse(planification.isConfirmed)
		planification.confirmPlanification
		assertTrue(planification.isConfirmed)
	}

// TODO - descomentar una vez implementado dayOfWeek de Availability
//	@Test
//	def void isAvailableTest() {
//		assertTrue(planification.isAvailable(anEmployeeA, 16, 18))
//		assertFalse(planification.isAvailable(anEmployeeA, 12, 14))
//	}
//
//	@Test
//	def void addEmployeeToPlanificationForTheDayTest() {
//		planification.addEmployeeToPlanificationForTheDay(anEmployeeA, 16, 18)
//		assertTrue(planification.assignments.contains(anEmployeeA))
//
//		planification.addEmployeeToPlanificationForTheDay(anEmployeeB, 12, 14)
//		assertFalse(planification.assignments.contains(anEmployeeB))
//	}
	
	@Test
	def void addAssignmentTest() {
		assertTrue(planification.assignments.isEmpty)
		planification.addAssignment(anAssignment)
		assertEquals(planification.assignments.length, 1)
		assertTrue(planification.assignments.contains(anAssignment))
	}

}
