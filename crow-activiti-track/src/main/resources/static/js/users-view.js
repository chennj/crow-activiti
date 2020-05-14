$(function () {
	
	$(".select-alluser").on("click",function(){
		
		$(this).siblings(".select-user-content").hide();
	});
	
	$(".select-user").on("click", function(){
		
		if ($(this).siblings(".select-user-content").css("display") == "none"){
			$(this).siblings(".select-user-content").show();
		}
		
	});
	
	$("#user-auth .cancel").on("click", function(){
		
		$("#user-auth .dropdown-toggle").first().click();
	});
	
	$("#addNewUser,#addNewUserPage .box-header .btn:first").on("click",function(){
		
		var $page = $("#addNewUserPage");
		if($page.is(":animated")){
			return;
			console.log("正在滑动，返回");
		}
		
		var right;
		if ($page.hasClass("e")){
			$page.removeClass("e").addClass("c");
			console.log("开始滑出");
			right = "-600px";
		} else {
			$page.removeClass("c").addClass("e");
			console.log("开始滑入");
			right = "0px";
		}
		$page.animate({right:right},1000);
		
	});
});