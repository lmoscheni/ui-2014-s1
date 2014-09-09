package Employees

import ApplicationsModels.AddAvailability
import ApplicationsModels.CreateAndEditEmployee
import Availabilitys.CreateAvailabilityPage
import BasePageAndWicketApplication.BasePage
import Domain.Availability
import java.util.ArrayList
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.form.TextField
import org.apache.wicket.markup.html.panel.FeedbackPanel
import org.apache.wicket.model.CompoundPropertyModel
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XForm
import org.uqbar.wicket.xtend.XListView

/**
 * 
 * @authors Skalic julian, Leandro Moscheni, Damian Cravacuore
 * 
 */

class CreateAndEditEmployeePage extends BasePage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	EmployeesPanel parentPage
	@Property CreateAndEditEmployee createAndEditEmployee
	AddAvailability appModelToResposePage
	var MapEmployeeAvailabilities mapAddAvailabilities
	var MapEmployeeAvailabilities mapRemoveAvailabilities
	
	new(EmployeesPanel parentPage, CreateAndEditEmployee appModel){
		this.parentPage = parentPage
		this.createAndEditEmployee = appModel
		this.mapAddAvailabilities = new MapEmployeeAvailabilities
		this.mapRemoveAvailabilities = new MapEmployeeAvailabilities
		this.mapAddAvailabilities.setEmployee(this.createAndEditEmployee.employee)
		this.mapRemoveAvailabilities.setEmployee(this.createAndEditEmployee.employee)
		//Sets title for create or edit employee accordingly
		this.addChild(new Label("titulo", if (this.createAndEditEmployee.create) "Nuevo Empleado" else "Editar Datos del Empleado"))
		
		//Create form with needed appModel
		val employeeForm = new XForm<CreateAndEditEmployee>("employeeForm", new CompoundPropertyModel(this.createAndEditEmployee))
		
		//Add form components
		this.addAvailabilityGrid(employeeForm)
		this.addGrilInputs(employeeForm)
		this.addActions(employeeForm)
		
		//Add form
		addChild(employeeForm)
	}
	
	//Muestra la lista de disponibilidad, y la accion de agregar o editar cada uno de los mismos.
	def addAvailabilityGrid(Form<CreateAndEditEmployee> parent) {
		val listView = new XListView("employee.availabilitys")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("dayOfWeek"))
			item.addChild(new Label("from"))
			item.addChild(new Label("to"))
			item.addChild(new XButton("Eliminar")
			.onClick = [| 	this.mapRemoveAvailabilities.addAvailability(item.modelObject)
							this.createAndEditEmployee.deleteAvailabilityToEmployee(item.modelObject)
			]
			)
		]
		parent.addChild(listView)
	}
	
	def addGrilInputs(Form<CreateAndEditEmployee> parent){
		parent.addChild(new TextField<String>("employee.name"))
		parent.addChild(new TextField<String>("employee.surname")) 
		parent.addChild(new TextField<String>("employee.file")) 
		parent.addChild(new FeedbackPanel("feedbackPanel"))
	}
	
	def addActions(Form<CreateAndEditEmployee> parent){
		parent.addChild(new XButton("Agregar").onClick = [| createAvailabilityResponsePage ])
		parent.addChild(new XButton("aceptar") => [
			onClick = [|
				this.createAndEditEmployee.employee.validate()
				this.createAndEditEmployee.saveChanges
				returnPage()
			]				
		])
		parent.addChild(new XButton("cancelar").onClick = [| onCancel	])
	}
	
	def onCancel(){
		returnToFirstVersion
		returnPage
	}
	
	def returnToFirstVersion(){
		if(!this.createAndEditEmployee.create && (this.appModelToResposePage != null)){
			if(!(this.mapAddAvailabilities.availabilities == null)){
				this.mapAddAvailabilities.availabilities.forEach[ a | this.mapAddAvailabilities.employee.removeAvailability(a)]
			}
		}
		if(!(this.mapRemoveAvailabilities.availabilities == null)){
				this.mapRemoveAvailabilities.availabilities.forEach[ a | this.mapRemoveAvailabilities.employee.addAvailability(a)]
		}
		
	}
	
	def createAvailabilityResponsePage(){
		this.appModelToResposePage = new AddAvailability(this.createAndEditEmployee.employee)
		this.mapAddAvailabilities.addAvailability(this.appModelToResposePage.availability)
		responsePage = new CreateAvailabilityPage(this,this.appModelToResposePage)
	}
	
	def returnPage() {
		parentPage.searchEmployees
		responsePage = parentPage
	}
}