package Domain

import java.io.Serializable
import java.util.ArrayList
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable

@Observable 
class Scheduler implements Serializable{
	@Property val employees = new ArrayList<Employee>()
	@Property val  planifications = new ArrayList<Planification>()
	private val static instance = new Scheduler()
	
	new(){
		weekPlanification;
		val e1 = new Employee("Julian","Skalic", "1225");
		val e2 = new Employee("Gaston","LALA", "1226");
		val a1 = new Availability(new DateTime(), 8, 19);
		val a2 = new Availability(new DateTime(), 8, 19);
		this.addEmployee(e1)
		this.addEmployee(e2)
		a1.setDayOfWeek("domingo");
		a2.setDayOfWeek("sabado");
		e1.addAvailability(a1);
		e1.addAvailability(a2);
		e2.addAvailability(a1);
		e2.addAvailability(a2);
		planifications.forEach[planification | 	planification.addEmployeeToPlanificationForTheDay(e1,9,18);
												//planification.addEmployeeToPlanificationForTheDay(e2,9,18);
		]
	}
	
	def static Scheduler getInstance(){
		return instance
	}
	
	def weekPlanification(){
		val hoy = new DateTime()
		if(!planifications.exists[ p | this.sonElMismoDia(hoy,p.day)]){
			generarDiasHaciaAtras()
			_planifications.add(new Planification(new DateTime))
			generarDiasHaciaAdelante()
		}
	}
	
	private def generarDiasHaciaAtras(){
		var hoy = new DateTime
		var diasAtras = hoy.getDayOfWeek - 1
		while(diasAtras > 0){
			_planifications.add(new Planification(hoy.minusDays(diasAtras)))
			diasAtras = diasAtras - 1
		}
	}
	
	private def generarDiasHaciaAdelante(){
		var hoy = new DateTime
		var cont = 1  
		var diasAdelante = 7 - hoy.getDayOfWeek  
		while(cont <= diasAdelante){
			_planifications.add(new Planification(hoy.plusDays(cont)))
			cont = cont + 1
		}
	}
	
	private def tienenElMismoAño(DateTime d1,DateTime d2){
		d1.year().equals(d2.year())
	}

	private def tienenElMismoMes(DateTime d1, DateTime d2){
		d1.monthOfYear().equals(d2.monthOfYear())
	}
	
	private def tienenElMismoDia(DateTime d1, DateTime d2){
		d1.dayOfMonth().equals(d2.dayOfMonth())
	}
	
	private def sonElMismoDia(DateTime d1, DateTime d2){
	  (this.tienenElMismoAño(d1, d2) && this.tienenElMismoMes(d1, d2) && this.tienenElMismoDia(d1, d2))
	}
	
	def addEmployee(Employee anEmployee){
		_employees.add(anEmployee)
	}
	
	def removeEmployee(Employee anEmployee){
		this.getEmployees.remove(anEmployee)
	}
	
	def addPlanification(Planification anPlanification){
		this.getPlanifications.add(anPlanification)
	}
	
	def removePlanification(Planification anPlanification){
		this.getPlanifications.remove(anPlanification)
	}
	
	def seeRestrictions(){ // ahora como existen las restricciones tenemos que generar una lista de restricciones
		val restrictions = new ArrayList<Restriction>()
		this.getEmployees.forEach[employee | restrictions.addAll(employee.getRestrictions)]
		return restrictions
	}
	
	def seeWeekPlanifications(){ // we must define this for showing weekly planifications list (from monday to sunday)
		//TODO
	}
}