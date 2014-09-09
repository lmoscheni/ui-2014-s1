package Planification

import Domain.Employee
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import ApplicationsModels.CreateAssignment

class CreateAssignmentWindow extends Dialog<CreateAssignment> {

	new(WindowOwner parent, CreateAssignment model) {
		super(parent, model)
		this.setTitle("Crear Asignación")
	}
	
	override protected addActions(Panel actions) {
		new Button(actions)
			.setCaption("Asignar")
			.onClick [| modelObject.assignment.validate
						modelObject.addAssignment
						this.accept
			]
			.setAsDefault
			.disableOnError

		new Button(actions) //
			.setCaption("Cancelar")
			.onClick [ | this.cancel ]
	}
	
	override protected createFormPanel(Panel mainPanel) {
		var labels = new Panel(mainPanel)
		labels.setLayout(new ColumnLayout(2))
		new Label(labels).setText("Agregar una asignación para el ")
		new Label(labels).setText(modelObject.planification.viewDate)

		var datesSearch = new Panel(mainPanel)
		datesSearch.setLayout(new ColumnLayout(5))

		new Label(datesSearch)
			.text = "Desde"
		var fromHourSel = new Selector(datesSearch)
			fromHourSel.setWidth(100)
			fromHourSel.bindItemsToProperty("hours")
			fromHourSel.bindValueToProperty("assignment.start")

		new Label(datesSearch)
			.text = "Hasta"
		var toHourSel = new Selector(datesSearch)
			toHourSel.setWidth(100)
			toHourSel.bindItemsToProperty("hours")
			toHourSel.bindValueToProperty("assignment.end")
			
		new Button(datesSearch)
			.setCaption("Buscar")
			.onClick[ | modelObject.search ] 

		new Label(labels)
			.setText("Empleados")
			
		var Table<Employee> employeesTable = new Table<Employee>(mainPanel, typeof(Employee))
			employeesTable.bindItemsToProperty("employees")
			employeesTable.bindValueToProperty("assignment.employee")
			employeesTable.setHeigth(400)
		
		new Column<Employee>(employeesTable) 
			.setTitle("Nombre") 
			.setFixedSize(300) 
			.bindContentsToProperty("name")
			
		new Column<Employee>(employeesTable) 
			.setTitle("Disponible") 
			.setFixedSize(350) 
			.bindContentsToTransformer(
				[ employee |
					if(employee.hasRestriction(modelObject.planification.day)) {
						"No-Tiene restriccion"
					} else { if(modelObject.planification.isAssigned(employee)) {
				 				"No-Ya esta asignado"
				 			}else{ if(employee.isAvailabilityToDay(modelObject.planification.day,modelObject.assignment.start,modelObject.assignment.end)) {
				 			          "Si"
				 		          }else {"No"}
			        }
			        
			   }
				]
			)
		
	}


}
