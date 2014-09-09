package Main import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.windows.SimpleWindow
import Domain.Scheduler
//import ApplicationsModels.EmployeesAppModel
import ApplicationsModels.SeeRestrictions
import java.awt.Color
import ApplicationsModels.SeePlanifications
import Employee.SeeEmployeesWindow
import Restriction.RestrictionsWindow
import Planification.SeeWeekPlanificationWindow
import ApplicationsModels.SeeEmployees

class SchedulerWindow extends SimpleWindow<Scheduler> {
	
	new(WindowOwner owner, Scheduler model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
			this.setTitle("Planificador de Horarios")
		mainPanel.setLayout(new HorizontalLayout)
		
		new Button(mainPanel) => [
			caption = "Ver Empleados"
			setForeground(Color::BLUE)
			onClick [ | new SeeEmployeesWindow(this, new SeeEmployees).open ]
		]
		
		
		new Button(mainPanel) => [
			caption = "Ver Planificaciones"
			setForeground(Color::GREEN)
			onClick [ | modelObject.weekPlanification
						new SeeWeekPlanificationWindow(this, new SeePlanifications ( ) ).open
			]
		]
		
		new Button(mainPanel) => [
			caption = "Ver Restricciones"
			setForeground(Color::RED)
			onClick [ | new RestrictionsWindow(this,new SeeRestrictions ( ) ).open]
		]
	}
	
	override protected addActions(Panel actionsPanel) {
	
	}
	
}