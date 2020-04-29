/**
 * Created by xuxueli on 17/4/24.
 */
$(function () {
		
	var layerPrefix = "layui-layer";
	
	
	/**
	 * 页面加载时，需要初始化的数据
	 */
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
	
    //加载左边客户列表（client）
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
     * 左边treeview高度设置，计算它的高度使其能撑满屏幕
     */
    var bodyHeight = $(document.body).innerHeight();
    var leftPartHeight = $('#leftPart').outerHeight(true);
    var footerHeight = $('.main-footer').eq(0).outerHeight(true);
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

    /*
    console.log('treeHeight='+treeHeight+';'+
    		'bodyHeight='+bodyHeight+';'+
    		'mainHeaderHeight='+$('.main-header').eq(0).outerHeight(true)+';'+
    		'headerHeight='+ $('#main-content-header').outerHeight(true)+';'+
    		'leftPartHeight='+leftPartHeight+';'+
    		'footerHeight='+$('.main-footer').eq(0).outerHeight(true)+';'+
    		'contentMargin='+contentMargin+';pt,pb,mt,mb='+pt+','+pb+','+mt+','+mb)
    console.log("document.body-height()="+bodyHeight);
    console.log("-----------------------------")
    console.log("footerHeight="+footerHeight);
    console.log("treeHeight="+treeHeight);
    console.log("-----------------------------")
    console.log("leftPartHeight="+leftPartHeight);
    console.log("content-header-height="+$('.content-header').eq(0).outerHeight(true));
    console.log("contentp-padding-top"+$('.content').eq(0).css('padding-top'));
    console.log("contentp-padding-bottom"+$('.content').eq(0).css('padding-bottom'));
    console.log("contentp-margin-top"+$('.content').eq(0).css('margin-top'));
    console.log("contentp-margin-bottom"+$('.content').eq(0).css('margin-bottom'));
    console.log("leftPart-tree-padding="+$('#tree-clients-jobs').css("padding"));
    console.log("leftPart-tree-margin="+$('#tree-clients-jobs').css("margin"));
    console.log("leftPart-tree-height="+$('#tree-clients-jobs').outerHeight(true));
    console.log("leftPart-sub-1-padding="+$('#leftPart-sub-1').css("padding"));
    console.log("leftPart-sub-1-margin="+$('#leftPart-sub-1').css("margin"));
    console.log("leftPart-sub-1-height="+$('#leftPart-sub-1').outerHeight(true));
    console.log("leftPart-sub-2-padding="+$('#leftPart-sub-2').css("padding"));
    console.log("leftPart-sub-2-margin="+$('#leftPart-sub-2').css("margin"));
    console.log("leftPart-sub-2-height="+$('#leftPart-sub-2').outerHeight(true));
    console.log("-----------------------------")
    */

    /*
    var txtTmp = 
    	'<ul class="nav nav-pills nav-stacked clients-jobs-list" data-widget="tree">'+
    		'<li><a href="mailbox.html"><i class="fa fa-inbox"></i> Inbox'+
		    '<span class="label label-primary pull-right">12</span></a></li>'+
            '<li class="treeview">'+
            '<a href="#">'+
            '  <i class="fa fa-dashboard"></i> <span>Dashboard</span>'+
            '  <span class="pull-right-container">'+
            '    <i class="fa fa-asterisk pull-right"></i>'+
            '  </span>'+
            '</a>'+
            '<ul class="treeview-menu">'+
            '  <li><a href="../../index.html"><i class="fa fa-circle-o"></i> Dashboard v1</a></li>'+
            '  <li><a href="../../index2.html"><i class="fa fa-circle-o"></i> Dashboard v2</a></li>'+
            '</ul></li>'+
		    '<li><a href="#"><i class="fa fa-envelope-o"></i> Sent</a></li>'+
		  	'<li><a href="#"><i class="fa fa-file-text-o"></i> Drafts</a></li>'+
		  	'<li><a href="#"><i class="fa fa-filter"></i> Junk <span class="label label-warning pull-right">65</span></a>'+
		  	'</li>'+
		  	'<li><a href="#"><i class="fa fa-trash-o"></i> Trash</a></li>'+
            '<li><a href="#"><i class="fa fa-circle-o text-red"></i> Important</a></li>'+
            '<li><a href="#"><i class="fa fa-circle-o text-yellow"></i> Promotions</a></li>'+
            '<li><a href="#"><i class="fa fa-circle-o text-light-blue"></i> Social</a></li>'+
            '<li><a href="https://adminlte.io/docs"><i class="fa fa-book"></i> <span>Documentation</span></a></li>'+
            '<li><a href="#"><i class="fa fa-circle-o text-red"></i> <span>Important</span></a></li>'+
            '<li><a href="#"><i class="fa fa-circle-o text-yellow"></i> <span>Warning</span></a></li>'+
            '<li><a href="#"><i class="fa fa-circle-o text-aqua"></i> <span>Information</span></a></li>'+
		'</ul>';
		
	测试即时搜索的动态改变数据
    $('#button-property-set-left').click(function(){
    	
    	var text = '<ul class="nav nav-pills nav-stacked clients-jobs-list" data-widget="tree">'+
          '<li>Bootstrap</li>'+
          '<li>Fbootstrapp</li>'+
          '<li>BootMetro</li>'+
          '<li>Kickstrap</li>'+
          '<li>Foundation</li>'+
          '<li>GroundworkCSS</li>'+
          '<li>Gumby</li>'+
          '<li>HTML KickStart</li>'+
          '<li>IVORY</li>'+
          '<li>Kube</li>'+
        '</ul>';
    	
    	$('#tree-clients-jobs').html('');
    	$('#tree-clients-jobs').append(text);
    	$('#input-search-clients-jobs').hideseek();
    });
    $('#tree-clients-jobs ul').append(txtTmp);
	*/
    
    /**
     * 滚动条设置
     * 暂时不用漂亮滚动条了，和其他的部件保持一致
     */
    //$('#tree-clients-jobs').slimScroll({
    //	height: treeHeight+'px'
    //});   
    $('#tree-clients-jobs').css("height",treeHeight+'px');
    $('#tree-clients-jobs').css("background-color","#f3f5f9");
    
    //即时搜索
    $('#input-search-clients-jobs').hideseek({
    	highlight: true
    });
    
    /**
     * 任务（tasks）列表展示，
     */
    // 计算data table高度
    var tableOffsetTop = $('#tasks-list').offset().top;
    var tableMargin = 1;
    var tableHeight = bodyHeight - tableOffsetTop - footerHeight - tableMargin;
    
    $('#tasks-list').parent().css("height",tableHeight+"px");
    
    console.log("$('#tasks-list').offset().top="+tableOffsetTop);
    console.log("tableHeight="+tableHeight);
    //初始化DataTable
	var taskDataTable = $("#data_list").dataTable({
		deferRender: true,
		processing : true, 
	    serverSide: true,
	    scrollY: "calc(100vh - 377px)",
		ajax: {
			url: base_url + "/tasks/getTasks",
	        data : function ( d ) {
				var obj = {};
				obj.start = d.start;
				obj.length = d.length;
				obj.jobId = $('#jobId').val();
				return obj;
            }
	    },
	    searching: false,
	    ordering: false,

	    columns: [
	                { data: 'id', bSortable: false,visible:false},
	                { data: 'name'},
					{ data: 'sysStatusId'},
            		{ data: 'spentTime'},
            		{ data: 'estimate'},
	                { data: 'overdueDate'},
	                { data: 'lastTrackingDate'},
	                { data: 'createTime'}
	            ],
		language : {
			"sProcessing" : "working hard...",
			"sUrl" : "",
			"sEmptyTable" : "not data",
			"sLoadingRecords" : "loading...",
		}
	});

	
    // table data
    var taskTableData = {};

    // search btn
	$('#search-tasks').on('click', function(){
		taskDataTable.fnDraw();
	});
   
	/**
	 * Add New 三个弹层的提交检查初始化
	 * 新增客户，新增工作，新增任务
	 */
	// 新增客户
    var modalAddnewClientValidate = $("#modal-addnew-client form").validate({
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
                            //dataTable.fnDraw(false);
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
 
    // 新增工作
    var modalAddnewJobValidate = $("#modal-addnew-job form").validate({
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
                            //dataTable.fnDraw(false);
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

    // 新增任务
    var modalAddnewTaskValidate = $("#modal-addnew-task form").validate({
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
			if (procInstId==null || procInstId.trim().length == 0){
				layer.msg("Please one job", {icon: 2});
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
					taskDataTable.fnDraw();
					
					layer.msg(data.msg || "Operator complete", {icon: 2});
					
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
    
    //add clients
    $(".choseUserBelong ul li").on("click",function(){
    	
    	$(this).closest(".btn-group").children("button").eq(0).text($(this).text());
    });
    
    /**
     * $("#tree-clients-jobs ul li a").on("click",function(){});
     * 这种写法时错误的，应为li a还没有生成，所以绑定不上事件
     * client（客户）树形列表展开事件
     */
    $('#tree-clients-jobs').on('click','ul li a',function(){

    	$("#tree-clients-jobs ul li").removeClass("selected");
    	$(this).parent().addClass("selected");

    	var type = $(this).parent().data('type');
    	if ('job' == type){
    		return;
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

    /**
     * 使用layer增删改查
     */
    /* 使用示例
	layer.alert('墨绿风格，点击确认看深蓝', {
	      skin: 'layui-layer-molv', //样式类名  自定义样式
	      closeBtn: 1,    // 是否显示关闭按钮
	      anim: 1, //动画类型
	      btn: ['重要','奇葩','提交'], //按钮
	      icon: 6,    // icon
	      yes:function(){                //点击确定的回调函数
	          layer.msg('按钮1')
	      },
	      btn2:function(){               //取消的回调函数
	    	  layer.msg('按钮2')
	      },
	      btn3:function(){
	    	  layer.msg('按钮3')
	      }
	    });
	     
		关闭layer当前弹窗
		一、 layer关闭弹出层方法
		1-1） 先获取某个弹出层的 index
		
		 
		var index = layer.open();
		 
		var index = layer.alert();
		 
		var index = layer.load();
		 
		var index = layer.tips();
		1-2） 关闭弹出层
		
		layer.close(index);
		二、 layer关闭当前弹出层的方法
		
		layer.close(layer.index);
		 
		这个也是layer关闭顶层弹出层的方法
	*/
    var lyIdx;
    $('#clients-jobs-addnew li a').on('click',function(){
    	switch($(this).parent('li').index()){
    	case 0:
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
    		iniJobLayerSelect2();
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
    		iniTaskLayerSelect2();
    		   		
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

    /**
     * 初始化一些事件
     * 
     */
    /* --------------------新增任务（task）弹窗中的 ---------------*/
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
    
    // del row
    $("#modal-addnew-task").on("click",".delTr",function(){
    	if ($(this).closest("tbody").children("tr").length == 1){
    		layer.msg("last one can't be del",this);
    	} else {
    		$(this).closest("tr").remove();
    	}
    });
    
    // work type list
    /*
    $(document).on("click",":not(#modal-addnew-task-type-list,#modal-addnew-task input[name='workType'])",function(){
    	$("#modal-addnew-task-type-list").hide();
    });
    $("#modal-addnew-task").on("click","#modal-addnew-task-type-list,input[name='workType']",function(event){
    	$("#modal-addnew-task-type-list").css("display","block");
    	event.stopPropagation();
    });
    */
    var lyIdxOfTaskTypeList
    var prevInputWorkType;
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
    
    /**
     * 初始化一些组件
     * 提示框,check box, date picker,...
     */   
    /* -----------------------select2----------------------------*/
    //新增客户(client)layer里面的select2的设置
    $('#modal-addnew-client .select2').select2({dropdownParent:$("#modal-addnew-job")});

    //新增工作(job)layer里面的select2的设置
    function iniJobLayerSelect2(){
    	
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
    
  //新增任务(task)layer里面的select2的设置
    function iniTaskLayerSelect2(){
    	
    	/**
    	 * 给client 和 job select2设置默认值
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

    /* ------------------------- tips -----------------------------*/
    $(".layer-tip").on("mouseover",function(){
    	layer.tips($(this).data("tip"),this);
    })
    
    /* ------------------------- check box ------------------------*/
    //Enable check and uncheck all functionality
    $(".checkbox-toggle").on("click",function () {
    	var clicks = $(this).data('clicks');
    	if (clicks) {
    		//Uncheck all checkboxes
    		$(".table-addnew-tasks input[type='checkbox']").iCheck("uncheck");
    		$(".fa", this).removeClass("fa-check-square-o").addClass('fa-square-o');
    	} else {
    		//Check all checkboxes
    		$(".table-addnew-tasks input[type='checkbox']").iCheck("check");
    		$(".fa", this).removeClass("fa-square-o").addClass('fa-check-square-o');
    	}
    	$(this).data("clicks", !clicks);
    });
    
    /* ------------------------- datepicker ------------------------*/
    $('.date input[type="text"]').datepicker({
    	autoclose: true
	});

});

