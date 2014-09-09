package DomainTest 

import org.junit.Before
import org.junit.Test
import static org.junit.Assert.*;
import org.joda.time.DateTime
import java.util.ArrayList
import Domain.Employee
import Domain.Planification
import Domain.Restriction
import Domain.Scheduler

class SchedulerTest {

	
	Scheduler scheduler
	Employee employeeA
	Employee employeeB
	Planification planificationA
	Planification planificationB
	DateTime dateA
	DateTime dateB
	Restriction restriction

	@Before
	def void init() {
		scheduler = Scheduler.getInstance()
		employeeA = new Employee("Lobito", " ", "24556")
		employeeB = new Employee("Sarasa", " ", "22000")
		dateA = new DateTime("2014-04-08")
		dateB = new DateTime("2014-04-09")
		restriction = new Restriction(employeeA,new DateTime("2014-6-01"))
		planificationA = new Planification(dateA)
		planificationB = new Planification(dateB)
	}

	@Test
	def void addEmployeeTest() {
		scheduler.addEmployee(employeeA)

		assertTrue(scheduler.employees.contains(employeeA))
		scheduler.removeEmployee(employeeA)
	}

	@Test
	def void removeEmployeeTest() {
		scheduler.addEmployee(employeeA)
		scheduler.addEmployee(employeeB)
		assertEquals(scheduler.employees.length, 2)

		scheduler.removeEmployee(employeeA)
		assertEquals(scheduler.employees.length, 1)
		assertFalse(scheduler.employees.contains(employeeA))
		assertEquals(scheduler.employees.get(0), employeeB)
	}

	@Test
	def void addPlanificationTest() {
		scheduler.addPlanification(planificationA)
		scheduler.addPlanification(planificationB)
		
		assertEquals(scheduler.planifications.length, 2)
		assertEquals(scheduler.planifications.get(0), planificationA)
		assertEquals(scheduler.planifications.get(1).day, dateB)	
		scheduler.removePlanification(planificationA)
		scheduler.removePlanification(planificationB)	
	}
	
	@Test
	def void removePlanificationTest() {
		scheduler.addPlanification(planificationA)
		scheduler.addPlanification(planificationB)
		assertEquals(scheduler.planifications.length, 2)
		
		scheduler.removePlanification(planificationB)
		assertEquals(scheduler.planifications.length, 1)
		assertEquals(scheduler.planifications.get(0).day, dateA)
	}
	
	@Test
	def void seeRestrictions(){
		var listRestrictions = new ArrayList<Restriction>
		listRestrictions.add(restriction)
		employeeA.addRestriction(restriction)
		scheduler.addEmployee(employeeA)
		
		assertEquals(scheduler.seeRestrictions,listRestrictions)
	}
}
