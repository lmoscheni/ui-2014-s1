package Transformers

import org.uqbar.arena.bindings.Transformer
import org.joda.time.DateTime
import Domain.Restriction

class RestrictionTransformer implements Transformer<Restriction, Object> {
	
	override getModelType() {
		class Restriction
	}
	
	override getViewType() {
		class Object
	}
	
	override Object modelToView(Restriction valueFromModel) {
		valueFromModel.date.toString("dd-MMMM-yyyy")
	}
	
	override Restriction viewToModel(Object valueFromView) {
		var datesParse = valueFromView.toString.split("/")
		var s = datesParse.get(0).concat("-").concat(datesParse.get(1)).concat("-").concat(datesParse.get(2)).concat("T23:59:59")
		var r = new Restriction()
		r.setDate(new DateTime(s))
		r
	}
}