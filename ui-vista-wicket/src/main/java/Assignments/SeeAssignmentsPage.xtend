package Assignments

import ApplicationsModels.CreateAndEditEmployee
import ApplicationsModels.CreateAssignment
import ApplicationsModels.SeeAssignments
import ApplicationsModels.ShowAssignment
import BasePageAndWicketApplication.BasePage
import Employees.CreateAndEditEmployeePage
import Planifications.PlanificationsPanel
import java.util.ArrayList
import org.apache.wicket.extensions.markup.html.repeater.data.grid.DataGridView
import org.apache.wicket.extensions.markup.html.repeater.data.table.PropertyColumn
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.panel.FeedbackPanel
import org.apache.wicket.markup.repeater.data.ListDataProvider
import org.apache.wicket.model.CompoundPropertyModel
import org.apache.wicket.model.Model
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XForm
import org.uqbar.wicket.xtend.XListView

/**
 * 
 * @authors Skalic julian, Leandro Moscheni, Damian Cravacuore
 * 
 */

class SeeAssignmentsPage extends BasePage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	
	PlanificationsPanel parentPage
	SeeAssignments seeAssignmentsAppModel
	
	new(PlanificationsPanel parentPage, SeeAssignments appModel){
		this.parentPage = parentPage
		this.seeAssignmentsAppModel = appModel
		
		//Create form with needed appModel
		val assignmentsForm = new XForm<SeeAssignments>("assignmentsForm", new CompoundPropertyModel(this.seeAssignmentsAppModel))

		//Add form components
		this.addAssignmentsGrid(assignmentsForm)
		this.addActions(assignmentsForm)

		//Add form
		addChild(assignmentsForm)
	}

	def addAssignmentsGrid(Form<SeeAssignments> parent) {
		
		val listView = new XListView("assignments")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("employee.toString"))
			var i = 0
			while(i < 25){
				item.addChild(new Label('''get«i»'''))
				i = i+1 
			}
			item.addChild(new XButton("Eliminar")
			.onClick = [| 	this.seeAssignmentsAppModel.selectedShowAssignment = item.modelObject
							this.seeAssignmentsAppModel.deleteAssignment	
						]
			)
		]
		parent.addChild(listView)
		
//		val columns = new ArrayList
//		columns.add(new PropertyColumn(new Model<String>,"Hola","employee.toString"))
//		var Integer i = 0
//        while(i <= 23){
//			columns.add(new PropertyColumn(new Model<String>,"isAvailableDescription"))
//			i =i + 1
//		}
//        parent.addChild(new DataGridView<ShowAssignment>("assignments", columns, this.assigmentsPopulator))
//        
        
	}
	
	def assigmentsPopulator() {
		this.seeAssignmentsAppModel.assigmentsDataProvider
	}
	
	def getAssigmentsDataProvider(SeeAssignments assignments) {
		new ListDataProvider<ShowAssignment>(assignments.assignments)
	}
	
	def addActions(Form<SeeAssignments> parent){
		parent.addChild(new FeedbackPanel("feedbackPanel"))
		parent.addChild(new XButton("Aceptar") => [
				onClick = [|
					seeAssignmentResponsePage
			]				
		])
		parent.addChild(new XButton("Volver").onClick = [| returnPage ])
		parent.addChild(new XButton("Agregar").onClick = [| createAssignmetnResponsePage ])
	}
	
	def seeAssignmentResponsePage(){
		this.seeAssignmentsAppModel.planification.confirmPlanification
		returnPage()
	}
	
	def createAssignmetnResponsePage(){
		responsePage = new CreateAssignmentPage(this,new CreateAssignment(this.seeAssignmentsAppModel.planification))
	}
	
	def returnPage() {
		this.parentPage.updateListOfPlanifications
		responsePage = parentPage
	}
}
