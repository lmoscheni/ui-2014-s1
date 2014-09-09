package Restriction 

import ApplicationsModels.SeeRestrictions
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.widgets.Panel
import Domain.Restriction
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.Button
import ApplicationsModels.AddRestriction
import org.uqbar.arena.bindings.NotNullObservable

class RestrictionsWindow extends Dialog<SeeRestrictions> {
	
	new(WindowOwner owner, SeeRestrictions model) {
		super(owner, model)
	}
	
	override def createMainTemplate(Panel mainPanel) {
		title = "Restricciones"

		super.createMainTemplate(mainPanel)
	}
	
	override protected createFormPanel(Panel mainPanel) {
		var Table<Restriction> restrictionTable = new Table<Restriction>(mainPanel, typeof(Restriction));
		restrictionTable.bindContentsToProperty("scheduler.seeRestrictions")
		restrictionTable.bindValueToProperty("selectedRestriction")
		restrictionTable.setHeigth(200)
		restrictionTable.setWidth(400)
		
		new Column<Restriction>(restrictionTable) 
			.setTitle("Empleado") 
			.setFixedSize(150) 
			.bindContentsToProperty("employee")
		
		var colum =new Column<Restriction>(restrictionTable) 
			colum.setTitle("Fecha")
			colum.setFixedSize(150)
			colum.bindContentsToTransformer([r | r.viewDate])
	}
	
	override protected void addActions(Panel actions) {
		new Button(actions)
			.setCaption("Agregar")
			.onClick [| var resWin = new CreateRestrictionWindow(this,new AddRestriction)
							resWin.onAccept[ | modelObject.update]
							resWin.open
			]
			.setAsDefault.disableOnError

		var buttonDelete = new Button(actions) 
			buttonDelete.setCaption("Eliminar")
			buttonDelete.onClick [ | modelObject.delete
									 modelObject.update
			]
		
		buttonDelete.disableOnError
		buttonDelete.bindEnabled(new NotNullObservable("selectedRestriction"))
	}
	
}