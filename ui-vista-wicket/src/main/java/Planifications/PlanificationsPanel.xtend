package Planifications

import ApplicationsModels.SeeAssignments
import ApplicationsModels.SeePlanifications
import Domain.Planification
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.panel.FeedbackPanel
import org.apache.wicket.model.CompoundPropertyModel
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XForm
import org.uqbar.wicket.xtend.XListView
import java.io.Serializable
import BasePageAndWicketApplication.BasePage
import BasePageAndWicketApplication.HomePage
import Schedules.SchedulesPage
import Assignments.SeeAssignmentsPage

/**
 * 
 * @authors Skalic julian, Leandro Moscheni, Damian Cravacuore
 * 
 */

class PlanificationsPanel extends BasePage implements Serializable {
		extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	HomePage homePage
	SeePlanifications listOfPlanifications
	
	new(){
		this.homePage = new HomePage
		this.listOfPlanifications = new SeePlanifications
		
		//Create form with needed appModel
		val planifications = new XForm<SeePlanifications>("planificationsForm", new CompoundPropertyModel(this.listOfPlanifications))

		//Add form components
		this.addResultsGrid(planifications)
		this.addActions(planifications)
		
		//Add form
		addChild(planifications)
	}
	
	def addResultsGrid(Form<SeePlanifications> parent) {
		parent.addChild(new FeedbackPanel("feedbackPanel"))
		val listView = new XListView<Planification>("planifications")
		listView.reuseItems = true
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("viewDate"))
			item.addChild(new Label("statePlanification"))
			item.addChild(new XButton("Planificar") =>[
				 setEnabled(!item.modelObject.confirm)
				 onClick = [| 	
				 				item.modelObject.isBeforeToday
				 				seeAssignmentsResponsePage(item.modelObject)
				 		   ] 
			])
			item.addChild(new XButton("Horarios")
				.onClick = [|responsePage = new SchedulesPage(this, item.modelObject)]
			)
		]
		parent.addChild(listView)
	}
	
	def updateListOfPlanifications(){
		this.listOfPlanifications.update
	}
	
	def seeAssignmentsResponsePage(Planification item){
		responsePage = new SeeAssignmentsPage(this,new SeeAssignments(item))
	}
	
	def addActions(Form<SeePlanifications> parent){
		parent.addChild(new XButton("Volver").onClick = [| responsePage = homePage ])
	}
}