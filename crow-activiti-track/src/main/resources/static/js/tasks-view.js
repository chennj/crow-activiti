/**
 * Created by xuxueli on 17/4/24.
 */
$(function () {

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
     */
    $('#tree-clients-jobs').slimScroll({
    	height: treeHeight+'px'
    });    
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
    var tableMargin = 189;
    var tableHeight = bodyHeight - tableOffsetTop - footerHeight - tableMargin;
    console.log("$('#tasks-list').offset().top="+tableOffsetTop);
    console.log("tableHeight="+tableHeight);
    //初始化DataTable
	var dataTable = $("#data_list").dataTable({
		"deferRender": true,
		"processing" : true, 
	    "serverSide": true,
	    "scrollY": "calc(100vh - 377px)",
		"ajax": {
			url: base_url + "/tasks/taskPage",
	        data : function ( d ) {
				var obj = {};
				obj.start = d.start;
				obj.length = d.length;
				obj.jobId = $('#jobId').val();
				return obj;
            }
	    },
	    "searching": false,
	    "ordering": false,
	    //"scrollX": true,	// X轴滚动条，取消自适应
	    "columns": [
	                { data: 'id', bSortable: false,visible:false},
	                { data: 'name'},
					{ data: 'sysStatusId'},
            		{ data: 'spentTime'},
            		{ data: 'estimate'},
	                { data: 'overdueDate'},
	                { data: 'lastTrackingDate'},
	                { data: 'createTime'}
	            ],
		"language" : {
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
    // clients jobs addnew
    
    var lyIdx;

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
                    			'<li class="treeview" data-id="'+data.data.id+'" data-name="'+data.data.name+'">'+
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
                    				'<li class="treeview menu-open" data-id="'+rdata.client.id+'" data-name="'+rdata.client.name+'" style="display:block;">'+
	                    			'<a href="javascript:void(0)"><i class="fa fa-chevron-circle-right"></i>'+
	                    			rdata.client.name+
	                    			'</a>'+
	                    			'<ul class="treeview-menu" style="display:block;">'+
	                    				'<li  data-id="'+rdata.job.id+'" data-name="'+rdata.job.name+'">'+
	                    				'<a href="javascript:void(0)"><i class="fa fa-chevron-circle-right"></i>'+
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
                    				'<li data-id="'+rdata.job.id+'" data-name="'+rdata.job.name+'">'+
                    				'<a href="javascript:void(0)"><i class="fa fa-chevron-circle-right"></i>'+
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

    //加载clients
    $.post(base_url + "/tasks/getClients", function(data,status){
    	if (data.code == "200") {
    		var li = "";
    		var rdata = data.data.data;
    		console.log("data:"+JSON.stringify(rdata));
    		var len = rdata.length;
    		if (len>0){
    			li += '<li data-id="allclients data-name="allclients">'+
    				'<a href="javascript:void(0)"><i class="fa fa-chevron-circle-right"></i>'+
    				'All Clients </a></li>';
    		}
    		for (var i=0; i<len; i++){
    			li += '<li class="treeview" data-id="'+rdata[i].id+'" data-name="'+rdata[i].name+'">'+
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
    
    
    //add clients
    $(".choseUserBelong ul li").on("click",function(){
    	
    	$(this).closest(".btn-group").children("button").eq(0).text($(this).text());
    });
    
    /**
     * $("#tree-clients-jobs ul li a").on("click",function(){});
     * 这种写法时错误的，应为li a还没有生成，所以绑定不上事件
     */
    $("#tree-clients-jobs").on("click","ul li a",function(){
    	
    	$("#tree-clients-jobs ul li").removeClass("selected");
    	$(this).parent().addClass("selected");
    	console.log("li selected:"+$(this).parent());
    });
    
    /**
     * client（客户）树形列表展开事件
     */
    $('#tree-clients-jobs').on('click','ul li i.fa',function(){
    	
    	var clientId = $(this).closest('li').first().data("id");
    	var uiJobs = $(this).parent().siblings('ul').first();
    	
    	if ($(this).hasClass('fa-chevron-circle-right')){
    		$(this).removeClass('fa-chevron-circle-right').addClass('fa-chevron-circle-down');
    		if (uiJobs == null || $(uiJobs).children('li').length == 0){
    			$.post(base_url + "/tasks/job/all",{"clientId":clientId},function(data,status){
    				if (data.code == 200){
    					var rdata = data.data;
    					var ul = $('#tree-clients-jobs > ul > li[data-id="'+clientId+'"]').children('ul').first();
    					var li = '';
    					for (var i=0; i<rdata.length; i++){
    		    			li += 
                				'<li data-id="'+rdata[i].id+'" data-name="'+rdata[i].name+'">'+
                				'<a href="javascript:void(0)"><i class="fa fa-chevron-circle-right"></i>'+
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
    		$(this).removeClass('fa-chevron-circle-down').addClass('fa-chevron-circle-right');
    	}
    });

 
    $('#clients-jobs-addnew li a').on('click',function(){
    	switch($(this).parent('li').index()){
    	case 0:
    		lyIdx = layer.open({
    			type: 1,
    			title: 'Create New Client',
    			closeBtn: 1,
    			area:['50%','90%'],
    			shadeClose: true,
    			skin: 'layui-layer-rim',
    			content: $('#modal-addnew-client')
    			});
    		break;
    	case 2:
    		iniJobLayerSelect2();
    		lyIdx = layer.open({
    			type: 1,
    			title: 'Add new job',
    			closeBtn: 1,
    			area:['50%','90%'],
    			shadeClose: true,
    			skin: 'layui-layer-rim',
    			content: $('#modal-addnew-job')
    			});
    		break;
    	default:
    		break;
    	}
    });

    /**
     * 新增客户layer里面的select2的设置
     */
    $('#modal-addnew-client .select2').select2({dropdownParent:$("#modal-addnew-job")});

    /**
     * 新增工作layer里面的select2的设置
     */
    function iniJobLayerSelect2(){
    	var iniData=[];
    	
		$("#tree-clients-jobs ul li").each(function(){
			iniData.push({id:$(this).data("id"),text:$(this).data("name")});
		});
		
		console.log("job-layer select2 ini data:"+JSON.stringify(iniData));
    	
    	$('#modal-addnew-job .select2').select2({
	    	dropdownParent:$("#modal-addnew-job"),
	    	placeholder: "-- Please Select Client to Add Job for --",
	    	minimumInputLength: 1,　　						//最小查询参数
	    	multiple: false,								//多选设置
	    	data: iniData,									//初始化数据
	    	//current: function (element, callback){		//默认显示option的项
	    		/*
	    		var id = $(element).val();
	            if (id !== "") {
	                $.ajax("https://api.github.com/repositories/" + id, {
	                    dataType: "json"
	                }).done(function(data) { callback(data); });
	            }
	            */
	    		/*
	    		if ($("#tree-clients-jobs ul li").hasClass("selected")){
		    		var client = $("#tree-clients-jobs ul li.selected").eq(0);
		    		var defaultClient = {id:$(client).data("id"),text:$(client).data("name")};
		    		callback(defaultClient);
	    		}
	    		*/
	    		/*
	    		var data = [];
	            var currentVal = this.$element.val();

	            if (!this.$element.prop('multiple')) {
	                currentVal = [currentVal];
	            }

	            for (var v = 0; v < currentVal.length; v++) {
	                data.push({
	                    id: currentVal[v],
	                    text: currentVal[v]
	                });
	            }
	            console.log("#modal-addnew-job .select2 current mothed:"+JSON.stringify(data));
	            callback(data);
	            */
	    	//},
	    	ajax: {
	    		url: base_url + "/tasks/getClients",
	    		dataType: "json",
	    		type: "POST",
	    		quietMillis: 500,							//延时查询毫秒数
	    		data: function (params) {
	    			return {
	    				sSearch: params.term,						//term为前台输入的查询关键字，保存到sSearch对象，
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
    }
    

});

