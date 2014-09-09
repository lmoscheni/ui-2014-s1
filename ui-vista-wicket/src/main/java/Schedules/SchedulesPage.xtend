package Schedules

import ApplicationsModels.SeeSchedules
import Domain.Planification
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.model.CompoundPropertyModel
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XForm
import org.uqbar.wicket.xtend.XListView
import BasePageAndWicketApplication.BasePage
import Planifications.PlanificationsPanel

/**
 * 
 * @authors Skalic julian, Leandro Moscheni, Damian Cravacuore
 * 
 */
 
class SchedulesPage extends BasePage {
		extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	PlanificationsPanel planificationsPage
	SeeSchedules schedulesList
	
	new(PlanificationsPanel planificationsPage, Planification planification){
		this.planificationsPage = planificationsPage
		this.schedulesList = new SeeSchedules(planification)

		//Create form with needed appModel
		val schedules = new XForm<SeeSchedules>("schedulesForm", new CompoundPropertyModel(this.schedulesList))
		
		//Add form components
		this.addResultsGrid(schedules)
		this.addActions(schedules)

		//Add form
		addChild(schedules)
	}
	
	def addResultsGrid(Form<SeeSchedules> parent) {
		val listView = new XListView("assignments")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("employee.toString"))
			item.addChild(new Label("start"))
			item.addChild(new Label("end"))
		]
		parent.addChild(listView)
	}
	
	def addActions(Form<SeeSchedules> parent){
		parent.addChild(new XButton("Volver").onClick = [| responsePage = planificationsPage ])
	}
}