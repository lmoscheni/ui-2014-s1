package DomainTest

import Domain.Employee
import Domain.Restriction
import org.joda.time.DateTime
import org.junit.Before
import org.junit.Test
import org.uqbar.commons.model.UserException

import static org.junit.Assert.*

class RestrictionTest {

	Restriction restriction
	Employee employee
	DateTime date

	@Before
	def void init() {
		restriction = new Restriction()
		employee = new Employee("Jose", "Sarlanga", "24666")
		date = new DateTime("2013-04-08")
	}

	@Test
	def void nameEmployeeTest() {
		restriction.setEmployee(employee)

		assertEquals(restriction.nameEmployee(), "Jose Sarlanga")
	}

	@Test
	def void validate() {
		restriction.setDate(date)

		try {
			restriction.validate
		} catch (UserException msg) {
			assertTrue(true)
		}
	}
}
