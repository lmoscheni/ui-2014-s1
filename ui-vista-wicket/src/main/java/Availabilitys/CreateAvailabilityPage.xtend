package Availabilitys

import ApplicationsModels.AddAvailability
import org.apache.wicket.markup.html.form.DropDownChoice
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.form.TextField
import org.apache.wicket.markup.html.panel.FeedbackPanel
import org.apache.wicket.model.CompoundPropertyModel
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XForm
import BasePageAndWicketApplication.BasePage
import Employees.CreateAndEditEmployeePage

/**
 * 
 * @authors Skalic julian, Leandro Moscheni, Damian Cravacuore
 * 
 */

class CreateAvailabilityPage extends BasePage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	CreateAndEditEmployeePage parentPage
	AddAvailability addAvailabilityAppModel
	
	new(CreateAndEditEmployeePage parentPage, AddAvailability appModel){
		this.parentPage = parentPage
		this.addAvailabilityAppModel = appModel

		//Create form with needed appModel
		val availabilityForm = new XForm<AddAvailability>("availabilityForm", new CompoundPropertyModel(this.addAvailabilityAppModel))
		
		//Add form components
		this.addGrilInputs(availabilityForm)
		this.addActions(availabilityForm)
		
		//Add form
		addChild(availabilityForm)
	}
	
	def addGrilInputs(Form<AddAvailability> parent){
		parent.addChild(new TextField<String>("availability.from"))
		parent.addChild(new TextField<String>("availability.to")) 
		parent.addChild(new DropDownChoice<String>("availability.dayOfWeek") => [
			choices = loadableModel([| this.addAvailabilityAppModel.days ])
		])  
		parent.addChild(new FeedbackPanel("feedbackPanel"))
	}
	
	def addActions(Form<AddAvailability> parent){
		parent.addChild(new XButton("aceptar") => [
			//setEnabled(this.addAvailabilityAppModel.availability.dayOfWeek != null)
			onClick = [|
				this.addAvailabilityAppModel.availability.validate
				this.addAvailabilityAppModel.addAvailability
				returnPage()
			]				
		])
		parent.addChild(new XButton("cancelar").onClick = [| returnPage ])
	}
	
	def returnPage() {
		responsePage = parentPage
	}
}