package Restrictions

import ApplicationsModels.SeeRestrictions
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.panel.FeedbackPanel
import org.apache.wicket.model.CompoundPropertyModel
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XForm
import org.uqbar.wicket.xtend.XListView
import BasePageAndWicketApplication.BasePage
import BasePageAndWicketApplication.HomePage

/**
 * 
 * @authors Skalic julian, Leandro Moscheni, Damian Cravacuore
 * 
 */

class RestrictionsPanel extends BasePage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	HomePage homePage
	SeeRestrictions appModel
	
	new(){
		 this.homePage = new HomePage
		 this.appModel = new SeeRestrictions
		 
		 //Create form with needed appModel
		 val restrictions = new XForm<SeeRestrictions>("restrictionsForm", new CompoundPropertyModel(this.appModel))

		 //Add form components
		 this.addActions(restrictions)
		 this.showRestrictions(restrictions)
		 
		 //Add form
		 addChild(restrictions)
	}
	
	def addActions(Form<SeeRestrictions> parent){
		parent.addChild(new FeedbackPanel("feedbackPanel"))
		parent.addChild(new XButton("Volver").onClick = [| returnPage ])
		val addRestrictionButton = new XButton("Agregar")
		addRestrictionButton.onClick = [| responsePage = new CreateRestrictionPage(this)
		]
		parent.addChild(addRestrictionButton)
	}
	
	def showRestrictions(Form<SeeRestrictions> parent){
		val restrictionList = new XListView("restrictions")
		restrictionList.populateItem = [restriction |
			restriction.model = restriction.modelObject.asCompoundModel
			restriction.addChild(new Label("nameEmployee"))
			restriction.addChild(new Label("viewDate"))
			restriction.addChild(new XButton("Eliminar")
				.onClick = [| this.appModel.setSelectedRestriction(restriction.modelObject)
							  this.appModel.delete
							  this.updateListEmployees
				]
			)
		]
		parent.addChild(restrictionList)
	}
	
	def updateListEmployees(){
		this.appModel.update
	}
	
	def returnPage() {
		responsePage = homePage
	}
}