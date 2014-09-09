package Availability 

import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import ApplicationsModels.AddAvailability
import org.uqbar.arena.bindings.NotNullObservable

class CreateAvailabilityWindow extends Dialog<AddAvailability> {
	
	new(WindowOwner parent, AddAvailability model) {
		super(parent, model)
	}
	
	override def createMainTemplate(Panel mainPanel) {
		title = "Agregar disponibilidad"
		taskDescription = "Ingrese los parámetros de búsqueda"

		super.createMainTemplate(mainPanel)
	}
	
	override protected void addActions(Panel actionsPanel) {

		var aceptButton = new Button(actionsPanel)
			aceptButton.setCaption("Aceptar")
			aceptButton.onClick [ | modelObject.availability.validate
						 			modelObject.addAvailability 
									this.accept
			] 
			aceptButton.disableOnError
			aceptButton.bindEnabled(new NotNullObservable("availability.dayOfWeek"))
			
		new Button(actionsPanel)
			.setCaption("Cancelar")
			.onClick [ | this.cancel ] 
			.setAsDefault
	}
	
	override protected createFormPanel(Panel mainPanel) {
		var datesInputs = new Panel(mainPanel)
		datesInputs.setLayout(new ColumnLayout(2))
		
		new Label(datesInputs)
			.text = "Desde"
			
		new TextBox(datesInputs)
			.setWidth(100)
			.bindValueToProperty("availability.from")
		
		new Label(datesInputs)
			.text = "Hasta"
			
		new TextBox(datesInputs)
			.setWidth(100)
			.bindValueToProperty("availability.to")
		
		
		new Label(datesInputs)
			.text = "Dias"
		
		
		var sel = new Selector(datesInputs)
			sel.setWidth(100)
			sel.bindItemsToProperty("days")
			sel.bindValueToProperty("availability.dayOfWeek")
	}
}
