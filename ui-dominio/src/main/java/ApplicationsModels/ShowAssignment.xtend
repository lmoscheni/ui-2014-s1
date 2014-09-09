package ApplicationsModels

import Domain.Assignment
import java.io.Serializable
import java.util.ArrayList
import org.uqbar.commons.utils.Observable

@Observable
class ShowAssignment implements Serializable{
	
	@Property var Assignment assignment
	private var hour = 0
	@Property var int count
	
	@Property var ArrayList<String> x = new ArrayList<String>
	
	new(Assignment a){
		this.assignment = a
		init()
	}
	
	def employee(){
		return assignment.employee
	}
	
	def start(){
		return assignment.start
	}
	
	def end(){
		return assignment.end
	}
	
	def boolean isAvailable(){
		var resulset = (hour >= assignment.start && hour <= assignment.end)
		if(hour == 23){
			hour = 0
		}
		else{
			hour= hour + 1
		}
		return resulset
	}
	
	def get0(){x.get(0)}	def get1(){x.get(1)}
	def get2(){x.get(2)}	def get3(){x.get(3)}
	def get4(){x.get(4)}	def get5(){x.get(5)}
	def get6(){x.get(6)}	def get7(){x.get(7)}
	def get8(){x.get(8)}	def get9(){x.get(9)}
	def get10(){x.get(10)}	def get11(){x.get(11)}
	def get12(){x.get(12)}	def get13(){x.get(13)}
	def get14(){x.get(14)}	def get15(){x.get(15)}
	def get16(){x.get(16)}	def get17(){x.get(17)}
	def get18(){x.get(18)}	def get19(){x.get(19)}
	def get20(){x.get(20)}	def get21(){x.get(21)}
	def get22(){x.get(22)}	def get23(){x.get(23)}
	def get24(){x.get(24)}
	
	def init(){
		var i = 0
		while(i < 25){
			if(isAvailable){x.add("X")}
			else{x.add(" ")}
			i = i + 1
		}
	}
	
	def String isAvailableDescription(){
		if(isAvailable) "X"
	}
}