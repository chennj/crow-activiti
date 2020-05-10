;(function($, window, undefined) {

	"use strict";
	
	// 私有函数
	var setDatas = function (ds){
		
		if (null == ds || ds == undefined){
			console.log("没有数据")
			return ;
		}
		
		var myt = $("#tasks-list");
		var myt_body = $(myt).children("tbody");
		var myt_head = $(myt).children("thead")
		var myt_ths = $(myt).children("tr").children("th");

		ds.forEach(function(val,index){
			var item = ds[index];
			var myt_tr = $("<tr/>");
			for (var key in item){
				var tmp_td;
				if ($(myt_ths[index]).hasClass("dontshow")){
					tmp_td = "<td class='dontshow' data-name='"+key+"' data-value='"+item[key]+"'>"+item[key]+"</td>";
				} else {
					tmp_td = "<td data-name='"+key+"' data-value='"+item[key]+"'>"+item[key]+"</td>";
				}
				myt_tr.append(tmp_td);
			}
			
			myt_body.append(myt_tr);			
		});
	};
	
	
	$.fn.myTable = function(options) {
		
		var defaults = {
			start: 1,
			length: 20
		};
		
		var options = jQuery.extend( {}, defaults, options);
		
		var methods = {
				
			init: function (ds){
				
				ds.forEach(function(val,index){
					var item = ds[index];
					for (var key in item){
						var tmp_td;
						if (myt_ths[i].haveClass("dontshow")){
							tmp_td = "<td class='dontshow' data-name='"+key+"' data-value='"+item[key]+"'>"+item[key]+"</td>";
						} else {
							tmp_td = "<td data-name='"+key+"' data-value='"+item[key]+"'>"+item[key]+"</td>";
						}
						myt_tr.append(tmp_td);
					}
					
					myt_body.append(myt_tr);			
				});
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
						setDatas(rdata);
					},
					error		: function(err){
						console.log("错误："+JSON.stringify(err));
					}
				});
			}		
		};
				
		this.each(function(){
			
			var $this = $(this);
			$this.closest("panel").addClass("mytable").addClass("mytable-scroll");
		});
		
		return methods;
	}
	
	//$(document).ready(function () { $('.myTable').myTable(); });
	
})(jQuery);
