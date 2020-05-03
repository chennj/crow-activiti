/**
 * Created by xuxueli on 17/4/24.
 */
$(function () {
		
	var layerPrefix 		= "layui-layer";
	var bodyHeight 			= $(document.body).innerHeight();
	var footerHeight 		= $('.main-footer').eq(0).outerHeight(true);
	
	var clientJobTree 		= $('#tree-clients-jobs');
	var taskTable 			= $('#tasks-list');
	var taskTableWrapper	= $('#tasks-list-panel');
	
    var lyIdxOfTaskTypeList;
    var lyIdx;
    var prevInputWorkType;
    
    var modalAddnewClientValidate;
    var modalAddnewJobValidate;
    var modalAddnewTaskValidate;
    
    var oTable;
	
	setClientJobTreeHeight();	
    setDataTableHeight();
    
    initDataTable();
    
    initTaskWorkTypeLayer();
    
    initClientJobTree();
    
    initLocalSearch();
    
    initAddNewButton();
    
    initAddNewNewClientLayer();   
    initAddNewNewJobLayer();
    initAddNewNewTasksLayer();
    
    initTips();
    
    initTableCheckBox();
    
    initDatePicker();
    
    // 左边treeview高度设置，计算它的高度使其能撑满屏幕
    function setClientJobTreeHeight(){
        var leftPartHeight = $('#leftPart').outerHeight(true);
        var pt = $('#main-content').css('padding-top');
        pt = pt.substr(0,pt.length-2);
        var pb = $('#main-content').css('padding-bottom');
        pb = pb.substr(0,pb.length-2);
        var mt = $('#main-content').css('margin-top');
        mt = mt.substr(0,mt.length-2);
        var mb = $('#main-content').css('margin-bottom');
        mb = mb.substr(0,mb.length-2);
        var contentMargin = parseInt(pt)+parseInt(pb)+parseInt(mt)+parseInt(mb);
        var treeHeight = bodyHeight
        	- $('.main-header').eq(0).outerHeight(true)
        	- $('#main-content-header').outerHeight(true)
        	- leftPartHeight
        	- $('.main-footer').eq(0).outerHeight(true)
        	- contentMargin;    
        $(clientJobTree).css({
        	'height':treeHeight+'px',
            '-webkit-box-sizing': 'border-box',
            '-moz-box-sizing': 'border-box',
            'box-sizing': 'border-box',
            'border': '1px solid #ddd'
        });
    }
    
    // 计算data table高度
    function setDataTableHeight(margin){
        var tableOffsetTop = $(taskTableWrapper).offset().top;
        var tableMargin = margin || 15;
        var tableHeight = bodyHeight - tableOffsetTop - footerHeight - tableMargin;
        $(taskTableWrapper).css("height",tableHeight+"px");
        console.log("tableMargin>>>"+tableMargin);
    }

    function initDataTable(){
    	
    	oTable = $(taskTable).DataTable({
    		"deferRender": true,
    		"processing" : true, 
    	    "serverSide": true,
    	    "scrollY": "calc(100vh - 349px)",
    	    "scrollX":  true,
    	    "scrollCollapse": true,
    	    "paging": false,
    		"ajax": {
    			url: base_url + "/tasks/getTasks",
    	        data : function ( d ) {
    				var obj = {};
    				obj.start = d.start;
    				obj.length = d.length;
    				obj.clientOrJobId = $('#clientorjobid').val();
    				obj.clientOrJob = $('#clientorjob').val();
    				obj.sSearch = $('#search-tasks').val();
    				return obj;
                }
    	    },
    	    "searching": false,
    	    "ordering": true,
    	    "columns": [
    	                { data: 'id', bSortable: false,visible:false},
    	                { data: 'name',width: 300},
    					{ data: 'sysStatusName',width:110},
                		{ data: 'spentTime',"defaultContent": "<i>Not set</i>",width:80},
                		{ data: 'estimate',width:70},
    	                { data: 'overdueDate',width:150},
    	                { data: 'lastTrackingDate',width:150},
    	                { data: 'createTime',width:150}
    	            ],
    		"language" : {
    			"sProcessing" : "working hard...",
    			"sUrl" : "",
    			"sEmptyTable" : "not data",
    			"sLoadingRecords" : "loading..."
    		},
    		"initComplete": function(settings, json) {
    		}
        });
        
    	$('#search-tasks').on('click', function(){
    		oTableFresh();
    	});
    	
    	
    	//渲染结束之后回调,没啥作用
    	//$(taskTable).on( 'draw.dt', function () {
    	//	setDataTableHeight(19);
    	//});
    }
    
    /**
     * modal:初始化工作类别
     */
    function initTaskWorkTypeLayer(){
    	
    	$.post(base_url + "/tasks/getTaskType", function(data, status) {
    		
    		if (data.code == "200") {
    			var rdata = data.data;
    			console.log("data:"+JSON.stringify(rdata));
    			var len = rdata.length;
    			if (len == 0){
    				return;
    			}
    			var defaultData;
    			
    			//获取缺省设置
    			for (var i=0; i<len; i++){
    				if (rdata[i].isdefault){
    					defaultData = rdata[i];
    					break;
    				}
    			}
    			
    			var ul = $('<ul></ul>');
    			var chdLiIdx = 0;
    			
    			//list to tree 两层 (无限级别类似)
    			rdata.forEach(element=>{
    				var parentId = element.parentId;
    				if (parentId == 0){
    					var liul = '<li><a href="javascript:;" data-pid="'+element.parentId+'" data-id="'+element.id+'" data-name="'+element.name+'">'+element.name+'</a><ul></ul></li>';
    					$(ul).append(liul);
    					rdata.forEach(ele=>{
    						if (ele.parentId == element.id){
    							var li = '<li><a href="javascript:;" data-pid="'+ele.parentId+'" data-id="'+ele.id+'" data-name="'+ele.name+'">'+ele.name+'</a></li>';
    							$(ul).children('li').eq(chdLiIdx).children('ul').append(li);
    							if (!element.children){
    								element.children = [];
    							}
    							element.children.push(ele);
    						}
    					});
    					chdLiIdx++;
    				}
    			});
    			
    			console.log("获取工作类型，过滤前："+JSON.stringify(rdata));
    			rdata = rdata.filter(ele=>ele.parentId === 0);
    			console.log("获取工作类型，过滤后："+JSON.stringify(rdata));
    			console.log("获取工作类型，html："+$(ul).html());
    			
    			$('#modal-addnew-task-type-list').append(ul);
    			
    			//设置新增任务弹窗中缺省任务的值
    			$("#modal-addnew-task input[name='workType']").val(defaultData.name);
    			$("#modal-addnew-task input[name='workType']").data("systypeid",defaultData.id);
    		} else {
    			layer.msg(data.msg || "Initialize Work Type List Failed!",{icon: 2});
    		}
    	});

    }
    
    function initClientJobTree(dataTable){

        //设置背景
    	$(clientJobTree).css("background-color","#f3f5f9");

    	//加载初始化数据
        $.post(base_url + "/tasks/getClients", function(data,status){
        	if (data.code == "200") {
        		var li = "";
        		var rdata = data.data.data;
        		console.log("data:"+JSON.stringify(rdata));
        		var len = rdata.length;
        		if (len>0){
        			li += '<li data-id="allclients" data-name="allclients">'+
        				'<a href="javascript:void(0)"><i class="fa fa-chevron-circle-right"></i>'+
        				'All Clients </a></li>';
        		}
        		for (var i=0; i<len; i++){
        			li += '<li class="treeview" data-id="'+rdata[i].id+'" data-name="'+rdata[i].name+'" data-type="client">'+
        			'<a href="javascript:void(0)"><i class="fa fa-chevron-circle-right"></i>'+
        			rdata[i].name+
        			'</a>'+
        			'<ul class="treeview-menu"></ul>'+
        			'</li>';
        		}
        		console.log("左边客户列表："+li);
            	$('#tree-clients-jobs ul').append(li);
            	$('#input-search-clients-jobs').hideseek();
        	} else {
        		layer.open({
                    title: "System Prompt",
                    btn: [ "Confirm" ],
                    content: (data.msg || "Create Failed" ),
                    icon: '2'
                });
        	}
        });
         
        /**
         * $("#tree-clients-jobs ul li a").on("click",function(){});
         * 这种写法时错误的，应为li a还没有生成，所以绑定不上事件
         * client（客户）树形列表展开事件
         */
        // 给数据动态绑定点击事件
        $(clientJobTree).on('click','ul li a',function(){
        	
        	$("#tree-clients-jobs ul li").removeClass("selected");
        	$(this).parent().addClass("selected");

        	$(".taskDataTable-header").text($(this).parent().data("name"));
        	setDataTableHeight();
        	
        	var type = $(this).parent().data('type');
        	
        	var prevId = $("#clientorjobid").val();
        	if ($(this).parent().data("id") != prevId){
        		$("#clientorjobid").val($(this).parent().data("id"));
    	    	if ('job' == type){
    	    		$("#clientorjob").val("job");
    	    		return;
    	    	} else if ('client' == type) {
    	    		$("#clientorjob").val("client");
    	    	} else {
    	    		$("#clientorjob").val("allClients");
    	    	}
    	    	oTableFresh();
        	}
        	
        	var clientId = $(this).closest('li').first().data("id");
        	var uiJobs = $(this).siblings('ul').first();
        	var ifa = $(this).children("i.fa").first();
        	
        	if ($(ifa).hasClass('fa-chevron-circle-right')){
        		$(ifa).removeClass('fa-chevron-circle-right').addClass('fa-chevron-circle-down');
        		if (uiJobs == null || $(uiJobs).children('li').length == 0){
        			$.post(base_url + "/tasks/job/all",{"clientId":clientId},function(data,status){
        				if (data.code == 200){
        					var rdata = data.data;
        					var ul = $('#tree-clients-jobs > ul > li[data-id="'+clientId+'"]').children('ul').first();
        					var li = '';
        					for (var i=0; i<rdata.length; i++){
        		    			li += 
                    				'<li data-id="'+rdata[i].id+'" data-name="'+rdata[i].name+'" data-type="job">'+
                    				'<a href="javascript:void(0)">'+
                    				rdata[i].name +
                    	            '<span class="pull-right-container">'+
                    	            '<i class="fa fa-asterisk pull-right"></i>'+
                    	            '</span>'+
                    				'</a>'+
                    				'</li>';
        		    		}
        		    		console.log('jobs of client["'+clientId+'"]='+li);
        		    		console.log('ul ["'+clientId+'"]='+$(ul));
        		        	$(ul).append(li);
        		        	$('#input-search-clients-jobs').hideseek();    					
        				} else {
        					layer.msg(data.msg || "Get Job Failed", {icon: 1});
        					console.log(data.msg || "Get Job Failed");
        				}
        			});    			
        		}
        	} else {
        		$(ifa).removeClass('fa-chevron-circle-down').addClass('fa-chevron-circle-right');
        	}
        });
    }
    
    // 本地即时搜索
    function initLocalSearch(){
        $('#input-search-clients-jobs').hideseek({
        	highlight: true
        });
    }
    
    // Add New Button 事件
    function initAddNewButton(){
    	
        $('#clients-jobs-addnew li a').on('click',function(){
        	switch($(this).parent('li').index()){
        	case 0:
        		setClientLayerSelect2();
        		lyIdx = layer.open({
        			type: 1,
        			title: 'Create New Client',
        			closeBtn: 1,
        			area:['60%','95%'],
        			shadeClose: false,
        			skin: 'layui-layer-rim',
        			move: false,
        			anim: 1,
        			content: $('#modal-addnew-client')
        			});
        		break;
        	case 2:
        		setJobLayerSelect2();
        		lyIdx = layer.open({
        			type: 1,
        			title: 'Add new job',
        			closeBtn: 1,
        			area:['60%','95%'],
        			shadeClose: false,
        			skin: 'layui-layer-rim',
        			move: false,
        			anim: 4,
        			content: $('#modal-addnew-job')
        			});
        		break;
        	case 4:
        		setTaskLayerSelect2();
        		   		
        		lyIdx = layer.open({
        			type: 1,
        			title: 'Create New Tasks',
        			closeBtn: 1,
        			area:['60%','95%'],
        			shadeClose: false,
        			skin: 'demo-class',
        			move: false,
        			anim: 3,
        			content: $('#modal-addnew-task')
        		});
        		
        		var layerHeight = $("#"+layerPrefix+lyIdx).innerHeight();
        		console.log('弹框内框高度：'+layerHeight);
        		$('.tabel-wrapper-scroll').css("height",(layerHeight - 250) + "px");
        		
        		break;
        	default:
        		break;
        	}
        });
    	
    }
    
    /**
     * modal:新增客户
     */
    function initAddNewNewClientLayer(){
    	
        modalAddnewClientValidate = $("#modal-addnew-client form").validate({
    		errorElement : 'span',
    		errorClass : 'help-block',
    		focusInvalid : true,
    		rules : {
                name : {
    				required : true ,
                    rangelength:[4,220]
    			}
    		},
    		messages : {
    			name : {
    				required :'Please enter "Client Name".'  ,
                    rangelength: '[4~220]'
    			}
    		},
    		highlight : function(element) {
    			$(element).closest('.form-group').addClass('has-error');
    		},
    		success : function(label) {
    			label.closest('.form-group').removeClass('has-error');
    			label.remove();
    		},
    		errorPlacement : function(error, element) {
    			element.parent('div').append(error);
    		},
    		submitHandler : function(form) {
    			//alert("debug.add.client");
    			$.post(base_url + "/tasks/add/client", $("#modal-addnew-client form").serialize(), function(data, status) {
    				if (data.code == "200") {

                        layer.open({
                            title: "System Prompt",
                            btn: [ "Confirm" ],
                            content: "Create Success" ,
                            icon: '1',
                            end: function(layero, index){
                        		var li = 
                        			'<li class="treeview" '+
                        			'data-id="'+data.data.id+'" '+
                        			'data-name="'+data.data.name+'" '+
                        			'data-type="client">'+
                        			'<a href="javascript:void(0)"><i class="fa fa-chevron-circle-right"></i>'+
                        			data.data.name+
                        			'</a>'+
                        			'<ul class="treeview-menu"></ul>'+
                        			'</li>';
                            	$('#tree-clients-jobs > ul').append(li);
                            	$('#input-search-clients-jobs').hideseek();
                            	layer.close(lyIdx);
                                //oTableFresh(false);
                            }
                        });
    				} else {
                        layer.open({
                            title: "System Prompt",
                            btn: [ "Confirm" ],
                            content: (data.msg || "Create Failed" ),
                            icon: '2'
                        });
    				}
    			});
    		}
    	});    

    }
    
    /**
     * modal:新增工作
     * @returns
     */
    function initAddNewNewJobLayer(){
    	
        modalAddnewJobValidate = $("#modal-addnew-job form").validate({
    		errorElement : 'span',
    		errorClass : 'help-block',
    		focusInvalid : true,
    		rules : {
                name : {
    				required : true ,
                    rangelength:[4,255]
    			}
    		},
    		messages : {
                name : {
    				required :'Please enter "Client Name".'  ,
                    rangelength: '[4~220]'
    			}
    		},
    		highlight : function(element) {
    			$(element).closest('.form-group').addClass('has-error');
    		},
    		success : function(label) {
    			label.closest('.form-group').removeClass('has-error');
    			label.remove();
    		},
    		errorPlacement : function(error, element) {
    			element.parent('div').append(error);
    		},
    		submitHandler : function(form) {
    			//alert("debug.add.client");
    			$.post(base_url + "/tasks/add/job", $("#modal-addnew-job form").serialize(), function(data, status) {
    				if (data.code == "200") {

                        layer.open({
                            title: "System Prompt",
                            btn: [ "Confirm" ],
                            content: "Create Success" ,
                            icon: '1',
                            end: function(layero, index){
                            	var rdata = data.data;
                            	var html;
                            	console.log('li.selected = #tree-clients-jobs > ul > li[data-id="'+rdata.businessKey+'"]');
                        		var li = $('#tree-clients-jobs > ul > li[data-id="'+rdata.businessKey+'"]');
                        		if (li == null){
                        			html = 
                        				'<li class="treeview menu-open" '+
                        				'data-id="'+rdata.client.id+'" '+
                        				'data-name="'+rdata.client.name+'" '+
                        				'data-type="client" style="display:block;">'+
    	                    			'<a href="javascript:void(0)"><i class="fa fa-chevron-circle-right"></i>'+
    	                    			rdata.client.name+
    	                    			'</a>'+
    	                    			'<ul class="treeview-menu" style="display:block;">'+
    	                    				'<li data-id="'+rdata.job.id+'" data-name="'+rdata.job.name+'" data-type="job">'+
    	                    				'<a href="javascript:void(0)">'+
    	                    				rdata.job.name
    	                    	            '<span class="pull-right-container">'+
    	                    	            '<i class="fa fa-asterisk pull-right"></i>'+
    	                    	            '</span>'+
    	                    				'</a>'+
    	                    				'</li>'+
    	                    			'</ul>'+
    	                    			'</li>';
                        			$('#tree-clients-jobs > ul').append(html);
                        		} else {
                        			html = 
                        				'<li data-id="'+rdata.job.id+'" data-name="'+rdata.job.name+'" data-type="job">'+
                        				'<a href="javascript:void(0)">'+
                        				rdata.job.name
                        	            '<span class="pull-right-container">'+
                        	            '<i class="fa fa-asterisk pull-right"></i>'+
                        	            '</span>'+
                        				'</a>'+
                        				'</li>';
                        				
                        			$('> ul',$(li)).append(html);
                        			//展开
                        			$(li).addClass('menu-open').css('display','block');
                        			$('>ul',$(li)).css('display','block');
                        		}
                        			
                        		console.log("appended html = "+html);
                            	$('#input-search-clients-jobs').hideseek();
                            	layer.close(lyIdx);
                                //oTableFresh(false);
                            }
                        });
    				} else {
                        layer.open({
                            title: "System Prompt",
                            btn: [ "Confirm" ],
                            content: (data.msg || "Create Failed" ),
                            icon: '2'
                        });
    				}
    			});
    		}
    	});    
        
    }
    
    /**
     * modal:新增任务
     */
    function initAddNewNewTasksLayer(){
    	
        modalAddnewTaskValidate = $("#modal-addnew-task form").validate({
    		errorElement : 'span',
    		errorClass : 'help-block',
    		focusInvalid : true,
    		rules : {
    			procInstId : {
    				required : true 
    			}
    		},
    		messages : {
    			procInstId : {
    				required :'Please enter "Client Name".' 
    			}
    		},
    		highlight : function(element) {
    			$(element).closest('.form-group').addClass('has-error');
    		},
    		success : function(label) {
    			label.closest('.form-group').removeClass('has-error');
    			label.remove();
    		},
    		errorPlacement : function(error, element) {
    			element.parent('div').append(error);
    		},
    		submitHandler : function(form) {
    			
    			//组装提交的数据
    			var submitData = [];
    			
    			var procInstId = $('select[name="procInstId"]:first').val();
    			var businessKey = $('select[name="choseClient"]:first').val();
    			if (procInstId==null || procInstId.trim().length == 0){
    				layer.msg("Please one job", {icon: 2});
    				return;
    			}
    			if (businessKey==null || businessKey.trim().length == 0){
    				layer.msg("Please one client", {icon: 2});
    				return;
    			}
    			var trs = $("#modal-addnew-task form table tbody tr");
    			if (!trs){
    				layer.msg(data.msg || "Data Table Is EMPTY", {icon: 1});
    				return;
    			};
    			for (var i=0; i<trs.length; i++){
    				var td = $(trs).children('td');
    				var isChk = $('input[type="checkbox"]:first',$(td)).prop('checked');
    				if (!isChk){
    					continue;
    				}
    				var itemJson = {}
    				itemJson['businessKey']	= businessKey;
    				itemJson['procInstId'] 	= procInstId;
    				itemJson['name'] 		= $('input[type=text]:first',$(td).eq(0)).val();
    				itemJson['desc'] 		= $('textarea:first',$(td).eq(0)).val();
    				itemJson['estimate'] 	= $('input[type=text]:first',$(td).eq(1)).val();
    				itemJson['deadline'] 	= $('input[type=text]:first',$(td).eq(2)).val();
    				itemJson['sysTypeId'] 	= $('input[type=text]:first',$(td).eq(3)).data("systypeid");
    				
    				if (itemJson['name']==null || itemJson['name'].trim().length == 0){
    					layer.msg(i+"th row task name is empty", {icon: 2});
    					return;
    				}
    				
    				if (itemJson['sysTypeId']==null || itemJson['sysTypeId'].trim().length == 0){
    					layer.msg(i+"th row work type is empty", {icon: 2});
    					return;
    				}
    				
    				submitData.push(itemJson);
    			}
    			
    			if (submitData.length == 0){
    				layer.msg("Select one row AT LEAST", {icon: 2});
    				return;
    			}
    			
    			console.log("add new task submit data:"+JSON.stringify(submitData));
    			
    			$.post(base_url + "/tasks/add/batch", {tasks:JSON.stringify(submitData)}, function(data, status) {
    				if (data.code == "200") {
    					
    					//刷新数据列表
    					oTableFresh();
    					
    					layer.msg(data.msg || "Operator complete", {icon: 1});
    					
                    	if (lyIdxOfTaskTypeList != undefined && lyIdxOfTaskTypeList !== null){
                    		layer.close(lyIdxOfTaskTypeList);
                    		lyIdxOfTaskTypeList = null;
                    	}
                    	layer.close(lyIdx);

    				} else {
                        layer.open({
                            title: "System Prompt",
                            btn: [ "Confirm" ],
                            content: (data.msg || "Create Failed" ),
                            icon: '2'
                        });
    				}
    			});
    		}
    		
     	});    
                
        //+add new row 5 row 10 row
        $("#modal-addnew-task .addNewRow a").on("click",function(){
        	
        	switch ($(this).index()){
        	case 0:		//add new row
        		var tr1New = $(".trDefault").first().clone().removeClass("trDefault").addClass("trNew");
        		$(tr1New).data("systypeid",$(".trDefault input[name='workType']:first").data('systypeid'));
        		$(tr1New).appendTo($(".trDefault").parent());
        		break;
        	case 1:		//add 5 row
        		for (var i=0; i<5; i++){
        			var tr1New = $(".trDefault").first().clone().removeClass("trDefault").addClass("trNew");
        			$(tr1New).appendTo($(".trDefault").parent());
        		}
        		break;
        	case 2:		//add 10 row
        		for (var i=0; i<10; i++){
        			var tr1New = $(".trDefault").first().clone().removeClass("trDefault").addClass("trNew");
        			$(tr1New).appendTo($(".trDefault").parent());
        		}
        		break;
        	default:
        		return;
        	}
    		$('#modal-addnew-task .trNew .date input[type="text"]').datepicker({
    	    	autoclose: true
    		});
    		$('#modal-addnew-task .trNew').removeClass("trNew");
        })

        // 删除行
	    $("#modal-addnew-task").on("click",".delTr",function(){
	    	if ($(this).closest("tbody").children("tr").length == 1){
	    		layer.msg("last one can't be del",this);
	    	} else {
	    		$(this).closest("tr").remove();
	    	}
	    });

        /**
         * 动态新增任务行的工作类别选择事件绑定
         */
        $("#modal-addnew-task").on("click","input[name='workType']",function(event){
        	
        	console.log((prevInputWorkType!==null)+","+(prevInputWorkType != undefined)+","+(prevInputWorkType == this));
        	if (prevInputWorkType!=null && prevInputWorkType != undefined && prevInputWorkType == this){
        		event.stopPropagation();
        		return;
        	}
        	
        	prevInputWorkType = this;
        	
        	if (lyIdxOfTaskTypeList != undefined && lyIdxOfTaskTypeList !== null){
        		console.log("关闭layer");
        		$("#"+layerPrefix+lyIdxOfTaskTypeList).hide(10);
        	}
        	
        	var width 	= $(this).closest(".tabel-wrapper-scroll").outerWidth() * 2 / 5;
        	var height 	= $(this).closest(".tabel-wrapper-scroll").outerHeight() + 50;
        	var left 	= $(this).offset().left - width - 2;
        	var top 	= $(this).closest(".tabel-wrapper-scroll").offset().top - 50;
        	
        	$("#modal-addnew-task-type-list ul li a[data-id='"+$(this).data("systypeid")+"']")
        			.css("color","white")
        			.parent().css({"background-color":"#3c8dbc"});
        	
        	console.log("打开layer");
        	if (lyIdxOfTaskTypeList != undefined && lyIdxOfTaskTypeList !== null){
        		$("#"+layerPrefix+lyIdxOfTaskTypeList).show(10);
        		event.stopPropagation();
        		return;
        	}
        	lyIdxOfTaskTypeList = layer.open({
    			type: 1,
    			title:false,
    			closeBtn: 0,
    			offset:[top+'px',left+'px'],
    			area:[width+'px',height+'px'],
    			shadeClose: true,
    			shade: 0,
    			move: false,
    			skin: 'task-type-class',
    			content: $('#modal-addnew-task-type-list')
    			});
        });
        $(document).on("click",":not(#modal-addnew-task input[name='workType'])",function(e){
        	
        	if (lyIdxOfTaskTypeList != undefined && lyIdxOfTaskTypeList != null){
    	    	var layerHeight = $(".task-type-class").first().outerHeight();
    	    	var layerWidth 	= $(".task-type-class").first().outerWidth();
    	    	var layerLeft 	= $(".task-type-class").first().offset().left;
    	    	var layerTop 	= $(".task-type-class").first().offset().top;
    	    	//鼠标位置
    	    	var xx = e.pageX;
    	    	var yy = e.pageY;
    	    	
    	    	if (xx < layerLeft || yy < layerTop || xx > (layerLeft+layerWidth) || yy > (layerTop+layerHeight)){
    	    		layer.close(lyIdxOfTaskTypeList);
    	    		lyIdxOfTaskTypeList = null;
    	    		prevInputWorkType = null;
    	    	}
        	}
        	
        });
        $("#modal-addnew-task-type-list").on("click","ul li a", function(e){
        	
        	if (prevInputWorkType!=null && prevInputWorkType != undefined && prevInputWorkType == this){
        		event.stopPropagation();
        		return;
        	}
        	
        	$(prevInputWorkType).val($(this).text());
        	$(prevInputWorkType).data('systypeid', $(this).data('systypeid'));
        	prevInputWorkType = null;
        	$("#"+layerPrefix+lyIdxOfTaskTypeList).hide(10);
        });

    }
    
    /**
     * 初始化提示
     */
    function initTips(){
    	
    	$(".layer-tip").on("mouseover",function(){
        	layer.tips($(this).data("tip"),this);
        });
    }
    
    /**
     * Enable check and uncheck all functionality
     */
    function initTableCheckBox(){
    	
        $(".checkbox-toggle").on("click",function () {
        	var clicks = $(this).data('clicks');
        	if (clicks) {
        		//Uncheck all checkboxes
        		$(".table-addnew-row input[type='checkbox']").iCheck("uncheck");
        		$(".fa", this).removeClass("fa-check-square-o").addClass('fa-square-o');
        	} else {
        		//Check all checkboxes
        		$(".table-addnew-row input[type='checkbox']").iCheck("check");
        		$(".fa", this).removeClass("fa-square-o").addClass('fa-check-square-o');
        	}
        	$(this).data("clicks", !clicks);
        });

    }
    
    /**
     * init datepicker
     */
    function initDatePicker(){
    	
        $('.date input[type="text"]').datepicker({
        	autoclose: true
    	});
    }
	
	/* ------------------------- other function --------------- */
	
	/**
	 * 新增客户(client)layer里面的select2的设置
	 */
	function setClientLayerSelect2(){
		
		var clientSelect = $('#modal-addnew-client .select2[name="ClientCopy"]').first();
		
		clientSelect.select2({
	    	dropdownParent:$("#modal-addnew-client"),
	    	placeholder: "-- Select Client --",
	    	minimumInputLength: 1,　　						//最小查询参数
	    	multiple: false,								//多选设置
	    	data: iniData,									//初始化数据
	    	ajax: {
	    		url: base_url + "/tasks/getClients",
	    		dataType: "json",
	    		type: "POST",
	    		quietMillis: 500,							//延时查询毫秒数
	    		data: function (params) {
	    			return {
	    				sSearch: params.term,				//term为前台输入的查询关键字，保存到sSearch对象，
	    													//即后台保存关键字的对象
	    				start: params.page || 1,
	    				length: 20							//每次查询的结果数
	    			};
	    		},
	    		processResults: function (data, page) {
	    			var rdata = data.data.data;
	    			console.log("#modal-addnew-client .select2 results mothed data:"+JSON.stringify(rdata)+",page:"+JSON.stringify(page));
	    			var more = (page * 20) < rdata.recordsTotal;
	    			return {
	    				
	    				results: $.map(rdata, function(item){//results结果集，rdata为后台返回的查询结果

							return {
								text: item.name,
								id: item.id
							}
	    				}),
	 	    			more: more
	    			};
	    		}
	    	}
	    });
	}
	
    /**
     * 新增工作(job)layer里面的select2的设置
     */
    function setJobLayerSelect2(){
    	
    	var clientSelect = $('#modal-addnew-job .select2[name="businessKey"]').first();
    	
    	/**
    	 * 给select2设置默认值
    	 */
    	//step 1:
    	var iniData=[];    	
		var selectedValue;
		$("#tree-clients-jobs > ul > li").each(function(){
			if ($(this).hasClass("selected")){
				if ($(this).data("id")=="allclients"){
					return;
				}
				selectedValue = $(this).data("id");
				console.log("当前选择的【客户，客户ID】=【"+$(this).data("name")+","+selectedValue+"】");
			}	
			iniData.push({id:$(this).data("id"),text:$(this).data("name")});
		});
		console.log("新增Job的select2初始化数据[inidata]:"+JSON.stringify(iniData));
		
		//step 2:
    	clientSelect.select2({
	    	dropdownParent:$("#modal-addnew-job"),
	    	placeholder: "-- Please Select Client to Add Job for --",
	    	minimumInputLength: 1,　　						//最小查询参数
	    	multiple: false,								//多选设置
	    	data: iniData,									//初始化数据
	    	ajax: {
	    		url: base_url + "/tasks/getClients",
	    		dataType: "json",
	    		type: "POST",
	    		quietMillis: 500,							//延时查询毫秒数
	    		data: function (params) {
	    			return {
	    				sSearch: params.term,				//term为前台输入的查询关键字，保存到sSearch对象，
	    													//即后台保存关键字的对象
	    				start: params.page || 1,
	    				length: 20							//每次查询的结果数
	    			};
	    		},
	    		processResults: function (data, page) {
	    			var rdata = data.data.data;
	    			console.log("#modal-addnew-job .select2 results mothed data:"+JSON.stringify(rdata)+",page:"+JSON.stringify(page));
	    			var more = (page * 20) < rdata.recordsTotal;
	    			return {
	    				
	    				results: $.map(rdata, function(item){//results结果集，rdata为后台返回的查询结果

							return {
								text: item.name,
								id: item.id
							}
	    				}),
	 	    			more: more
	    			};
	    		}
	    	}
	    });
    	
    	//step 3:
		if (selectedValue){
			console.log("设置选择客户的默认值");
			clientSelect.val([selectedValue]).trigger('change');
		}
    }

    /**
     * 新增任务(task)layer里面的select2的设置
     */
    function setTaskLayerSelect2(){
    	
    	/**
    	 * 给client select2 和 job select2设置默认值
    	 */
    	//step 1:
    	var iniClientData=[],iniJobData=[];    	
		var selectedClientValue,selectedJobValue;
		var selectedType;
		var selectedLi = $("#tree-clients-jobs ul li.selected").first();
		
		if (selectedLi && $(selectedLi).data("id")!="allclients"){
			
			selectedType  = $(selectedLi).data("type");
			console.log("当前选择的[name,id,type]=["+$(selectedLi).data("name")+","+$(selectedLi).data("id")+","+selectedType+"]");
			
			if (selectedType == "client"){
				iniClientData.push({id:$(selectedLi).data("id"),text:$(selectedLi).data("name")});
				selectedClientValue = $(selectedLi).data("id");
			} else if (selectedType == "job"){
				iniJobData.push({id:$(selectedLi).data("id"),text:$(selectedLi).data("name")});
				iniClientData.push(
						{
							id:$(selectedLi).parent("ul").parent("li").first().data("id"),
							text:$(selectedLi).parent("ul").parent("li").first().data("name"),
							});
				selectedJobValue = $(selectedLi).data("id");
				selectedClientValue = $(selectedLi).parent("ul").parent("li").first().data("id")
			}

		}
		console.log("新增Task的client select2初始化数据[iniClientData]:"+JSON.stringify(iniClientData));
		console.log("新增Task的job select2初始化数据[iniJobData]:"+JSON.stringify(iniJobData));
    	    	
    	
		//step 2:
    	var clientSelect 	= $('#modal-addnew-task .select2[name="choseClient"]').first();
    	var jobSelect 		= $('#modal-addnew-task .select2[name="procInstId"]').first();
   			
    	clientSelect.select2({
	    	dropdownParent:$("#modal-addnew-task"),
	    	placeholder: "-- Please Select Client to Add Task for --",
	    	minimumInputLength: 1,　　						//最小查询参数
	    	multiple: false,								//多选设置
	    	data: iniClientData,							//初始化数据
	    	ajax: {
	    		url: base_url + "/tasks/getClients",
	    		dataType: "json",
	    		type: "POST",
	    		quietMillis: 500,							//延时查询毫秒数
	    		data: function (params) {
	    			return {
	    				sSearch: params.term,				//term为前台输入的查询关键字，保存到sSearch对象，
	    													//即后台保存关键字的对象
	    				start: params.page || 1,
	    				length: 20							//每次查询的结果数
	    			};
	    		},
	    		processResults: function (data, params) {
	    			var rdata = data.data.data;
	    			console.log("#modal-addnew-job client .select2 results data:"+JSON.stringify(rdata)+",params:"+JSON.stringify(params));
	    			var more = (params.page * 20) < rdata.recordsTotal;
	    			return {
	    				
	    				results: $.map(rdata, function(item){//results结果集，rdata为后台返回的查询结果

							return {
								text: item.name,
								id: item.id
							}
	    				}),
	 	    			more: more
	    			};
	    		}
	    	}
	    });
    			
    	jobSelect.select2({
	    	dropdownParent:$("#modal-addnew-task"),
	    	placeholder: "-- Please Select Job to Add Task for --",
	    	minimumInputLength: 1,　　						//最小查询参数
	    	multiple: false,								//多选设置
	    	data: iniJobData,								//初始化数据
	    	ajax: {
	    		url: base_url + "/tasks/getJobs",
	    		dataType: "json",
	    		type: "POST",
	    		quietMillis: 500,							//延时查询毫秒数
	    		data: function (params) {
	    			return {
	    				sSearch: params.term,				//term为前台输入的查询关键字，保存到sSearch对象，
	    													//即后台保存关键字的对象
	    				start: params.page || 1,
	    				length: 20,							//每次查询的结果数
	    				clientId: $("select[name='choseClient']").val() || "null"
	    			};
	    		},
	    		processResults: function (data, params) {
	    			var rdata = data.data.data;
	    			var pdata = data.data;
	    			console.log("#modal-addnew-task job .select2 results data:"+JSON.stringify(rdata)+",params:"+JSON.stringify(params));
	    			var more = (pdata.params.page * 20) < pdata.recordsTotal;
	    			return {
	    				
	    				results: $.map(rdata, function(item){//results结果集，rdata为后台返回的查询结果

							return {
								text: item.name,
								id: item.id
							}
	    				}),
	 	    			more: more
	    			};
	    		}
	    	}
	    });
    	
    	//step 3:
		if (selectedClientValue){
			console.log("设置选择客户的默认值");
			clientSelect.val([selectedClientValue]).trigger('change');
		}
		
		if (selectedJobValue){
			console.log("设置选择工作的默认值");
			jobSelect.val([selectedJobValue]).trigger('change');
		}

    }
    
    function oTableFresh(){
    	oTable.draw();
    	//setDataTableHeight(19);
    }
    
	function hide(v) {//参数：输入要隐藏的列数，要查第几列，我的是第一列和第二列，所以上面是hide(0)和hide(1)

        tr = $("#datatable tr").length;// 获取当前表格中行数
        var mark = 0; //要合并的单元格数
        var index = 0; //起始行数
        /*
         * 要合并单元格，需要存储两个参数，
         * 1，开始合并的单元格的第一行的行数，
         * 2.要合并的单元格的个数
         **/
        //判断 若只有一行数据，就是表头，则不做调整
        if (tr > 1) {
            //var i=1 比较当前的tr和上一个tr的值
            for (var i = 0; i < tr; i++) {
                var ford = $("#datatable tr:gt(0):eq(" + i + ") td:eq("+ parseInt(v) + ")").text();
                //根据下标获取单元格的值
                // tr:gt(0) 从下标0 开始获取
                // tr:gt(0):eq( i ) :i 标识 当前行的下标 ，0 开始
                // td:eq(0) 当前行的第一个单元格，下标从0开始
                var behind = $("#datatable tr:gt(0):eq(" + (parseInt(i) + 1)+ ") td:eq(" + parseInt(v) + ")").text();
                
                    if (ford != "" && ford == behind) {
                        $("#datatable tr:gt(0):eq(" + (parseInt(i) + 1)+ ") td:eq(" + parseInt(v) + ")").attr("class","remove");
                        mark = mark + 1;
                    } else if (ford != behind) {
                        index = i - mark;
                        $("#datatable tr:gt(0):eq(" + index + ") td:eq("+ parseInt(v) + ")").attr("rowspan",mark + 1);//将当前的行加入属性rowspan，合并 mark+1行
                        $("#datatable tr:gt(0):eq(" + index + ") td:eq("+ parseInt(v) + ")").attr("class","marge");
                        //rowspan 列上横跨， colspan 行上横跨
                        //后面的参数，表示横跨的单元格个数，
                        //合并单元格就是将其他的单元格隐藏（hide）,或删除（remove）。
                        //将一个单元格的rowspan 或colsspan 加大

                        mark = 0;
                }
            }
        }
    }

});