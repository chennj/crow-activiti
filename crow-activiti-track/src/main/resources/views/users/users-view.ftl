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

	<link rel="stylesheet" href="${request.contextPath}/static/plugins/mytable/mytable.css">

	<style>
	.panel{
		margin-bottom:0px;
		border-radius:0px;
	}
	
	body .demo-class .layui-layer-title{background:#ccc; color:#fff; border: none;}
	body .layui-layer {
	    top: 150px;
	    left: 0;
	    margin: 0;
	    padding: 0;
	    background-color: #fff;
	    -webkit-background-clip: content;
	    -webkit-overflow-scrolling: touch;
	    border-radius: 2px;
	    box-shadow: 1px 1px 50px rgba(0,0,0,.3);
	}	
	
	.bg-light-blue{
		background-color:#fcfcfc!important;
		color:gray!important;
	}
	
	.spacer{
		background-color: #fff!important;
	    border-right: 1px solid #c8c8c8;
	    border-left: 1px solid #c8c8c8;
		padding: 0px 1px 0px 1px !important;
    }
    .left-vertical-line{
    	border-left: 1px solid #c8c8c8;
    }
    
    .add-new-user-page{
    	position:absolute;
    	right:-600px; 
    	background-color:#fcfcfc;
    	width:600px;
    	height:100%;
    	z-index:1;
    	color:gray;
    }
	</style>
	
</head>
<body class="hold-transition skin-blue fixed sidebar-mini <#if cookieMap?exists && cookieMap["xxlmq_adminlte_settings"]?exists && "off" == cookieMap["xxlmq_adminlte_settings"].value >sidebar-collapse</#if> ">
<div class="wrapper">
	<!-- header -->
	<@netCommon.commonHeader />
	<!-- left -->
	<@netCommon.commonLeft "users" />
	
	<!-- Content Wrapper. Contains page content -->
	<div class="content-wrapper">
		
		<div class="add-new-user-page" id="addNewUserPage">
          	<div class="box box-success">
            	<div class="box-header with-border">
              		<h3 class="box-title">Removable</h3>
              		<div class="box-tools pull-right">
                	<button type="button" class="btn btn-box-tool"><i class="fa fa-times"></i></button>
              		</div>
              		<!-- /.box-tools -->
            	</div>
            	<!-- /.box-header -->
            	<div class="box-body" style="height:100%;">
              	The body of the box
            	</div>
            </div>
		</div>
		
		<!-- Content Header (Page header) -->
		<section class="content-header" id="main-content-header">
			<h1>User Manager</h1>
			<ol class="breadcrumb">
        		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        		<li class="active">Users</li>
      		</ol>
		</section>

		<!-- Main content -->
		<section class="content" id="main-content">
			
            <!-- 用户管理-->
            <div class="row">
        	<div class="col-md-12">

        		<form method="post">
				<ul id="myTab" class="nav nav-tabs">
				    <li class="active"><a href="#user-auth" role="tab" data-toggle="tab">Accounts & Permissionis</a></li>
				    <li><a href="#user-pto" role="tab" data-toggle="tab">PTO Settings</a></li>
				    <li><a href="#user-sickday" role="tab" data-toggle="tab">Sick Days Settings</a></li>
				    <li><a href="#user-workassign" role="tab" data-toggle="tab">Work Assignments</a></li>
				    <li class="pull-right">
        				<div class="btn-group">
					  	<button type="button" class="btn btn-flat btn-small btn-default">Manage Groups</button>
					  	<button type="button" class="btn btn-flat btn-small btn-default dropdown-toggle" data-toggle="dropdown">
					    	<span class="caret"></span>
					    	<span class="sr-only"></span>
					  	</button>
					  	<ul class="dropdown-menu" role="menu">
						    <li><a href="javascript:void(0);">Department</a></li>
						    <li><a href="javascript:void(0);">Time Zone Group</a></li>
					  	</ul>
					  	</div>
					  	<button type=button class="btn btn-flat btn-primary" id="addNewUser">+ New User</button>     
					  	<button type=button class="btn btn-flat btn-primary">+ Bulk Invitations</button>       	  						    
					</li>
				</ul>	
				<div class="tab-content bg-light-blue">
					<!-- Accounts & Permission -->
					<div class="tab-pane active" id="user-auth">
				  		<table class="table table-bordered">
				    		<thead>
				    		<tr>
				      			<th colspan=>
			      					<div>
			      					<span class="leading">User</span>
			      					<span class="pull-right">
			      					<input type=checkbox checked value=1/>Show disabled accounts</span></div>
				      			</th>
				      			<th class="spacer"></th>
								<th>
									<span>Management</span>
									<div class="btn-group pull-right">
									  	<button type="button" class="btn btn-flat btn-small btn-default">Action</button>
									  	<button type="button" class="btn btn-flat btn-small btn-default dropdown-toggle" data-toggle="dropdown">
									    	<span class="caret"></span>
									    	<span class="sr-only"></span>
									  	</button>
									  	<ul class="dropdown-menu" role="menu">
										    <li><a href="javascript:void(0);">Department</a></li>
										    <li><a href="javascript:void(0);">Time Zone Group</a></li>
									  	</ul>
									</div>
								</th>
							</tr>
							<tr>
								<th>
									<div class="btn-group">
		 						  	<button type="button" class="btn btn-small btn-primary btn-flat dropdown-toggle" data-toggle="dropdown">
									  	<span class="glyphicon glyphicon-plus"></span>All User
									    <span class="fa fa-caret-down"></span>
								    </button>
								  	<ul class="dropdown-menu">
									    <li class="select_alluser"><div><input type=radio checked value=1/>All User</div></li>
									    <li class="divider"></li>
									    <li class="select_user"><div><input type=radio checked value=1 />All User</div></li>
									    <li class="select_user_content" style="display:none;">
									    <div class="box">
									    	<div class="box-header with-border">
									    		<div class="col-sm-4">
									    			<button class="btn btn-flat" >By Department</button>
									    			<button class="btn btn-flat" >By Time Zones</button>
									    		</div>
									    		<div class="col-sm-8 pull-right">
									    			<span class="input-group-btn">
									    			<button class="btn btn-flat">1</button>
									    			<button class="btn btn-flat">1</button>
									    			<button class="btn btn-flat">1</button>
									    			<button class="btn btn-flat">1</button>
									    			<button class="btn btn-flat">1</button>
									    			<button class="btn btn-flat">1</button>
									    			</span>
									    		</div>
									    	</div>
									    	<div class="box-body">
									    	</div>
									    </div>
									    </li>
									    <li class="divider"></li>
									    <li>
									    	<div class="pull-right">
									    	<button type=submit class="btn btn-flat btn-primary">Apply</button>
									    	<button type=button class="btn btn-flat cancel">Cancel</button></div>
									    </li>
								  	</ul>
								  	<span class="col-sm-4 pull-right"> user</span>
								  	</div>
								</th>
								<th class="spacer"></th>
								<th>
									<div class="leading">
									<span class="col-sm-4">Permissions </span>
									<span class="col-sm-4 left-vertical-line">Access to Users</span>
									<span class="col-sm-4 left-vertical-line">Access to Scope</span></div>
								</th>
							</tr>
				    		</thead>
							<tbody>
							</tbody>
				  		</table>						
					  	<div class="box-footer clearfix">
					    <ul class="pagination pagination-sm no-margin pull-right">
							<li><a href="#">&laquo;</a></li>
							<li><a href="#">1</a></li>
							<li><a href="#">2</a></li>
							<li><a href="#">3</a></li>
							<li><a href="#">&raquo;</a></li>
					    </ul>
					  	</div>
					</div>
					<!-- PTO Settings -->
					<div class="tab-pane" id="user-pto">
					</div>
					<!-- Sick Days Settings -->
					<div class="tab-pane" id="user-sickday">
					</div>
					<!-- Work Assignments -->
					<div class="tab-pane" id="user-workassign">
					</div>
				</div>				
				        
				</form>
				
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
<script src="${request.contextPath}/static/js/users-view.js"></script>

</body>

</html>
