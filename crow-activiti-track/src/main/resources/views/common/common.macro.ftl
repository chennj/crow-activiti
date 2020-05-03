<#macro commonStyle>

	<#-- favicon -->
	<link rel="icon" href="${request.contextPath}/static/favicon.ico" />

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- Tell the browser to be responsive to screen width -->
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<!-- Bootstrap -->
	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/bower_components/bootstrap/css/bootstrap.min.css">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/bower_components/font-awesome/css/font-awesome.min.css">
	<!-- Ionicons -->
	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/bower_components/Ionicons/css/ionicons.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/dist/css/AdminLTE.css">
	<!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/dist/css/skins/_all-skins.min.css">

	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

	<!-- pace -->
	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/bower_components/PACE/themes/blue/pace-theme-flash.css">

	<!-- scrollup -->
	<link rel="stylesheet" href="${request.contextPath}/static/plugins/scrollup/image.css">
	
	<!-- 补充 -->
	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/dist/css/style.css">
	
</#macro>

<#macro commonScript>

	<!-- jQuery 3.4.1 -->
	<script src="${request.contextPath}/static/adminlte/bower_components/jquery/jquery.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="${request.contextPath}/static/adminlte/bower_components/jquery-ui/jquery-ui.min.js"></script>
	<!-- Bootstrap v3.4.1 -->
	<script src="${request.contextPath}/static/adminlte/bower_components/bootstrap/js/bootstrap.min.js"></script>
	<!-- FastClick -->
	<script src="${request.contextPath}/static/adminlte/bower_components/fastclick/fastclick.js"></script>
	<!-- AdminLTE App -->
	<script src="${request.contextPath}/static/adminlte/dist/js/adminlte.js"></script>
	<!-- jquery.slimscroll -->
	<script src="${request.contextPath}/static/adminlte/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>

	<!-- pace -->
	<script src="${request.contextPath}/static/adminlte/bower_components/PACE/pace.min.js"></script>
	<#-- jquery cookie -->
	<script src="${request.contextPath}/static/plugins/jquery/jquery.cookie.js"></script>

	<#-- layer -->
	<script src="${request.contextPath}/static/plugins/layer/layer.js"></script>

	<!-- scrollup -->
	<script src="${request.contextPath}/static/plugins/scrollup/jquery.scrollUp.min.js"></script>

	<#-- common -->
	<script src="${request.contextPath}/static/js/common.1.js"></script>
	<script>
		var base_url = '${request.contextPath}';
	</script>

</#macro>

<#macro commonHeader>
	<header class="main-header">
        <a href="${request.contextPath}/" class="logo">
            <span class="logo-mini"><b>ACTIVITI</b></span>
			<span class="logo-lg"><b>ACTIVITI CENTRE</b></span>
		</a>
        <nav class="navbar navbar-static-top" role="navigation">

            <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>

            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                
				<!-- User Account: style can be found in dropdown.less -->
				<li class="dropdown user user-menu">
				  	<a href="#" class="dropdown-toggle" data-toggle="dropdown">
				    	<img src="${request.contextPath}/static/adminlte/dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
				    	<span class="hidden-xs">Alexander Pierce</span>
				  	</a>
				  	<ul class="dropdown-menu">
				    	<!-- User image -->
				    	<li class="user-header">
				      		<img src="${request.contextPath}/static/adminlte/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
				
				      		<p>
				        	Alexander Pierce - Web Developer
				        	<small>Member since Nov. 2012</small>
				      		</p>
				    	</li>
				    	<!-- Menu Body -->
				    	<li class="user-body">
				      		<div class="row">
				        		<div class="col-xs-4 text-center">
				          			<a href="#">Followers</a>
				        		</div>
					        	<div class="col-xs-4 text-center">
					          		<a href="#">Sales</a>
					        	</div>
					        	<div class="col-xs-4 text-center">
					          		<a href="#">Friends</a>
					        	</div>
				      		</div>
				      		<!-- /.row -->
				    	</li>
				    	<!-- Menu Footer-->
				    	<li class="user-footer">
				      		<div class="pull-left">
				        		<a href="#" class="btn btn-default btn-flat">Profile</a>
				      		</div>
				      		<div class="pull-right">
				        		<a href="#" id="logoutBtn" class="btn btn-default btn-flat">Sign out</a>
				      		</div>
				    	</li>
				  	</ul>
				</li>
				<!-- Control Sidebar Toggle Button -->
				<li>
				  	<a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
				</li>
				
				</ul>
			</div>
		</nav>
	</header>
</#macro>

<#macro commonLeft pageName >
	<!-- Left side column. contains the logo and sidebar -->
	<aside class="main-sidebar">
		<!-- sidebar: style can be found in sidebar.less -->
		<section class="sidebar">
			<!-- sidebar menu: : style can be found in sidebar.less -->
			<ul class="sidebar-menu">
				<li class="header">Dashboard Diagram</li>
                <li class="treeview" >
                	<a href="jjavascript:;">
                		<i class="fa fa-circle-o text-aqua"></i>
                		<span>Time-Track</span>
                		<span class="pull-right-container">
                			<i class="fa fa-angle-left pull-right"></i>
                		</span>
                	</a>
	                <ul class="treeview-menu">
						<li class="<#if pageName == "enter-time-track">active</#if>"><a href="${request.contextPath}/time-track/enter-time-track">Enter Time-Track</a></li>
						<li class="<#if pageName == "view-time-track">active</#if>"><a href="${request.contextPath}/time-track/view-time-track">View Time-Track</a></li>
						<li class="<#if pageName == "lock-time-track">active</#if>"><a href="${request.contextPath}/time-track/lock-time-track">Lock Time-Track</a></li>
		            </ul>
                 </li>
                
                <li class="<#if pageName == "tasks">active</#if>"><a href="${request.contextPath}/tasks"><i class="fa fa-circle-o text-yellow"></i><span>Tasks</span></a></li>
				<li class="<#if pageName == "reports">active</#if>"><a href="${request.contextPath}/reports"><i class="fa fa-circle-o text-green"></i><span>Reports</span></a></li>
                <li class="<#if pageName == "users">active</#if>"><a href="${request.contextPath}/users"><i class="fa fa-circle-o text-red"></i><span>Users</span></a></li>
                <li class="<#if pageName == "help">active</#if>"><a href="${request.contextPath}/help"><i class="fa fa-circle-o text-gray"></i><span>Usage-help</span></a></li>
                <li class="<#if pageName == "demo">active</#if>"><a href="${request.contextPath}/demo/task"><i class="fa fa-circle-o text-gray"></i><span>Demo</span></a></li>
			</ul>
		</section>
		<!-- /.sidebar -->
	</aside>
</#macro>

<#macro commonFooter >
	<footer class="main-footer">
		Powered by <b>ACTIVITI-TT</b> 1.0
		<div class="pull-right hidden-xs">
			<strong>Copyright &copy; 2015-${.now?string('yyyy')} &nbsp;
				<a href="#">CNJ</a>
				&nbsp;
				<a href="https://github.com/chennj" target="_blank" >github</a>
			</strong><!-- All rights reserved. -->
		</div>
	</footer>
</#macro>

<#macro commonControlBar >
	<aside class="control-sidebar control-sidebar-dark" >
		<!-- Create the tabs -->
		<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
			<li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
			<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
		</ul>
		<!-- Tab panes -->
    	<div class="tab-content">
    		<!-- Home tab content -->
    		<div class="tab-pane" id="control-sidebar-home-tab">
    			<h3 class="control-sidebar-heading">Recent Activity</h3>
		        <ul class="control-sidebar-menu">
		          	<li>
		            <a href="javascript:void(0)">
		              	<i class="menu-icon fa fa-birthday-cake bg-red"></i>		
		              	<div class="menu-info">
		                	<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>		
		                	<p>Will be 23 on April 24th</p>
		              	</div>
		            </a>
		          	</li>
		          	<li>
		            <a href="javascript:void(0)">
		              	<i class="menu-icon fa fa-user bg-yellow"></i>		
		              	<div class="menu-info">
		                	<h4 class="control-sidebar-subheading">Frodo Updated His Profile</h4>
		                	<p>New phone +1(800)555-1234</p>
		              	</div>
		            </a>
		          	</li>
		          	<li>
		            <a href="javascript:void(0)">
		              	<i class="menu-icon fa fa-envelope-o bg-light-blue"></i>
		              	<div class="menu-info">
		              		<h4 class="control-sidebar-subheading">Nora Joined Mailing List</h4>
		                	<p>nora@example.com</p>
		              	</div>
		            </a>
		          	</li>
		          	<li>
		            <a href="javascript:void(0)">
		              	<i class="menu-icon fa fa-file-code-o bg-green"></i>
		              	<div class="menu-info">
		                	<h4 class="control-sidebar-subheading">Cron Job 254 Executed</h4>
		                	<p>Execution time 5 seconds</p>
		              	</div>
		            </a>
		          	</li>
		        </ul>
    			<!-- /.control-sidebar-menu -->
    			
    			<h3 class="control-sidebar-heading">Tasks Progress</h3>
		        <ul class="control-sidebar-menu">
		          	<li>
		            <a href="javascript:void(0)">
		              	<h4 class="control-sidebar-subheading">
		                	Custom Template Design
		                	<span class="label label-danger pull-right">70%</span>
		              	</h4>
		              	<div class="progress progress-xxs">
		                	<div class="progress-bar progress-bar-danger" style="width: 70%"></div>
		              	</div>
		            </a>
		          	</li>
		          	<li>
		            <a href="javascript:void(0)">
		              	<h4 class="control-sidebar-subheading">
		                	Update Resume
		                	<span class="label label-success pull-right">95%</span>
		              	</h4>
		              	<div class="progress progress-xxs">
		                	<div class="progress-bar progress-bar-success" style="width: 95%"></div>
		              	</div>
		            </a>
		          	</li>
		          	<li>
		            <a href="javascript:void(0)">
		              	<h4 class="control-sidebar-subheading">
		                	Laravel Integration
		                	<span class="label label-warning pull-right">50%</span>
		              	</h4>
		              	<div class="progress progress-xxs">
		                	<div class="progress-bar progress-bar-warning" style="width: 50%"></div>
		              	</div>
		            </a>
		          	</li>
		          	<li>
		            <a href="javascript:void(0)">
		              <h4 class="control-sidebar-subheading">
		                Back End Framework
		                <span class="label label-primary pull-right">68%</span>
		              </h4>
		              <div class="progress progress-xxs">
		                	<div class="progress-bar progress-bar-primary" style="width: 68%"></div>
		              </div>
		            </a>
		          </li>
		        </ul>
		        <!-- /.control-sidebar-menu -->
		    			
    		</div>
    		<!-- /.tab-pane -->

      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->

      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Allow mail redirect
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Other sets of options are available
            </p>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Expose author name in posts
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Allow the user to show his name in blog posts
            </p>
          </div>
          <!-- /.form-group -->

          <h3 class="control-sidebar-heading">Chat Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Show me as online
              <input type="checkbox" class="pull-right" checked>
            </label>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Turn off notifications
              <input type="checkbox" class="pull-right">
            </label>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Delete chat history
              <a href="javascript:void(0)" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>
            </label>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    		
		</div>
	</aside>
	
	<div class="control-sidebar-bg"></div>
</#macro>