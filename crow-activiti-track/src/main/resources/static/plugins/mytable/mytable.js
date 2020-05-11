;(function($, window, undefined) {

	"use strict";
	
	// 私有函数
	var setDatas = function (oTable,ds){
		
		if (null == ds || ds == undefined){
			console.log("没有数据")
			return ;
		}
		
		var $ths = $(oTable.children("thead").children("tr").children("th"));
		
		ds.forEach(function(val,index){
			var item = ds[index];
			var $tr = $("<tr/>");
			for (var key in item){
				var td;
				if ($ths.eq(index).hasClass("dontshow")){
					td = "<td class='dontshow' data-name='"+key+"' data-value='"+item[key]+"'>"+item[key]+"</td>";
				} else {
					td = "<td data-name='"+key+"' data-value='"+item[key]+"'>"+item[key]+"</td>";
				}
				$tr.append(td);
			}
			
			oTable.append($tr);			
		});
	};

	$.fn.myTable = function(options) {
		
		var defaults = {
			start: 1,
			length: 20,
			scrollY: 200
		};
		
		var options = jQuery.extend( {}, defaults, options);
		
		var $mySelf = $(this);
		
		var methods = {
				
			init: function (ds){
			},
			draw: function (){
				
				var obj = {
					start : options.start,
					length : options.length,
					clientOrJobId : $('#clientorjobid').val(),
					clientOrJob : $('#clientorjob').val(),
					sSearch : $('#search-tasks').val()
				}
				console.log("/tasks/getTasks参数："+JSON.stringify(obj))
				
				$.ajax({
					url			: base_url + "/tasks/getTasks",
					type		: "POST",
					data 		: obj,
					dataType 	: "json",
					success		: function(data){
						var rdata = data.data;
						console.log("右边任务列表数据："+JSON.stringify(data));
						setDatas($mySelf,rdata);
					},
					error		: function(err){
						console.log("错误："+JSON.stringify(err));
					}
				});
			}		
		};
				
		this.each(function(){
			
			var $this = $(this);
			var $ths = $($this.children("thead").children("tr").children("th"));
			$this.closest(".panel").addClass("mytable-scroll");
			$this.addClass("mytable");
			$ths.addClass("mytable-th-css");

		});
		
		return methods;
	}
	
	//$(document).ready(function () { $('.myTable').myTable(); });
	
})(jQuery);
