package Restrictions

import ApplicationsModels.AddRestriction
import ApplicationsModels.SeeRestrictions
import BasePageAndWicketApplication.BasePage
import Domain.Employee
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
class CreateRestrictionPage extends BasePage{
	
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	RestrictionsPanel parentPage
	AddRestriction appModel
	
	new(RestrictionsPanel parentPage){
		this.parentPage = parentPage
		this.appModel = new AddRestriction
		
		//Create form with needed appModel
		 val restrictions = new XForm<AddRestriction>("restrictions", new CompoundPropertyModel(this.appModel))
		
		this.addActions(restrictions)
		this.showEmployeesToAddRestriction(restrictions)
		this.addChild(restrictions)
	}
	
	def addActions(Form<AddRestriction> parent){
		parent.addChild(new FeedbackPanel("feedbackPanel"))
		parent.addChild(new XButton("Volver").onClick = [| returnPage ])
		parent.addChild(new TextField<String>("date")) 
	}
	
	//Muestro a los empleados a los cuales les puedo agregar restricciones
	def showEmployeesToAddRestriction(Form<AddRestriction> parent){
		val restrictionList = new XListView("scheduler.employees")
		restrictionList.reuseItems = true
		restrictionList.populateItem = [restriction |
			restriction.model = restriction.modelObject.asCompoundModel
			restriction.addChild(new Label("toString"))
			restriction.addChild(new XButton("Agregar")
				.onClick = [| addRestrictionResponsePage(restriction.modelObject)]
			)
		]
		parent.addChild(restrictionList)
	}
	
	def addRestrictionResponsePage(Employee e){
		this.appModel.setSelected(e)
		this.appModel.addRestriction
		this.parentPage.updateListEmployees
		returnPage
	}
	
	def returnPage() {
		responsePage = parentPage
	}
	
}