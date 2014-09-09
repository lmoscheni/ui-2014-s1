package Transformers

import org.uqbar.arena.bindings.Transformer
import org.joda.time.DateTime
import org.uqbar.commons.model.UserException
import org.apache.commons.lang.StringUtils

class DateTimeTransformer implements Transformer<DateTime, String> {
	
	override getModelType() {
		class DateTime
	}
	
	override getViewType() {
		class String
	}
	
	override String modelToView(DateTime valueFromModel) {
		valueFromModel.toString("dd/MM/yyyy")
	}
	
	override DateTime viewToModel(String valueFromView) {
		if(StringUtils.isEmpty(valueFromView)){
			null
		}else{
			try{
				var datesParse = valueFromView.split("/")
				var s = datesParse.get(0).concat("-").concat(datesParse.get(1)).concat("-").concat(datesParse.get(2)).concat("T23:59:59")
				println(s)
				new DateTime(s)
			}catch(Exception e){
				throw new UserException("Formato: yyyy/mm/dd")	
			}
		}
	}
}
