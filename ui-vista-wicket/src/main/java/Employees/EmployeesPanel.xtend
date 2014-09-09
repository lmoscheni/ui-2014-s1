package Employees

import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.model.CompoundPropertyModel
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XForm
import org.uqbar.wicket.xtend.XListView
import ApplicationsModels.SeeEmployees
import ApplicationsModels.CreateAndEditEmployee
import Domain.Employee
import BasePageAndWicketApplication.BasePage
import BasePageAndWicketApplication.HomePage

/**
 * 
 * @authors Skalic julian, Leandro Moscheni, Damian Cravacuore
 * 
 */

class EmployeesPanel extends BasePage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	HomePage homePage
	SeeEmployees listOfEmployees
	
	new(){
		this.listOfEmployees = new SeeEmployees
		this.homePage = new HomePage
		
		//Create form with needed appModel
		val employees = new XForm<SeeEmployees>("employeesForm", new CompoundPropertyModel(this.listOfEmployees))

		//Add form components
		this.addResultsGrid(employees)
		this.addActions(employees)
		
		//Add form
		addChild(employees)
	}
	
	//Muestra la lista de empleados, y la accion de editar cada uno de los mismos.
	def addResultsGrid(Form<SeeEmployees> parent) {
		val listView = new XListView("employees")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("name"))
			item.addChild(new Label("surname"))
			item.addChild(new Label("file"))
			item.addChild(new Label("availabilityDays"))
			item.addChild(new XButton("Editar")
			.onClick = [| responsePage = new CreateAndEditEmployeePage(this, new CreateAndEditEmployee(item.modelObject,false)) ]
			)
		]
		parent.addChild(listView)
	}
	
	//Crear: Va a otra pagina para crear un empleado, Volver: Retorna a la pagina proncipal.
	def addActions(Form<SeeEmployees> parent){
		val createButton = new XButton("Crear")
			createButton.onClick = [| responsePage = new CreateAndEditEmployeePage(this, new CreateAndEditEmployee(new Employee,true)) ]
			parent.addChild(createButton)
			
		parent.addChild(new XButton("Volver").onClick = [| responsePage = homePage ])
		
	}
	
	def searchEmployees(){
		this.listOfEmployees.search
	}
}