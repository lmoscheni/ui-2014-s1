package BasePageAndWicketApplication

import org.apache.wicket.protocol.http.WebApplication
import BasePageAndWicketApplication.HomePage

/**
 * Application object for your web application. If you want to run this application without deploying, run the Start class.
 * 
 * @see Cravacuore-Moscheni-Skalic.Start#main(String[])
 */
class WicketApplication extends WebApplication {
	
	override getHomePage() {
		HomePage
	}
	
}