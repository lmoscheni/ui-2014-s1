package Employee import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
//import ApplicationsModels.EmployeesAppModel
import Domain.Employee
import org.uqbar.arena.bindings.NotNullObservable
import ApplicationsModels.SeeEmployees
import ApplicationsModels.CreateAndEditEmployee

class SeeEmployeesWindow extends SimpleWindow<SeeEmployees>{
	
	new(WindowOwner owner, SeeEmployees model) {
		super(owner, model)
	}
	
	override def createMainTemplate(Panel mainPanel) {
		title = "Ver Empleados"
		taskDescription = "Ver empleados"
		super.createMainTemplate(mainPanel)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		var Table<Employee> tablaResultados = new Table<Employee>(mainPanel, typeof(Employee))
		tablaResultados.bindItemsToProperty("employees")
		tablaResultados.bindValueToProperty("selected")
		tablaResultados.setHeigth(400)
		
		new Column<Employee>(tablaResultados) 
			.setTitle("Nombre") 
			.setFixedSize(150) 
			.bindContentsToProperty("name")
			
		new Column<Employee>(tablaResultados) 
			.setTitle("Apellido") 
			.setFixedSize(150) 
			.bindContentsToProperty("surname")
		
		new Column<Employee>(tablaResultados) 
			.setTitle("Legajo") 
			.setFixedSize(150) 
			.bindContentsToProperty("file")
			
		new Column<Employee>(tablaResultados) 
			.setTitle("Dias disponibles") 
			.setFixedSize(150)
			.bindContentsToProperty("availabilityDays")
			
	}
	
	override protected addActions(Panel actionsPanel) {
		
		
		new Button(actionsPanel)
			.setCaption("Crear")
			.onClick [ | var dialog = new CreateAndEditEmployeeWindow(this, new CreateAndEditEmployee(new Employee,true))
						 dialog.onAccept[|modelObject.update];
						 dialog.open
			]
				
		var editButton = new Button(actionsPanel)
			.setCaption("Editar")
			.onClick [ | var dialog  = new CreateAndEditEmployeeWindow(this, new CreateAndEditEmployee(modelObject.selected,false))
						 	 dialog.onAccept[|modelObject.update];
						     dialog.open
			]
		
		var elementSelected = new NotNullObservable("selected")
		editButton.bindEnabled(elementSelected)	
	}
	
}