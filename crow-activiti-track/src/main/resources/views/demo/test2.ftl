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
	<link rel="stylesheet" href="${request.contextPath}/static/plugins/datatables/datatables.min.css">
	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/bower_components/select2/css/select2.min.css">
	<!-- icheck -->
	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/plugins/iCheck/square/blue.css">
	<!-- bootstrap datepicker -->
	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
	<style>
        *{
            padding: 0;
            margin: 0;
        }
        .table tr th,
        td {
            border: 1px solid #000;
        }

        .table-responsive {
            overflow-y: scroll;
        }

        .text-center td {
            white-space: nowrap;
            padding: 10px;
        }

        .table-th-css {
            background: #efeff4 !important;
            position: relative !important;
            text-align: center;
            top: 0;
            white-space: nowrap;
        }

        .table-th-css div {
            border-top: none;
            white-space: nowrap;
            padding: 10px;
        }

        .section-scroll {
            height: 417px;
        }
	</style>
	
</head>
<body class="hold-transition skin-blue fixed sidebar-mini <#if cookieMap?exists && cookieMap["xxlmq_adminlte_settings"]?exists && "off" == cookieMap["xxlmq_adminlte_settings"].value >sidebar-collapse</#if> ">
<div class="wrapper">
	<!-- header -->
	<@netCommon.commonHeader />
	<!-- left -->
	<@netCommon.commonLeft "test2" />
	
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
				<div class="col-sm-8">
				<!-- myTable -->
			    <div class="table-responsive section-scroll">
			        <table class="table table-bordered">
			            <thead class="table-header">
			                <tr>
			                    <th class="table-th-css">
			                        <div>部门</div>
			                    </th>
			                    <th class="table-th-css">
			                        <div>用户名称</div>
			                    </th>
			                    <th class="text-center table-th-css">
			                        <div>1月</div>
			                    </th>
			                    <th class="text-center table-th-css">
			                        <div>2月</div>
			                    </th>
			                    <th class="text-center table-th-css">
			                        <div>3月</div>
			                    </th>
			                    <th class="text-center table-th-css">
			                        <div>4月</div>
			                    </th>
			                    <th class="text-center table-th-css">
			                        <div>5月</div>
			                    </th>
			                    <th class="text-center table-th-css">
			                        <div>6月</div>
			                    </th>
			                    <th class="text-center table-th-css">
			                        <div>7月</div>
			                    </th>
			                    <th class="text-center table-th-css">
			                        <div>8月</div>
			                    </th>
			                    <th class="text-center table-th-css">
			                        <div>9月</div>
			                    </th>
			                    <th class="text-center table-th-css">
			                        <div>10月</div>
			                    </th>
			                    <th class="text-center table-th-css">
			                        <div>11月</div>
			                    </th>
			                    <th class="text-center table-th-css">
			                        <div>12月</div>
			                    </th>
			                    <th class="text-center table-th-css">
			                        <div>合计</div>
			                    </th>
			                </tr>
			            </thead>
			            <tbody>
			                <tr class="text-center">
			                    <td>这是一个表格内容</td>
			                    <td class="table-textWidth">这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                </tr>
			                <tr class="text-center">
			                    <td>这是一个表格内容</td>
			                    <td class="table-textWidth">这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                </tr>
			                <tr class="text-center">
			                    <td>这是一个表格内容</td>
			                    <td class="table-textWidth">这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                </tr>
			                <tr class="text-center">
			                    <td>这是一个表格内容</td>
			                    <td class="table-textWidth">这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                </tr>
			                <tr class="text-center">
			                    <td>这是一个表格内容</td>
			                    <td class="table-textWidth">这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                </tr>
			                <tr class="text-center">
			                    <td>这是一个表格内容</td>
			                    <td class="table-textWidth">这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                </tr>
			                <tr class="text-center">
			                    <td>这是一个表格内容</td>
			                    <td class="table-textWidth">这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                </tr>
			                <tr class="text-center">
			                    <td>这是一个表格内容</td>
			                    <td class="table-textWidth">这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                </tr>
			                <tr class="text-center">
			                    <td>这是一个表格内容</td>
			                    <td class="table-textWidth">这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                </tr>
			                <tr class="text-center">
			                    <td>这是一个表格内容</td>
			                    <td class="table-textWidth">这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                </tr>
			                <tr class="text-center">
			                    <td>这是一个表格内容</td>
			                    <td class="table-textWidth">这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                </tr>
			                <tr class="text-center">
			                    <td>这是一个表格内容</td>
			                    <td class="table-textWidth">这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                    <td>这是一个表格内容</td>
			                </tr>
			                <!-- 循环多次tr...-->
			            </tbody>
			        </table>
			    </div>
				<!-- end myTable -->
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
-->
<script src="${request.contextPath}/static/plugins/datatables/datatables.js"></script>
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
<script src="${request.contextPath}/static/js/test.js"></script>

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
			          	<textarea class="form-control" rows="3" name="desc" placeholder="Enter ..."></textarea>
			        </div>
				    <div class="form-group">
				        <label for="ClientCopy" class="control-label">Copy Jobs from an Existing Client:</label>
			            <select class="form-control select2" name="ClientCopy">
			                <option value="">-Select client-</option>
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

<script>
    var tableCont = $(".section-scroll tr th");
    //获取th
    var tableCont_child = $(".section-scroll tr th div");
    //获取th下边的div
    var tableScroll = $(".section-scroll");
    //获取滚动条同级的class
    function scrollHandle() {
        // console.log(1)
        var scrollTop = tableScroll.scrollTop();
        // 当滚动距离大于0时设置top及相应的样式
        if (scrollTop > 0) {
            tableCont.css({
                "top": scrollTop + "px",
                "padding": "0"
            });
            tableCont_child.css({
                "borderTop": "1px solid #000",
                "borderBottom": "1px solid #000",
                "marginTop": "-1px",
                "padding": "8px"
            });
        } else {
            // 当滚动距离小于0时设置top及相应的样式
            tableCont.css({
                "top": scrollTop + "px",
                "marginTop": "0"
            });
            tableCont_child.css({
                "border": "none",
                "marginTop": 0,
                "marginBottom": 0,
            })
        }
    }
    tableScroll.on("scroll", scrollHandle);
    //获取可视区域高度
    // function setIframeHeight() {
    //     var screenHeight = document.documentElement.clientHeight;
    //     $(".section-scroll").height(screenHeight);
    // }
</script>

</html>
