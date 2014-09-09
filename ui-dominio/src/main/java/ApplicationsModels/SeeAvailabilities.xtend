package ApplicationsModels 
import org.uqbar.commons.utils.Observable

import java.util.ArrayList

@Observable
class SeeAvailabilities {
	@Property var int from
	@Property var int to
	@Property var String selector
	@Property var days = new ArrayList<String>()

	new() {
		this.getDays.add("Lunes")
		this.getDays.add("Martes")
		this.getDays.add("Miercoles")
		this.getDays.add("Jueves")
		this.getDays.add("Viernes")
		this.getDays.add("Sabado")
		this.getDays.add("Domingo")
	}
}
