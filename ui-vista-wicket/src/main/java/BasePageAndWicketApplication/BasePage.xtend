package BasePageAndWicketApplication

import org.apache.wicket.markup.html.WebPage
import org.apache.wicket.markup.html.link.BookmarkablePageLink
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import Restrictions.RestrictionsPanel
import Planifications.PlanificationsPanel
import Employees.EmployeesPanel

/**
 * 
 * @authors Skalic julian, Leandro Moscheni, Damian Cravacuore
 * 
 */

class BasePage extends WebPage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
		
	new(){
		this.addHomeLink
		this.addMainOptions
	}
	
  	protected def addHomeLink() {
  		addChild(new BookmarkablePageLink("linkToHomePage", HomePage))
  	}
  	
   	protected def addMainOptions() {
  		addChild(new BookmarkablePageLink("Planifications", PlanificationsPanel))
  		addChild(new BookmarkablePageLink("Restrictions", RestrictionsPanel))
  		addChild(new BookmarkablePageLink("Employees", EmployeesPanel))
  	}
}
