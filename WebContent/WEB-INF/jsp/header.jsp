<%@page import="com.demo.action.SessionContainer"%>
<jsp:useBean id="se" scope="application" class="com.demo.action.SessionContainer"></jsp:useBean>
<jsp:useBean id="user" class="com.demo.bo.User"></jsp:useBean>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	se=(SessionContainer)session.getAttribute("sessionContainer");
	String title="Hey boddy!啦啦啦?！~";
	if(se!=null && se.getUser()!=null){
		user=se.getUser();
		title="Let's do it! Dear "+user.getNickname();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=title %></title>
<link rel="stylesheet" type="text/css" href="/css/toastr.min.css"/>

<link href="/css/bootstrap.min.css" rel="stylesheet" />
<link href="/css/bootstrap-responsive.min.css" rel="stylesheet" />

<link href="/css/fonts.css" rel="stylesheet" />
<link href="/css/font-awesome.css" rel="stylesheet" />

<script src="/jquery/jquery-1.8.3.js"></script>
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
</head>
<script>
	//初始化
	$(function(){
		$("#login_btn").click(function(){
			$("#login_btn").button('loading');
			vars=$("#login_form").serialize();
			$.post("index.do?action=LoginAction",vars).done(function(data){
				console.log("data",data);
				window.location.href="/index.do?action=IndexAction";
			}).fail(function(data){
				$("#login_btn").button('reset');
				toastr.warning(data.responseText,"再想想");
			});			
		});
		$("#register_btn").click(function(){
			$(this).button("loading");
			vars= $("#register_form").serialize();
			$.post("index.do?action=RegisterAction",vars).done(function(data){
				toastr.success("恭喜您注册成！","提示信息");
				$("#register").modal("hide");
				document.getElementById('register_form').reset();
				setTimeout(window.location.href="/index.do?action=IndexAction",2000);
			}).fail(function(data){
				$("#register_btn").button("reset");
				toastr.error(data.responseText,"注册失败了");
			});			
		});
		$("#logout").click(function(){
			$.get("index.do?action=LogoutAction").done(function(){
				window.location.href="/";
			});
		});
	});
</script>
<style>
.band-banner{
	padding:40px 0 0 0;
	margin:0px;
	border-radius:0px;
}
.band-banner{
	height:75px;
}
.logo{
	background-image: url("/images/logo.png");
	height:70px;
	width:280px;
}
.content{
	padding:20px 0 0 0;
}
.clear{
	clear:both;
}

</style>


<body>
	<!-- fixed header -->
    <div class="navbar navbar-fixed-top">
	    <div class="navbar-inner">
		    <div class="container" style="width:100%;">
		    	<div class="nav-collapse">
		          <ul class="nav">
		            <li class="active"><a href="#">主页<i class="icon-star"></i></a></li>
		            <li><a href="#">影片<i class="icon-facetime-video"></i></a></li>
		            <li><a href="#">演员<i class="icon-camera"></i></a></li>
		            <li><a href="#">片商<i class="icon-bar-chart"></i></a></li>
		            <li class="dropdown">
		              <a data-toggle="dropdown" class="dropdown-toggle" href="#">更多 <b class="caret"></b></a>
		              <ul class="dropdown-menu">
		                <li><a href="#">动作</a></li>
		                <li><a href="#">另一个动作</a></li>
		                <li><a href="#">其他动作</a></li>
		                <li class="divider"></li>
		                <li class="nav-header">导航头</li>
		                <li><a href="#">被间隔的链接</a></li>
		                <li><a href="#">另一个链接</a></li>
		              </ul>
		            </li>
		          </ul>
		          <ul class="nav pull-right">
				 <%if(se!=null && se.getUser()!=null){%>
		            <li class="dropdown">
		              <a data-toggle="dropdown" class="dropdown-toggle" href="#"><%=se.getUser().getNickname() %><b class="caret"></b></a>
		              <ul class="dropdown-menu">
						<li><a href="#">动作</a></li>
		                <li><a href="#">另一个动作</a></li>
		                <li><a href="#">其他动作</a></li>
		                <li class="divider"></li>
		                <li class="nav-header">导航头</li>
		                <li><a href="#">被间隔的链接</a></li>
		                <li><a href="#">另一个链接</a></li>
		              </ul>
		            </li>


		            <li class="divider-vertical"></li>
		         <%}%>   
		            
		            <li>
		            	<%if(se!=null && se.getUser()!=null){%>
				    		<a href="#" id="logout">注销</a>
				    	<%}else{%>
				    		<li><a data-toggle="modal" href="#register"  data-keyboard="true" data-backdrop="true">注册</a></li>
				    	<%}%>
		            </li>
		            
		            

		          </ul>  
		        </div>
		    </div>
	    </div>
    </div>



	<!-- 注册用户对话框 -->
    <div class="modal hide fade" id="register">
	    <div class="modal-header">
	    	<a class="close" data-dismiss="modal">×</a>
	    	<h3>立刻加入我们！</h3>
	    </div>
	    <div class="modal-body">
	    	<p>
	    		<form class="form-horizontal" id="register_form">
	    			<fieldset>
						<div class="control-group">
							<label class="control-label">账户</label>
							<div class="controls">
								<input type="text" id="username" name="username">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">昵称</label>
							<div class="controls">
								<input type="text" id="nickname" name="nickname">
							</div>
						</div>						
						<div class="control-group">
							<label class="control-label">密码</label>
							<div class="controls">
								<input type="password" id="password" name="password">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">重复密码</label>
							<div class="controls">
								<input type="password" id="password2">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label">电子邮件</label>
							<div class="controls">
								<input type="text" id="email" name="email">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label"><a href="#"  onclick="$('#reg_img').attr('src','/auth?'+Math.random())">给爷换一个验证码</a></label>
							<div class="controls">
								<input type="text" id="reg_auth" style="width:80px;" name="authCode"><img id="reg_img" alt="" src="/auth">
							</div>
						</div>										    				
	    			</fieldset>
	    		</form>
	    	</p>
	    </div>
	    <div class="modal-footer">

	    	  <label class="checkbox pull-left" style="width:130px;">
                <input type="checkbox" checked="true">本人已经阅读<a href="#">站点条款</a>
              </label>
			  <input id="register_btn" type="button" class="btn btn-primary" data-loading-text="数据验证中..." value="注册">
	    </div>
    </div>






	<!-- banner header -->
	<div class="band-banner alert alert-info">
		<div class="container">
			<div class="row">
				<div class="span4">
					<div class="logo"></div>
				</div>
				<div class="span4">
					<div style="padding-top:23px;">
						  <ul class="nav nav-pills">
					        <li class="active"><a href="#">主页</a></li>
					        <li><a href="#">演员动态</a></li>
					        <li><a href="#">最新上映</a></li>
					        <li><a href="#">永恒经典</a></li>
					      </ul>					
					</div>

				</div>
				<div class="span3">
					<div style="padding-top:23px;">
					  <div class="input-append">
		                <input class="search-query span2" placeholder="输入搜索内容关键词..." type="text" size="16" id="appendedPrependedInput" style="margin-bottom:0px;"><button style="width:80px;" type="button" class="btn btn-warning"><i class="icon-search"></i>搜索</button>
		              </div>
		              	热门关键词：你懂的
					</div>
					
				</div>
			</div>
		</div>
	</div>


