;(function($, window, undefined) {

	"use strict";
	
	// 私有函数
	var setDatas = function (oTable,ds,page){
		
		if (null == ds || ds == undefined){
			console.log("没有数据")
			return ;
		}
		
		var $ths = $(oTable.children("thead").children("tr").children("th"));
		
		ds.forEach(function(val,index){
			var item = ds[index];
			var $tr = $("<tr/>");
			
			for (var ith=0; ith<$ths.length; ith++){
				
				var key = $ths.eq(ith).attr("name");
				var value = item[key];
				var td;
				if ($ths.eq(ith).hasClass("dontshow")){
					td = "<td class='dontshow page"+page+"' data-name='"+key+"' data-value='"+value+"'>"+value+"</td>";
				} else {
					td = "<td class='page"+page+"' data-name='"+key+"' data-value='"+value+"'>"+value+"</td>";
				}
				
				if ($ths.eq(ith).hasClass("hasdate")){
					td = $(td).text("");
					td = $(td).append("<input type=text class='mytabledate' value='"+value+"' />");
				}
				$tr.append(td);
			}
			
			oTable.append($tr);		
			$(".page"+page+" .mytabledate", oTable).datepicker({
    	    	autoclose: true
    		});
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
		
		var page = options.start;
		
		var methods = {
				
			init: function (ds){
			},
			draw: function (){
				
				var obj = {
					start : page,
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
						$mySelf.children("tbody").html("");
						setDatas($mySelf,rdata,options.start);
					},
					error		: function(err){
						console.log("错误："+JSON.stringify(err));
					}
				});
			}		
		};
				
		this.each(function(){
			
			var $this 		= $(this);
			var $ths 		= $($this.children("thead").children("tr").children("th"));
			var $thschild 	= $($ths.children("div"));
			var $thisScroll = $($this.closest(".panel"));
			
			$thisScroll.addClass("mytable-scroll");
			$this.addClass("mytable");
			$ths.addClass("mytable-th-css");
			
			$thisScroll.on("scroll", function(){
				
	            var scrollTop = $thisScroll.scrollTop();
	            // 当滚动距离大于0时设置top及相应的样式
	            if (scrollTop > 0) {
	            	$ths.css({
	                    "top": scrollTop + "px",
	                    "padding": "0"
	                });
	            	$thschild.css({
	                    "borderTop": "1px solid #000",
	                    "borderBottom": "1px solid #000",
	                    "marginTop": "-1px",
	                    "padding": "8px"
	                });
	            } else {
	                // 当滚动距离小于0时设置top及相应的样式
	            	$ths.css({
	                    "top": scrollTop + "px",
	                    "marginTop": "0"
	                });
	            	$thschild.css({
	                    "border": "none",
	                    "marginTop": 0,
	                    "marginBottom": 0,
	                })
	            }
				
			});

		});
		
		return methods;
	}
	
})(jQuery);
