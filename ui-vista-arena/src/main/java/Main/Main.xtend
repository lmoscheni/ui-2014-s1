package Main 

import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import Domain.Scheduler

class Main extends Application {
	
	override protected Window<?> createMainWindow() {
		return new SchedulerWindow(this,Scheduler.getInstance )
	}
	
	def static void main(String[] args) {
		new Main().start()
		
	}
	
	
}