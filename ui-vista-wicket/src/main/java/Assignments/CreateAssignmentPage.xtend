package Assignments

import ApplicationsModels.CreateAndEditEmployee
import ApplicationsModels.CreateAssignment
import java.io.Serializable
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.DropDownChoice
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.panel.FeedbackPanel
import org.apache.wicket.model.CompoundPropertyModel
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XForm
import org.uqbar.wicket.xtend.XListView
import BasePageAndWicketApplication.BasePage

/**
 * 
 * @authors Skalic julian, Leandro Moscheni, Damian Cravacuore
 * 
 */

class CreateAssignmentPage extends BasePage implements Serializable{

	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	var CreateAssignment appModel
	var SeeAssignmentsPage parentPage
	
	new(SeeAssignmentsPage parentPage, CreateAssignment appModel){
		this.parentPage = parentPage
		this.appModel = appModel

		//Create form with needed appModel
		val assignmentsForm = new XForm<CreateAssignment>("assignmentsForm", new CompoundPropertyModel(this.appModel))
		
		//Add form components
		this.addGrilInputs(assignmentsForm)
		this.addActions(assignmentsForm)
		this.addGridResult(assignmentsForm)
		
		//Add form
		addChild(assignmentsForm)
	}
	
	def addGrilInputs(Form<CreateAssignment> parent){
		parent.addChild(new Label("planification.viewDate"))
		parent.addChild(new DropDownChoice<Integer>("assignment.start") => [
			choices = loadableModel([| this.appModel.hours ])
		])
		parent.addChild(new DropDownChoice<Integer>("assignment.end") => [
			choices = loadableModel([| this.appModel.hours ])
		])  
		parent.addChild(new XButton("buscar").onClick = [| this.appModel.search])
		parent.addChild(new FeedbackPanel("feedbackPanel"))
	}
	
	def addGridResult(Form<CreateAssignment> parent){
		val listView = new XListView("employees")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("toString"))
			this.appModel.employee = item.modelObject
			item.addChild(new Label("label",this.appModel.stateOfEmployee))
			item.addChild(new XButton("asignar") => [
			onClick = [|
				this.appModel.assignment.validate
				this.appModel.assignment.employee = item.modelObject
				this.appModel.addAssignment
				returnPage()
			]				
		])
			
		]
		parent.addChild(listView)
	}
	
	def addActions(Form<CreateAssignment> parent){
		parent.addChild(new XButton("cancelar").onClick = [| returnPage ])
	}
	
	def returnPage() {
		responsePage = parentPage
	}
}