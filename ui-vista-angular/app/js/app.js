var myApp = angular.module("Planifications",[]);


myApp.controller("PlanificationsController",function ($scope){
	'use strict';
        $scope.Planifications = [
                {'date': "24/05/2014", 'state': 'Unplanned', 'assignment':[{'employee':'julian','in':'9','out':'18'},{'employee':'julian','in':'9','out':'17'}]},
                {'date': "23/05/2014", 'state': 'Unplanned', 'assignment':[{'employee':'fede','in':'8', 'out':'19'}]}
        ];
	
	$scope.visible=false;
	
	$scope.getHours = function(planification){
        	$scope.hours = planification.assignment;
		if(!$scope.visible){
			$scope.visible = true;
		}
	};

});

myApp.filter("dateFilter", function() {
  return function(input, desde, hasta) {
	var ret, fechaComparar, fechaDesde, fechaHasta, i;
	ret=[];
  	for(i=0; i<input.length; i++){
		fechaComparar = new Date(input[i].date);
		fechaDesde = new Date(desde);
		fechaHasta = new Date(hasta);
		if((fechaComparar >= fechaDesde) && (fechaComparar <= fechaHasta)){
			ret.push(input[i]);
		}
	}
	return desde == null || desde.length == 0 ||hasta.length == 0 || hasta == null ? input : ret;
  };
});
