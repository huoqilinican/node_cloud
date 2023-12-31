<?php if (!defined('THINK_PATH')) exit(); /*a:1:{s:73:"D:\nodcloud-master\nodcloud-master/application/index\view\main\index.html";i:1689602947;}*/ ?>
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
		<link rel="stylesheet" href="/skin/css/nprogress.css" media="all">
		<link rel="stylesheet" href="/skin/css/main/index.css" media="all">
		<?php hook_listen('pagemore',['css','public']); ?>
	</head>
	<body class="layui-layout-body">
		<div id="NOD_BOX">
			<div class="layui-layout layui-layout-admin">
				<div class="layui-header">
					<!-- 头部区域 -->
					<ul class="layui-nav layui-layout-left">
						<li class="layui-nav-item layadmin-flexible" lay-unselect>
							<a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
								<i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
							</a>
						</li>
						<li class="layui-nav-item" lay-unselect>
							<a href="javascript:;" layadmin-event="refresh" title="刷新">
								<i class="layui-icon layui-icon-refresh-3"></i>
							</a>
						</li>
					</ul>
					<ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">
						<li class="layui-nav-item layui-hide-xs" lay-unselect>
							<a href="javascript:;" layadmin-event="theme">
								<i class="layui-icon layui-icon-theme"></i>
							</a>
						</li>
						<li class="layui-nav-item layui-hide-xs" lay-unselect>
							<a href="javascript:;" layadmin-event="note">
								<i class="layui-icon layui-icon-note"></i>
							</a>
						</li>
						<li class="layui-nav-item" lay-unselect>
							<a href="javascript:;" onclick="set_merchant();">
								<i class="layui-icon nod-icon nod-icon-shanghu" style="top: 3px;"></i>
							</a>
						</li>
						<li class="layui-nav-item" lay-unselect>
							<a href="javascript:;">
								<cite><?php echo $user_info['name']; ?></cite>
							</a>
							<dl class="layui-nav-child">
							    <dd>
									<img class="user_img" src="<?php echo (isset($user_info['img']) && ($user_info['img'] !== '')?$user_info['img']:'/skin/images/user/nod.png'); ?>"/>
								</dd>
								<hr style="margin: 6px 0;">
								<dd style="text-align: center;line-height: 32px;">
									<a href="/index/index/out">退出</a>
								</dd>
							</dl>
						</li>
						<li class="layui-nav-item " lay-unselect>
							<a href="javascript:;" layadmin-event="about"><i class="layui-icon layui-icon-more-vertical"></i></a>
						</li>
					</ul>
				</div>
				<!-- 侧边菜单 -->
				<div class="layui-side layui-side-menu">
					<div class="layui-side-scroll">
						<div class="layui-logo">
							<span><?php echo $sys_name; ?></span>
						</div>
						<ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
						    <?php echo recursion_menu($menu); if(!(empty(\think\Config::get('app_debug')) || ((\think\Config::get('app_debug') instanceof \think\Collection || \think\Config::get('app_debug') instanceof \think\Paginator ) && \think\Config::get('app_debug')->isEmpty()))): ?>
    							<li class="layui-nav-item">
    								<a href="javascript:;" lay-tips="开发工具" lay-direction="2">
    									<i class="layui-icon layui-icon-component"></i>
    									<cite>开发工具</cite>
    								</a>
    								<dl class="layui-nav-child">
    									<dd>
    								        <a lay-href="index/develop/menu.html">菜单设置</a>
    									</dd>
    									<dd>
    								        <a lay-href="index/develop/action.html">行为管理</a>
    									</dd>
    									<dd>
    								        <a lay-href="index/develop/plug.html">插件管理</a>
    									</dd>
    									<dd>
    								        <a lay-href="index/develop/encode.html">代码压缩</a>
    									</dd>
    									<dd>
    								        <a lay-href="index/develop/formfield.html">表单字段</a>
    									</dd>
    								</dl>
    							</li>
							<?php endif; ?>
						</ul>
					</div>
				</div>
				<!-- 页面标签 -->
				<div class="layadmin-pagetabs" id="LAY_app_tabs">
					<div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
					<div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div>
					<div class="layui-icon layadmin-tabs-control layui-icon-down">
						<ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
							<li class="layui-nav-item" lay-unselect>
								<a href="javascript:;"></a>
								<dl class="layui-nav-child layui-anim-fadein">
									<dd layadmin-event="closeThisTabs">
										<a href="javascript:;">关闭当前标签页</a>
									</dd>
									<dd layadmin-event="closeOtherTabs">
										<a href="javascript:;">关闭其它标签页</a>
									</dd>
									<dd layadmin-event="closeAllTabs">
										<a href="javascript:;">关闭全部标签页</a>
									</dd>
								</dl>
							</li>
						</ul>
					</div>
					<div class="layui-tab" lay-unauto lay-allowClose="true" lay-filter="layadmin-layout-tabs">
						<ul class="layui-tab-title" id="LAY_app_tabsheader">
							<li lay-id="/index/main/home.html" lay-attr="/index/main/home.html" class="layui-this"><i class="layui-icon layui-icon-home"></i></li>
						</ul>
					</div>
				</div>
				<!-- 主体内容 -->
				<div class="layui-body" id="LAY_app_body">
					<div class="layadmin-tabsbody-item layui-show">
						<iframe src="/index/main/home.html" frameborder="0" class="layadmin-iframe"></iframe>
					</div>
				</div>
				<!-- 辅助元素，一般用于移动设备下遮罩 -->
				<div class="layadmin-body-shade" layadmin-event="shade"></div>
			</div>
		</div>
		<script src="/skin/js/jquery.js" type="text/javascript" charset="utf-8"></script>
		<script src="/skin/js/layui.js" type="text/javascript" charset="utf-8"></script>
		<script src="/skin/js/public/nprogress.js" type="text/javascript" charset="utf-8"></script>
		<script src="/skin/js/public/public.js" type="text/javascript" charset="utf-8"></script>
		<script src="/skin/js/public/selectpage.js" type="text/javascript" charset="utf-8"></script>
		<script src="/skin/js/main/index.js" type="text/javascript" charset="utf-8"></script>
		<?php hook_listen('pagemore',['js','public']); ?>
	</body>
</html>