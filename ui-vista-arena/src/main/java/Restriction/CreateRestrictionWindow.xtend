package Restriction

import ApplicationsModels.AddRestriction
import Domain.Employee
import Transformers.DateTimeTransformer
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner

class CreateRestrictionWindow extends Dialog<AddRestriction> {
	
	new(WindowOwner owner, AddRestriction model) {
		super(owner, model)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		new Label(mainPanel).setText("Empleado")
		
		var selectionOfEmployee = new Selector<Employee>(mainPanel)
		selectionOfEmployee.bindItemsToProperty("scheduler.employees")
		
		selectionOfEmployee.bindValueToProperty("selected")

		var layoutPanel = new Panel(mainPanel)
		layoutPanel.setLayout(new ColumnLayout(2))
				
		new Label(layoutPanel).setText("Fecha")
		var date = new TextBox(layoutPanel)
		date.setWidth(150)
		var bindDate = date.bindValueToProperty("restriction.date")
		bindDate.transformer = new DateTimeTransformer
		
	}
	
	override protected void addActions(Panel actionsPanel) {

		new Button(actionsPanel)
			.setCaption("Aceptar")
			.onClick [ |  modelObject.addRestriction
						  this.accept
			] 
			.setAsDefault
			.disableOnError
			
		new Button(actionsPanel)
			.setCaption("Cancelar")
			.onClick [ | this.cancel ] 
			.setAsDefault
	}
	
}