<!DOCTYPE html>
<html>
<head>
  	<#import "/common/common.macro.ftl" as netCommon>
    <title>Activiti Time Track</title>
	<@netCommon.commonStyle />
    <!-- daterangepicker -->
    <link rel="stylesheet" href="${request.contextPath}/static/adminlte/bower_components/bootstrap-daterangepicker/daterangepicker.css">
    <!-- bootstrap-treeview -->
    <link rel="stylesheet" href="${request.contextPath}/static/adminlte/plugins/bootstrap-treeview/bootstrap-treeview.css">
	<!-- datatables -->
	<!-- link rel="stylesheet" href="${request.contextPath}/static/adminlte/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css"-->
	<!-- link rel="stylesheet" href="${request.contextPath}/static/plugins/datatables/datatables.min.css"-->
	<!-- select2 -->
	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/bower_components/select2/css/select2.min.css">
	<!-- icheck -->
	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/plugins/iCheck/square/blue.css">
	<!-- bootstrap datepicker -->
	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
	<style>
	.panel{
		margin-bottom:0px;
		border-radius:0px;
	}
	.bg-light-blue{
		/*background-color:rgb(235, 245, 255)!important;*/
		background-color:#f3f5f9!important;
	}
	
	#tree-clients-jobs > .nav ul {background-color:#f3f5f9;}
	#tree-clients-jobs > .nav li a {color:black;}
	#tree-clients-jobs > .nav li > ul {padding-left:0px;}
	#tree-clients-jobs > .nav li > ul > li > a{padding-left:36px;}
	#tree-clients-jobs > .nav > li > a:hover,
	#tree-clients-jobs > .nav > li > a:active,
	#tree-clients-jobs > .nav > li > a:focus,
	#tree-clients-jobs > .nav > li > ul > li > a:hover,
	#tree-clients-jobs > .nav > li > ul > li > a:active,
	#tree-clients-jobs > .nav > li > ul > li > a:focus {
	  	color: white;
	  	background:#3c8dbc;
	}
	#tree-clients-jobs >.nav > li.selected,
	#tree-clients-jobs >.nav > li > ul > li.selected{
	  	background:gray;
	}
		
	/*
	.wrapper>.content-wrapper>section.content{
		padding-bottom:	0px;
		}
	*/
	.select2-job-position{margin-left:10%;width:90%;}
	body .demo-class .layui-layer-title{background:#ccc; color:#fff; border: none;}
	body .task-type-class .layui-layer-title{background:#ccc; color:#fff; border: none;}
	
	body .dataTables_scrollBody{height: calc(100vh - 349px);}
	</style>
	
</head>
<body class="hold-transition skin-blue fixed sidebar-mini <#if cookieMap?exists && cookieMap["xxlmq_adminlte_settings"]?exists && "off" == cookieMap["xxlmq_adminlte_settings"].value >sidebar-collapse</#if> ">
<div class="wrapper">
	<!-- header -->
	<@netCommon.commonHeader />
	<!-- left -->
	<@netCommon.commonLeft "tasks" />
	
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<section class="content-header" id="main-content-header">
			<h1>Tasks Manager</h1>
			<ol class="breadcrumb">
        		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        		<li class="active">Tasks</li>
      		</ol>
		</section>

		<!-- Main content -->
		<section class="content" id="main-content">
			
            <!-- 任务管理-->
            <div class="row">
				
				<!-- client and job -->
                <div class="col-sm-4" id="leftPart">
                	<div class="row">
                		<div class="panel panel-default bg-light-blue" id="leftPart-sub-1">
                		<div class="panel-body">
	               			<button type="button" class="btn btn-primary btn-flat col-sm-6"><i class="fa fa-fw fa-angle-double-left"></i>Clients & Jobs</button>                		
							<div class="input-group-btn">
	 						  	<button type="button" class="btn btn-primary btn-flat dropdown-toggle pull-right" data-toggle="dropdown">
								  	<span class="glyphicon glyphicon-plus"></span>Add New
								    <span class="fa fa-caret-down"></span>
							    </button>
							  	<ul class="dropdown-menu" id="clients-jobs-addnew">
								    <li><a href="#"><span class="glyphicon glyphicon-align-justify"></span>+ New Client</a></li>
								    <li class="divider"></li>
								    <li><a href="#"><span class="glyphicon glyphicon-align-justify"></span>+ New Job</a></li>
								    <li class="divider"></li>
								    <li><a href="#"><span class="glyphicon glyphicon-align-justify"></span>+ New Tasks</a></li>
								    <li class="divider"></li>
								    <li><a href="#"><span class="glyphicon glyphicon-align-justify"></span>Import Tasks From XLS</a></li>
							  	</ul>
							</div>
						</div>
						<div class="panel-body">
	                		<!-- search -->
						  	<div class="input-group">
						    	<input type="text" id="input-search-clients-jobs" name="input-search-clients-jobs" 
						    	class="form-control" placeholder="Search..." 
						    	data-list=".clients-jobs-list" autocomplete="off"/>
						    	<span class="input-group-btn">
						          	<button type="button" name="search" id="search-clients-jobs" class="btn btn-flat"><i class="fa fa-search"></i>
						          	</button>
						        </span>
						  	</div>
	                	</div>
                		</div>
                	</div>
                	
                	<!-- 结果集属性设置 -->
                	<div class="row">
                		<div class="panel panel-default bg-light-blue" id="leftPart-sub-2">
                		<div class="panel-body">
                		<div class="btn-group-horizontal">
							<button type="button" class="btn btn-primary btn-flat"><i class="fa fa-align-left" id="button-property-set-left"></i></button>
                      		<button type="button" class="btn btn-primary btn-flat"><i class="fa fa-align-center"></i></button>
                      		<button type="button" class="btn btn-primary btn-flat"><i class="fa fa-align-right"></i></button>
                		</div>
                		</div>
                		</div>
                	</div>
                	
                	<!-- 需要搜索的结果集 -->
                	<div class="row">
                		<div id="tree-clients-jobs" style="height:auto;overflow-y:auto;">
                		<ul class="nav nav-pills nav-stacked clients-jobs-list" data-widget="tree">
                		<!-- ul class="nav nav-pills nav-stacked clients-jobs-list"-->
                		</ul>
                		</div>
                	</div>
                </div>
                
                <!-- tasks -->
                <div class="col-sm-8">
                	<div class="row">
                		<div class="panel panel-default">
                		<div class="panel-body">
							<div class="col-sm-6 lead"><label class="taskDataTable-header"></label>
							<input type="hidden" id="clientorjobid" value=""/>
							<input type="hidden" id="clientorjob" value=""/>
							</div>
                			<!-- search -->
                			<div class="col-sm-6">
						  	<div class="input-group">
						    	<input type="text" name="search-tasks-text" class="form-control" placeholder="Search...">
						    	<span class="input-group-btn">
						          	<button type="button" name="search" id="search-tasks" class="btn btn-flat"><i class="fa fa-search"></i>
						          	</button>
						        </span>
						  	</div> 
						  	</div>         			
                		</div>
                		</div>
                	</div>
                	
                	<div class="row">
                	
                		<div class="panel panel-default" id="tasks-list-panel">
                		<div class="panel-body">
                		
						<table id="tasks-list" class="table table-bordered table-hover table-striped" style="width:auto;">
						<thead>							
						  	<tr>
						  		<th name="id"></th>
						  		<th name="clientName">Client</th>
							    <th name="jobName">Job</th>
							    <th name="name">Task</th>
							    <th name="sysStatusName">Status</th>
							    <th name="spentTime">Spent Time</th>
							    <th name="estimate">Estimate</th>
							    <th name="overdueDate">Deadline</th>
							    <th name="lastTrackingDate">Last Tracking Date</th>
							    <th name="createTime">Creation Date</th>
						  	</tr>
						</thead>
		                <tbody>
		                </tbody>
		                <tfoot></tfoot>
						</table>  
						
						</div>        	
                		</div>
                	</div>
                </div>

            </div>
		</section>
		<!-- /.content -->
	</div>
	<!-- /.content-wrapper -->
	
	<!-- footer -->
	<@netCommon.commonFooter />
</div>

<@netCommon.commonScript />

<!-- bootstrap-treeview -->
<script src="${request.contextPath}/static/adminlte/plugins/bootstrap-treeview/bootstrap-treeview.js"></script>
<!-- 滚动条 -->
<!-- script src="${request.contextPath}/static/adminlte/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script-->
<!-- datatables -->
<!--
<script src="${request.contextPath}/static/adminlte/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${request.contextPath}/static/adminlte/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script src="${request.contextPath}/static/plugins/datatables/datatables.js"></script>
-->
<!-- select2 -->
<script src="${request.contextPath}/static/adminlte/bower_components/select2/js/select2.min.js"></script>
<!-- valid -->
<script src="${request.contextPath}/static/plugins/jquery/jquery.validate.min.js"></script>
<!-- 即时搜索 -->
<script src="${request.contextPath}/static/plugins/hideseek/jquery.hideseek.js"></script>
<!-- icheck -->
<script src="${request.contextPath}/static/adminlte/plugins/iCheck/icheck.min.js"></script>
<!-- bootstrap datepicker -->
<script src="${request.contextPath}/static/adminlte/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>

<!-- tasks-view -->
<script src="${request.contextPath}/static/js/tasks-view.js"></script>

</body>

<!-- 新增Client弹窗 -->
<div class="box box-success" id="modal-addnew-client" style="display:none;">
<div class="col-md-12">
	<form role="form">
		<ul id="myTab" class="nav nav-tabs">
		<!-- ul id="myTab" class="nav nav-pills" role="tablist"-->
		    <li class="active"><a href="#client-details" role="tab" data-toggle="tab">DETAILS</a></li>
		    <li><a href="#client-assignedUsers" role="tab" data-toggle="tab">ASSIGNED USERS</a></li>
		    <li><a href="#client-managers" role="tab" data-toggle="tab">MANAGERS</a></li>
		</ul>	
		<div id="addNewClient" class="tab-content">
			<!-- details -->
		    <div class="tab-pane fade in active" id="client-details">
		    	<div class="col-md-12">
				    <div class="form-group">
				   		<label for="name">Client Name</label>
				        <input type="text" class="form-control" name="name" placeholder="Enter Client Name" maxlength="220" >
				    </div>
			        <div class="form-group">
			          	<label for="desc">Description</label>
			          	<textarea class="form-control" rows="6" name="desc" placeholder="Enter ..."></textarea>
			        </div>
				    <div class="form-group">
				        <label for="ClientCopy" class="control-label">Copy Jobs from an Existing Client:</label>
			            <select class="form-control select2" style="width: 100%;" name="ClientCopy">
			                <option></option>
			            </select>
				    </div>		
			    </div>    
			</div>
			<!-- assigned users -->
		    <div class="tab-pane fade" id="client-assignedUsers">
			    <div class="form-horizontal form-group">
			    	<span class="col-sm-5" style="padding-top:4px;"><strong>Can enter time-track for this client ():</strong></span>
				    <div class="col-sm-7">
				    	<label for="userBelong">View by:</label>
						<div class="btn-group choseUserBelong">
						  	<button type="button" class="btn btn-flat btn-default">Action</button>
						  	<button type="button" class="btn btn-flat btn-default dropdown-toggle" data-toggle="dropdown">
						    	<span class="caret"></span>
						    	<span class="sr-only"></span>
						  	</button>
						  	<ul class="dropdown-menu" role="menu">
							    <li><a href="javascript:void(0);">Department</a></li>
							    <li><a href="javascript:void(0);">Time Zone Group</a></li>
						  	</ul>
						</div>
				    	<button type="button" class="btn btn-flat btn-primary" ><i class="fa fa-plus"></i> <span>AddNew</span></button>
				    </div>
			    </div>
			    <div class="col-sm-12"><hr/></div>
			    <span class="col-sm-12">()managers can track time to this client</span>
		    </div>
		    <!-- managers -->
		    <div class="tab-pane fade" id="client-managers">
			    <div class="form-horizontal form-group">
			    	<div class="col-sm-5" style="padding-top:4px;"><strong>Managers of this client ():</strong></div>
				    <div class="col-sm-7">
				    	<label for="managerOfClient">View by:</label>
						<div class="btn-group choseUserBelong">
						  	<button type="button" class="btn btn-flat btn-default">Action</button>
						  	<button type="button" class="btn btn-flat btn-default dropdown-toggle" data-toggle="dropdown">
						    	<span class="caret"></span>
						    	<span class="sr-only"></span>
						  	</button>
						  	<ul class="dropdown-menu" role="menu">
							    <li><a href="javascript:void(0);">Department</a></li>
							    <li><a href="javascript:void(0);">Time Zone Group</a></li>
						  	</ul>
						</div>
				    	<button type="button" class="btn btn-flat btn-primary" ><i class="fa fa-plus"></i> <span>AddNew</span></button>
				    </div>
			    </div>
			    <div class="col-sm-12">
		          	<div class="box">
		            <div class="box-header">
		              	<h3 class="box-title">USERS WITHOUT DEPARTMENT</h3>
		            </div>
		            <!-- /.box-header -->
		            <div class="box-body table-responsive no-padding">
		              	<table class="table table-hover">
		                <tr>
		                  	<th>User ID</th>
		                  	<th>Manager Scope</th>
		                  	<th>Operator</th>
		                </tr>
		                <tr>
		                  	<td>183</td>
		                  	<td>John Doe</td>
		                  	<td>
		                  		<i class="fa fa-user-plus"></i>
		                  		<i class="fa fa-edit"></i>
		                  		<i class="fa fa-list-alt"></i>
		                  		<i class="fa fa-money"></i>
		                  	</td>
		              	</tr>
		                <tr>
		                  	<td>219</td>
		                  	<td>Alexander Pierce</td>
		                  	<td>
		                  		<i class="fa fa-user-plus"></i>
		                  		<i class="fa fa-edit"></i>
		                  		<i class="fa fa-list-alt"></i>
		                  		<i class="fa fa-money"></i>
		                  	</td>
		                </tr>
		                <tr>
		                  	<td>657</td>
		                  	<td>Bob Doe</td>
		                  	<td>
		                  		<i class="fa fa-user-plus"></i>
		                  		<i class="fa fa-edit"></i>
		                  		<i class="fa fa-list-alt"></i>
		                  		<i class="fa fa-money"></i>
		                  	</td>
		                </tr>
		                <tr>
		                  	<td>175</td>
		                  	<td>Mike Doe</td>
		                  	<td>
		                  		<i class="fa fa-user-plus"></i>
		                  		<i class="fa fa-edit"></i>
		                  		<i class="fa fa-list-alt"></i>
		                  		<i class="fa fa-money"></i>
		                  	</td>
		                </tr>
		              	</table>
		            </div>
		            <!-- /.box-body -->
		          	</div>
		          	<!-- /.box -->
		        </div>
		    </div>
		</div>
	    <div class="form-group">
	        <div class="col-sm-offset-3 col-sm-9">
	            <button type="submit" class="btn btn-primary"><i class="fa fa-plus"></i> <span>Create Client</span></button>
	            <button type="button" class="btn btn-default">Cancel</button>
	        </div>
	    </div>
	</form>
</div>
</div>
<!-- /.box-body -->

<!-- 新增Job弹窗 -->
<div class="box box-success " id="modal-addnew-job" style="display:none;">
<div class="col-md-12">
	<form role="form">
		<ul id="myTab" class="nav nav-tabs">
		    <li class="active"><a href="#job-details" role="tab" data-toggle="tab">DETAILS</a></li>
		    <li><a href="#job-assignedUsers" role="tab" data-toggle="tab">ASSIGNED USERS</a></li>
		    <li><a href="#job-managers" role="tab" data-toggle="tab">MANAGERS</a></li>
		</ul>	
		<div id="addNewClient" class="tab-content">
			<!-- details -->
		    <div class="tab-pane fade in active" id="job-details">
		    	<div class="col-md-12">
				    <div class="form-group">
				   		<label for="name">Job Name</label>
				        <input type="text" class="form-control" name="name" placeholder="Enter Job Name" maxlength="220" >
				    </div>
				    <div class="form-group">
				        <label for="businessKey" class="control-label">Client:</label>
			            <select class="form-control select2" style="width: 100%;" name="businessKey" >
			            	<option></option>
			            </select>
				    </div>				        
				    <div class="form-group">
			          	<label for="desc">Description</label>
			          	<textarea class="form-control" rows="3" name="desc" placeholder="Enter ..."></textarea>
			        </div>	
			    </div>    
			    <div class="col-sm-12">
		          	<div class="box">
		            <div class="box-header">
		              	<span class="box-title">Add Tasks</span>
		            </div>
		            <!-- /.box-header -->
		            <div class="box-body table-responsive no-padding">
		              	<table class="table table-hover">
		                <tr>
		                  	<th>User ID</th>
		                  	<th>Manager Scope</th>
		                  	<th>Operator</th>
		                </tr>
		                <tr>
		                  	<td>183</td>
		                  	<td>John Doe</td>
		                  	<td>
		                  		<i class="fa fa-user-plus"></i>
		                  		<i class="fa fa-edit"></i>
		                  		<i class="fa fa-list-alt"></i>
		                  		<i class="fa fa-money"></i>
		                  	</td>
		              	</tr>
		                <tr>
		                  	<td>219</td>
		                  	<td>Alexander Pierce</td>
		                  	<td>
		                  		<i class="fa fa-user-plus"></i>
		                  		<i class="fa fa-edit"></i>
		                  		<i class="fa fa-list-alt"></i>
		                  		<i class="fa fa-money"></i>
		                  	</td>
		                </tr>
		                <tr>
		                  	<td>657</td>
		                  	<td>Bob Doe</td>
		                  	<td>
		                  		<i class="fa fa-user-plus"></i>
		                  		<i class="fa fa-edit"></i>
		                  		<i class="fa fa-list-alt"></i>
		                  		<i class="fa fa-money"></i>
		                  	</td>
		                </tr>
		                <tr>
		                  	<td>175</td>
		                  	<td>Mike Doe</td>
		                  	<td>
		                  		<i class="fa fa-user-plus"></i>
		                  		<i class="fa fa-edit"></i>
		                  		<i class="fa fa-list-alt"></i>
		                  		<i class="fa fa-money"></i>
		                  	</td>
		                </tr>
		              	</table>
		            </div>
		            <!-- /.box-body -->
		          	</div>
		          	<!-- /.box -->
		        </div>
			</div>
			<!-- assigned users -->
		    <div class="tab-pane fade" id="job-assignedUsers">
			    <div class="form-horizontal form-group">
			    	<span class="col-sm-5" style="padding-top:4px;"><strong>Can enter time-track for this client ():</strong></span>
				    <div class="col-sm-7">
				    	<label for="userBelong">View by:</label>
						<div class="btn-group choseUserBelong">
						  	<button type="button" class="btn btn-flat btn-default">Action</button>
						  	<button type="button" class="btn btn-flat btn-default dropdown-toggle" data-toggle="dropdown">
						    	<span class="caret"></span>
						    	<span class="sr-only"></span>
						  	</button>
						  	<ul class="dropdown-menu" role="menu">
							    <li><a href="javascript:void(0);">Department</a></li>
							    <li><a href="javascript:void(0);">Time Zone Group</a></li>
						  	</ul>
						</div>
				    	<button type="button" class="btn btn-flat btn-primary" ><i class="fa fa-plus"></i> <span>AddNew</span></button>
				    </div>
			    </div>
			    <div class="col-sm-12"><hr/></div>
			    <span class="col-sm-12">()managers can track time to this client</span>
		    </div>
		    <!-- managers -->
		    <div class="tab-pane fade" id="job-managers">
			    <div class="form-horizontal form-group">
			    	<div class="col-sm-5" style="padding-top:4px;"><strong>Managers of this client ():</strong></div>
				    <div class="col-sm-7">
				    	<label for="managerOfClient">View by:</label>
						<div class="btn-group" id="managerOfClient">
						  	<button type="button" class="btn btn-flat btn-default">Action</button>
						  	<button type="button" class="btn btn-flat btn-default dropdown-toggle" data-toggle="dropdown">
						    	<span class="caret"></span>
						    	<span class="sr-only"></span>
						  	</button>
						  	<ul class="dropdown-menu" role="menu">
							    <li><a href="javascript:void(0);">Department</a></li>
							    <li><a href="javascript:void(0);">Time Zone Group</a></li>
						  	</ul>
						</div>
				    	<button type="button" class="btn btn-flat btn-primary" ><i class="fa fa-plus"></i> <span>AddNew</span></button>
				    </div>
			    </div>
			    <div class="col-sm-12">
		          	<div class="box">
		            <div class="box-header">
		              	<h3 class="box-title">USERS WITHOUT DEPARTMENT</h3>
		            </div>
		            <!-- /.box-header -->
		            <div class="box-body table-responsive no-padding">
		              	<table class="table table-hover">
		                <tr>
		                  	<th>User ID</th>
		                  	<th>Manager Scope</th>
		                  	<th>Operator</th>
		                </tr>
		                <tr>
		                  	<td>183</td>
		                  	<td>John Doe</td>
		                  	<td>
		                  		<i class="fa fa-user-plus"></i>
		                  		<i class="fa fa-edit"></i>
		                  		<i class="fa fa-list-alt"></i>
		                  		<i class="fa fa-money"></i>
		                  	</td>
		              	</tr>
		                <tr>
		                  	<td>219</td>
		                  	<td>Alexander Pierce</td>
		                  	<td>
		                  		<i class="fa fa-user-plus"></i>
		                  		<i class="fa fa-edit"></i>
		                  		<i class="fa fa-list-alt"></i>
		                  		<i class="fa fa-money"></i>
		                  	</td>
		                </tr>
		                <tr>
		                  	<td>657</td>
		                  	<td>Bob Doe</td>
		                  	<td>
		                  		<i class="fa fa-user-plus"></i>
		                  		<i class="fa fa-edit"></i>
		                  		<i class="fa fa-list-alt"></i>
		                  		<i class="fa fa-money"></i>
		                  	</td>
		                </tr>
		                <tr>
		                  	<td>175</td>
		                  	<td>Mike Doe</td>
		                  	<td>
		                  		<i class="fa fa-user-plus"></i>
		                  		<i class="fa fa-edit"></i>
		                  		<i class="fa fa-list-alt"></i>
		                  		<i class="fa fa-money"></i>
		                  	</td>
		                </tr>
		              	</table>
		            </div>
		            <!-- /.box-body -->
		          	</div>
		          	<!-- /.box -->
		        </div>
		    </div>
		</div>
	    <div class="form-group">
	        <div class="col-sm-offset-3 col-sm-9">
	            <button type="submit" class="btn btn-primary"><i class="fa fa-plus"></i> <span>Create Client</span></button>
	            <button type="button" class="btn btn-default">Cancel</button>
	        </div>
	    </div>
	</form>
</div>
</div>
<!-- /.box-body -->

<!-- 新增Task弹窗 -->
<div class="box box-success" id="modal-addnew-task" style="display:none;">
<div class="col-md-12">
	<form role="form">
		<div class="row">
		<div class="col-sm-12">
			<h5 class="text-light-blue">Select Client and Job to Add Tasks for</h5>
		    <div class="form-group">
	            <select class="form-control select2" style="width: 100%;" name="choseClient" >
	            	<option></option>
	            </select>
		    </div>
		    <div class="form-group" style="position:relative;">
		    	<span style="position:absolute; left:0.5%;top:-13px; height:33px;border-left: 1px solid gray;"></span>
		    	<span style="position:absolute; left:0.5%;top:20px; width:9%; border-bottom: 1px solid gray;"></span>
		    	<div class="select2-job-position">
		    	<select class="form-control select2" name="procInstId" style="width:100%">
	            	<option></option>
	            </select>
	            </div>
		    </div>
		</div>
		</div>
		<div class="row">
			<span class="col-sm-7">New Tasks</span>
			<span class="col-sm-5 text-light-blue pull-right">Copy properties from existing tasks</span>
		</div>
		<div class="no-padding tabel-wrapper-scroll" style="height:auto;overflow-y:scroll; ">
		<table class="table table-hover table-addnew-row">
		<thead>
			<tr>
			  <th width="40%">Task Name</th>
			  <th width="15%">Estimate<i class="fa fa-info-circle layer-tip" data-tip="asdfasd"></i></th>
			  <th width="20%">Deadline</th>
			  <th width="15%">Type of Work</th>
			  <th width="10%">
			  	<button type="button" class="btn btn-default btn-sm checkbox-toggle"><i class="fa fa-square-o"></i>
                </button>
              </th>
			</tr>
		</thead>
		<tbody>
			<tr class="trDefault">
		  	<td>
			  	<div class="input-group input-group-sm">
					<input type="text" name="name" class="form-control" placeholder="Enter Task Name">
					<span class="input-group-btn">
					  	<button type="button" class="btn btn-info btn-flat dropdown-toggle" data-toggle="dropdown"><i class="fa fa-align-left"></i></button>
					  	<ul class="dropdown-menu" role="menu">
						    <li><textarea rows="6" cols="30" name="desc"></textarea></li>
					  	</ul>					  	
					</span>			  	
			  	</div>
		  	</td>
			<td>
			  	<div class="input-group input-group-sm ">		  	
					<input type="text" name="estimate" class="form-control" placeholder="no needed">		  	
			  	</div>
			</td>
			<td>
			  	<div class="input-group input-group-sm date">
                  	<div class="input-group-addon">
                    <i class="fa fa-calendar"></i>
                  	</div>				  	
					<input type="text" name="deadline" class="form-control" placeholder="set deadline">		  	
			  	</div>
			</td>
			<td>
			  	<div class="input-group input-group-sm">			  	
					<input type="text" name="workType" class="form-control" data-systypeid="" value="">  	
			  	</div>
			</td>
			<td>
				<div class="input-group">
			  		<input type="checkbox" class="flat-red">
			  		<a href="javascript:;" class="btn btn-flat delTr"><i class="fa fa-close"></i></a>
			  	</div>
			</td>
			</tr>
		</tbody>
		</table>
		</div>
		<div class="row addNewRow">
			<div class="col-sm-12">
			<div class="btn-group">
				<a href="javascript:;"><i class="fa fa-plus"></i> Add new row</a>
				<a href="javascript:;">5 rows</a>
				<a href="javascript:;">10 rows</a>
			</div>
			</div>
		</div>
	    <div class="form-group">
	        <div class="col-sm-offset-4 col-sm-8">
	            <button type="submit" class="btn btn-primary"><i class="fa fa-plus"></i> <span>Create Client</span></button>
	            <button type="button" class="btn btn-default">Cancel</button>
	        </div>
	    </div>
	</form>
</div>
</div>

<!-- 任务状态列表 -->
<div 
	id="modal-addnew-task-type-list" 
	style="display:none;">
</div>		

</html>
