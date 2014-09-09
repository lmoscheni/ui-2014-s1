package DomainTest

import org.junit.Before
import Domain.Availability
import org.junit.Test
import org.uqbar.commons.model.UserException
import static org.junit.Assert.*;

class AvailabilityTest {
	
	@Property Availability availability
	
	@Before
	def void init(){
		 availability = new Availability
	}
	
	@Test
	def void setFromTest(){
		try{
			availability.setFrom(-1)
			assertTrue(false)
		}catch(UserException msg){
			assertTrue(true)
		}
	}
	
	@Test
	def void setToTest(){
		try{
			availability.setTo(25)
			assertTrue(false)
		}catch(UserException msg){
			assertTrue(true)
		}
	}
	
	@Test
	def void availableInThePeriodTest(){
		availability.from = 10
		availability.to = 16
		
		assertTrue(availability.availableInThePeriod(12,14))
		assertFalse(availability.availableInThePeriod(8,14))
	}
	
	@Test
	def void validateTest(){
		try{
			availability.setFrom(2)
			availability.setTo(0)
			availability.validate
			assertTrue(false)
		}catch(UserException msg){
			assertTrue(true)
		}
		
		try{
			availability.setFrom(0)
			availability.setTo(2)
			availability.validate
			assertTrue(false)
		}catch(UserException msg){
			assertTrue(true)
		}
	}
}