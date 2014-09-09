package DomainTest 

import org.junit.Before
import org.joda.time.DateTime
import org.junit.Test
import static org.junit.Assert.*;
import Exceptions.RepeatedRestrictionException
import Domain.Employee
import Domain.Availability
import Domain.Restriction
import org.uqbar.commons.model.UserException
import java.util.ArrayList

class EmployeeTest {
	
	Employee employee1
	Employee employee2
	Employee employee3
	Restriction restriction1
	Restriction restriction2
	Availability availability
	Availability availability2
	
	@Before
	def void init(){
		employee1 = new Employee("Julian", "Skalic", "20514")
		employee2 = new Employee("Micaela", "Pesci", "20516")
		employee3 = new Employee
		restriction1 = new Restriction (employee1,new DateTime("2014-03-28"))
		restriction2 = new Restriction(employee1,new DateTime("2014-04-28"))
		availability = new Availability(new DateTime("2014-04-21"),10,18)
		availability2 = new Availability(new DateTime("2014-04-23"),10,18) 
	}
	
	@Test
	def void addRestrictionTest(){
		employee1.addRestriction(restriction1)
		
		assertEquals(employee1.restrictions.length, 1)
		assertTrue(restriction1.equals(employee1.restrictions.get(0)))
	}
	
	@Test
	def void removeRestrictionTest(){
		employee1.addRestriction(restriction1)
		employee1.addRestriction(restriction2)
		assertEquals(employee1.restrictions.length, 2)
		
		employee1.removeRestriction(restriction1)
		assertEquals(employee1.restrictions.length, 1)
		assertFalse(employee1.restrictions.contains(restriction1))
	}
	
	@Test
	def void addAvailabilityTest(){
		employee1.addAvailability(availability)
		
		assertEquals(employee1.availabilitys.length, 1)
		assertTrue(availability.equals(employee1.availabilitys.get(0)))
	}
	
	@Test
	def void removeAvailabilityTest(){
		employee1.addAvailability(availability)
		assertEquals(employee1.availabilitys.length, 1)
		
		employee1.removeAvailability(availability)
		assertEquals(employee1.availabilitys.length, 0)
		assertFalse(employee1.availabilitys.contains(availability))
	}
	
	@Test
	def void addRepeatedRestrictionTest(){
		try{
			var res = new Restriction (employee1,new DateTime("2014-03-28"))
			employee1.addRestriction(restriction1)
			employee1.addRestriction(res)	
		}catch(RepeatedRestrictionException msg){
			assertEquals(employee1.restrictions.length, 1)
			assertTrue(true)
		}
	}
	
	@Test
	def void addRepeatedAvailabilityTest(){
		try{
			employee1.addAvailability(availability)
			employee1.addAvailability(availability)	
			assertTrue(false)
		}catch(UserException msg){
			assertEquals(employee1.availabilitys.length, 1)
			assertTrue(true)
		}
	}
	
	@Test
	def void validateEmployeeTest(){
		try{
				employee3.validate
				assertTrue(false)
		}catch(UserException msg){
			assertTrue(true)
		}
		
		try{
			employee3.setName("Julian")	
			employee3.validate
			assertTrue(false)
		}catch(UserException msg){
			assertTrue(true)
		}
		
		try{
			employee3.setSurname("Skalic")	
			employee3.validate
			assertTrue(false)
		}catch(UserException msg){
			assertTrue(true)
		}
		
		try{
			employee3.setFile("4558")	
			employee3.validate
			assertTrue(false)
		}catch(UserException msg){
			assertTrue(true)
		}
		
		try{
			var list = new ArrayList<Availability>()
			list.add(new Availability)
			employee3.setAvailabilitys(list)	
			employee3.validate
			assertTrue(true)
		}catch(UserException msg){
			assertTrue(false)
		}
	}
	
	@Test
	def void toStringTest(){
		var string =employee1.toString
		assertEquals(string, "Julian Skalic")
	}
}


