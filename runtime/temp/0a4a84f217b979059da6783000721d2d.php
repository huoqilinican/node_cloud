<?php if (!defined('THINK_PATH')) exit(); /*a:1:{s:74:"D:\nodcloud-master\nodcloud-master/application/index\view\index\index.html";i:1689602947;}*/ ?>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title><?php echo $sys_name; ?></title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
		<link rel="stylesheet" href="/skin/css/layui.css" media="all">
		<link rel="stylesheet" href="/skin/css/admin.css" media="all">
		<link rel="stylesheet" href="/skin/css/main/login.css" media="all">
	</head>
	<body>
		<div class="layadmin-user-login layadmin-user-display-show background_img" id="LAY-user-login" style="display: none;">
			<div class="layadmin-user-login-main">
				<div class="layadmin-user-login-box layadmin-user-login-header">
					<h2><i class="layui-icon">&#xe628;</i><?php echo $sys_name; ?></h2>
					<p>NODCLOUD.COM</p>
				</div>
				<div class="layadmin-user-login-box layadmin-user-login-body layui-form">
					<div class="layui-form-item">
						<label class="layadmin-user-login-icon layui-icon layui-icon-username" for="user"></label>
						<input type="text" id="user" placeholder="请输入账号" class="layui-input">
					</div>
					<div class="layui-form-item">
						<label class="layadmin-user-login-icon layui-icon layui-icon-password" for="pwd"></label>
						<input type="password" id="pwd" placeholder="请输入密码" class="layui-input">
					</div>
					<div class="layui-form-item">
						<button class="layui-btn layui-btn-normal layui-btn-fluid" onclick="login();">安全登录</button>
					</div>
				</div>
			</div>
			<div class="layui-trans layadmin-user-login-footer bom">
				<a href="https://gitee.com/yimiaoOpen/nodcloud/stargazers"><img src="https://gitee.com/yimiaoOpen/nodcloud/badge/star.svg?theme=white" alt="star"></a>
			    <p>NOD_ERP <?php echo $ver; ?> | Copyright © <a href="https://www.nodcloud.com/" target="_blank">NODCLOUD.COM</a></p>
			</div>
		</div>
		<script src="/skin/js/jquery.js"></script>
		<script src="/skin/js/layui.js"></script>
		<script src="/skin/js/public/public.js"></script>
		<script src="/skin/js/main/login.js"></script>
	</body>
</html>