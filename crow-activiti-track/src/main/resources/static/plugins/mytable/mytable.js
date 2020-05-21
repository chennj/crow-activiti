;(function($, window, undefined) {

	"use strict";
	
	// 私有函数
	var setDatas = function (oTable,data,page){
		
		var ds = data.data;
		
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
				var divWidth = $ths.eq(ith).attr("width");
				//console.log("div宽度："+divWidth);
				var value = item[key];
				var td = null;
				if ($ths.eq(ith).hasClass("dontshow")){
					td = "<td class='dontshow page"+page+"' data-name='"+key+"' data-value='"+value+"'><div>"+value+"</div></td>";
				} else {
					td = "<td class='page"+page+"' data-name='"+key+"' data-value='"+value+"'><div>"+value+"</div></td>";
				}
				
				if ($ths.eq(ith).hasClass("hasdate")){
					td = $(td).html("");
					td = $(td).append("<div><input type=text style='width:120px;' class='mytabledate' value='"+value+"' /></div>");
				}
				
				if ($ths.eq(ith).hasClass("hascheckbox")){
					td = $(td).html("");
					td = $(td).append("<div><input type=checkbox /></div>");					
				}
				
				if ($ths.eq(ith).hasClass("hassubdata-statusmap")){
					
					$ths.eq(ith).css("zIndex",9);
					
					var statusmap = data.statusmap;
					var $subStatus = $(
						'<div class="btn-group col-sm-12 choseTaskStatus">' +
						  	'<button type="button" class="btn btn-flat btn-default col-sm-9">'+value+'</button>' +
						  	'<button type="button" class="btn btn-flat btn-default dropdown-toggle col-sm-3" data-toggle="dropdown">' +
						    	'<span class="caret"></span>' +
						    	'<span class="sr-only"></span>' +
						  	'</button>' +
						  	'<ul class="dropdown-menu" role="menu">' +
						  	'</ul>' +
						'</div>');
					var subStatus_open 	= '<li>OPEN</li>';
					var subStatus_close = '<li>CLOSE</li>'
					for (var key in statusmap){
						if (statusmap[key]['type'] == 'Open'){
							subStatus_open 	+= '<li class="active"><a href="javascript:void(0);">&nbsp;&nbsp;'+statusmap[key]["name"]+'</a></li>'
						} else {
							subStatus_close += '<li><a href="javascript:void(0);">&nbsp;&nbsp;'+statusmap[key]["name"]+'</a></li>'
						}
					}
					$("ul",$subStatus).append(subStatus_open);
					$("ul",$subStatus).append(subStatus_close);
					
					td = $(td).html("");
					td = $(td).append($subStatus);
				}
				
				$tr.append(td);
				if (divWidth != null && divWidth != undefined && index==0){
					$tr.children("td").eq(ith).children("div").css("width",divWidth+"px");
					//console.log(key+" div宽度："+divWidth);
				}
			}
			
			oTable.append($tr);		
			$(".page"+page+" .mytabledate", oTable).datepicker({
    	    	autoclose: true
    		});
			
			$(".page"+page+" .choseTaskStatus ul li a", oTable).on("click",function(){
				
				var tex = $(this).text();
				$(this).closest(".choseTaskStatus").children("button").eq(0).text(tex);
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
						
						//console.log("右边任务列表数据："+JSON.stringify(data));
						$mySelf.children("tbody").html("");
						setDatas($mySelf,data,options.start);
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
