package DomainTest

import Domain.Assignment
import Domain.Employee
import org.joda.time.DateTime
import org.junit.Before
import org.junit.Test
import org.uqbar.commons.model.UserException
import static org.junit.Assert.*

class AssignmentTest {
	Assignment validAssignment
	Assignment badHoursAssignment
	Assignment lessThan4HoursAssignment
	Assignment moreThan8HoursAssignment
	Employee employee
	DateTime day

	@Before
	def void init() {
		employee = new Employee
		day = new DateTime

		validAssignment = new Assignment(employee, day, 10, 16)
		badHoursAssignment = new Assignment(employee, day, 16, 10)
		lessThan4HoursAssignment = new Assignment(employee, day, 10, 12)
		moreThan8HoursAssignment = new Assignment(employee, day, 10, 18)
	}

	@Test
	def void validateTest() {
		try {
			validAssignment.validate
		} catch (UserException msg) {
			assertFalse(true)
		}

		try {
			badHoursAssignment.validate
		} catch (UserException msg) {
			assertTrue(true)
		}

		try {
			lessThan4HoursAssignment.validate
		} catch (UserException msg) {
			assertTrue(true)
		}

		try {
			moreThan8HoursAssignment.validate
		} catch (UserException msg) {
			assertTrue(true)
		}
	}
}
