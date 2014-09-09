package Planification

import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import ApplicationsModels.ShowAssignment
import org.uqbar.arena.widgets.Button
import Domain.Assignment
import org.uqbar.arena.widgets.Label
import ApplicationsModels.SeeAssignments
import ApplicationsModels.CreateAssignment

class SeeAssignmentsWindow extends Dialog<SeeAssignments> {

	new(WindowOwner owner, SeeAssignments model) {
		super(owner, model)
		taskDescription = "Asignaciones"
	}

	override protected createFormPanel(Panel mainPanel) {

		new Label(mainPanel).setText("Agregar una asignación para el ")
		new Label(mainPanel).setText(modelObject.planification.viewDate)
		
		var assignmentsTable = new Table<ShowAssignment>(mainPanel, typeof(ShowAssignment))
		assignmentsTable.bindItemsToProperty("assignments")
		assignmentsTable.bindValueToProperty("selectedShowAssignment")
		assignmentsTable.setHeigth(400)

		new Column<ShowAssignment>(assignmentsTable)
			.setTitle("Empleado")
			.setFixedSize(250)
			.bindContentsToProperty("employee")
		
		var i = 0
		
		while(i <= 23){
			new Column<ShowAssignment>(assignmentsTable)
			.setTitle(i.toString)
			.setFixedSize(40)
			.bindContentsToTransformer([ x | if(x.isAvailable) "X"])
		
			i= i + 1
		}
	}
	
	override protected addActions(Panel actionsPanel) {
		
		
		new Button(actionsPanel)
			.setCaption("Agregar Asignacion")
			.onClick [ | modelObject.setSelectedAssignment(new Assignment)
						 var dialog = new CreateAssignmentWindow(this, new CreateAssignment(modelObject.planification))
						 dialog.onAccept[ | modelObject.update ];
						 dialog.open
				  	     modelObject.selectedAssignment = null
					 ]
			
				
		new Button(actionsPanel)
			.setCaption("Quitar Asignacion")
			.onClick[| modelObject.deleteAssignment]
					
		new Button(actionsPanel)
			.setCaption("Aceptar")
			.onClick[| this.accept]
			
	}
}
