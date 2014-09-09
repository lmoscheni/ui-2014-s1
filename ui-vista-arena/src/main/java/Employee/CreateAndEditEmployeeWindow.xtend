package Employee

import ApplicationsModels.AddAvailability
//import ApplicationsModels.EmployeesAppModel
import Availability.CreateAvailabilityWindow
import Domain.Availability
import com.uqbar.commons.StringUtils
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import ApplicationsModels.CreateAndEditEmployee

class CreateAndEditEmployeeWindow extends Dialog<CreateAndEditEmployee>{
	
	new(WindowOwner owner, CreateAndEditEmployee model) {
		super(owner, model)
		this.setTitle("Editar empleado")
		taskDescription = "Empleado"
	}
	
	override protected addActions(Panel actions) {
		
		new Button(actions)
			.setCaption("Aceptar")
			.onClick [| modelObject.employee.validate
						modelObject.saveChanges
						this.accept
			]
			.setAsDefault.disableOnError

		new Button(actions)
			.setCaption("Cancelar")
			.onClick [ | this.cancel ]
	}
	
	def panelButtonsAvailability(Panel mainPanel){
		
		var panelButtonsAvailability = new Panel(mainPanel)
		panelButtonsAvailability.setLayout(new ColumnLayout(3))
		
		new Button(panelButtonsAvailability) 
			.setCaption("Agregar")
			.onClick [| 	var createAvailabilityW = new CreateAvailabilityWindow(this, new AddAvailability(modelObject.employee))
						    createAvailabilityW.onAccept[ | modelObject.update ]
						    createAvailabilityW.open
			]
			
		var deleteButton = new Button(panelButtonsAvailability) 
			.setCaption("Eliminar")
			.onClick [| modelObject.deleteAvailabilityToEmployee]
			
		var elementSelected = new NotNullObservable("selectedAvailability")
		deleteButton.bindEnabled(elementSelected)	
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		mainPanel.setLayout(new ColumnLayout(2))
		new Label(mainPanel)
			.text = ("")
		
		new Label(mainPanel)
			.text = ("Nombre")
			
		new TextBox(mainPanel)
			.withFilter [ event | StringUtils::isAlpha(event.potentialTextResult) ]
			.setWidth(100)
			.bindValueToProperty("employee.name")
			
		new Label(mainPanel)
			.text = ("Apellido")
		
		new TextBox(mainPanel)
			.withFilter [ event | StringUtils::isAlpha(event.potentialTextResult) ]
			.setWidth(100)
			.bindValueToProperty("employee.surname")
			
		new Label(mainPanel)
			.text = ("Legajo")	
			
		new TextBox(mainPanel)
			.withFilter [ event | StringUtils::isNumeric(event.potentialTextResult) ]
			.setWidth(100)
			.bindValueToProperty("employee.file")
			
		new Label(mainPanel)
			.text = ("Disponibilidad:")	
		
		var Table<Availability> tablaResultados = new Table<Availability>(mainPanel, typeof(Availability))
		tablaResultados.bindItemsToProperty("employee.availabilitys")
		tablaResultados.bindValueToProperty("selectedAvailability")
		tablaResultados.setHeigth(200)
		
		new Column<Availability>(tablaResultados) 
			.setTitle("Dia") 
			.setFixedSize(150) 
			.bindContentsToProperty("dayOfWeek")
		
		new Column<Availability>(tablaResultados) 
			.setTitle("Desde") 
			.setFixedSize(150) 
			.bindContentsToProperty("from")
			
		new Column<Availability>(tablaResultados) 
			.setTitle("Hasta") 
			.setFixedSize(150) 
			.bindContentsToProperty("to")
		
		new Label(mainPanel)
			.text = ("")
			
		this.panelButtonsAvailability(mainPanel)
			
		
	}
	
}