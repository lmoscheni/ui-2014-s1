package AppModelsTest

import org.junit.Test
import Domain.Employee
import org.junit.Before
import ApplicationsModels.CreateAndEditEmployee
import static org.junit.Assert.*

class CreateAndEditEmployeeTest {
	
	var Employee newEmployee
	var Employee existEmployee
	var CreateAndEditEmployee appModel
	
	@Before
	def init(){
		val Employee newEmployee = new Employee()
		val Employee existEmployee = new Employee("Pepe","Argento","1")
	}
	
	/*
	 * CREATE EMPLOYEE TEST's
	 */
	 
	 @Test
	 def AddEmployeeTest(){
	 	//this.appModel = new CreateAndEditEmployee(this.newEmployee)
	 	this.appModel.addEmployee()
	 	//assertEquals(this.)
	 }
	 
	 @Test
	 def deleteAvailabilityToNewEmployeeTest(){
	 	
	 }
	 
	 
	 /*
	  * EDIT EMPLOYEE TEST's
	  */
	 
	 @Test
	 def deleteAvailabilityToExistEmplyoeeTest(){
	 	
	 }
}