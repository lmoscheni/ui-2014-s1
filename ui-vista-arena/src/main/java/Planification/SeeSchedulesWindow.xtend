package Planification

import ApplicationsModels.SeeSchedules
import Domain.Assignment
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class SeeSchedulesWindow extends Dialog<SeeSchedules> {

	new(WindowOwner owner, SeeSchedules model) {
		super(owner, model)
		taskDescription = "Ver horarios de planificación"
	}

	override protected createFormPanel(Panel mainPanel) {

		var Table<Assignment> assignmentsTable = new Table<Assignment>(mainPanel, typeof(Assignment))
		assignmentsTable.bindItemsToProperty("assignments")
		assignmentsTable.bindValueToProperty("selected")
		assignmentsTable.setHeigth(400)

		new Column<Assignment>(assignmentsTable)
			.setTitle("Empleado")
			.setFixedSize(300)
			.bindContentsToProperty("employee") 

		new Column<Assignment>(assignmentsTable)
			.setTitle("Entrada")
			.setFixedSize(150)
			.bindContentsToProperty("start")
			
		new Column<Assignment>(assignmentsTable)
			.setTitle("Salida")
			.setFixedSize(150)
			.bindContentsToProperty("end")
	}
}
