package Planification


import Domain.Planification
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import ApplicationsModels.SeeSchedules
import ApplicationsModels.SeePlanifications
import ApplicationsModels.SeeAssignments

class SeeWeekPlanificationWindow extends SimpleWindow<SeePlanifications>{
	new(WindowOwner owner, SeePlanifications model) {
		super(owner, model)
	}
	
	override def createMainTemplate(Panel mainPanel) {
		title = "Planificaciones de la Semana"
		taskDescription = ""
		super.createMainTemplate(mainPanel)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		var Table<Planification> planificationsTable = new Table<Planification>(mainPanel, typeof(Planification))
		planificationsTable.bindItemsToProperty("scheduler.planifications")
		planificationsTable.bindValueToProperty("selectedPlanning")
		planificationsTable.setHeigth(400)
		
		new Column<Planification>(planificationsTable) 
			.setTitle("Day") 
			.setFixedSize(300) 
			.bindContentsToTransformer([p | p.viewDate])
			
		new Column<Planification>(planificationsTable) 
			.setTitle("State") 
			.setFixedSize(350) 
			.bindContentsToProperty("statePlanification")
	}
	
	override protected addActions(Panel actionsPanel) {
		
		new Button(actionsPanel)
			.setCaption("Planificar")
			.onClick [ 	| 
							modelObject.selectedPlanning.isBeforeToday 
							var assignmentWindow = new SeeAssignmentsWindow(this,new SeeAssignments(modelObject.selectedPlanning))	
							assignmentWindow.onAccept[ |modelObject.confirmSelectedPlanning 
														modelObject.update
						]
						assignmentWindow.open
			]
			.disableOnError
			.bindEnabledToProperty("puedePlanificar")
				
		new Button(actionsPanel)
			.setCaption("Ver Horarios")
			.onClick [ | new SeeSchedulesWindow(this,new SeeSchedules(modelObject.selectedPlanning)).open
			]

	}
	
}