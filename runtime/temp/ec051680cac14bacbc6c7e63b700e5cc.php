<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:75:"D:\nodcloud-master\nodcloud-master/application/index\view\main\summary.html";i:1689602947;s:72:"D:\nodcloud-master\nodcloud-master\application\index\view\main\main.html";i:1689602947;}*/ ?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>NODCLOUD.COM</title>
        <meta name="renderer" content="webkit">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
        <link rel="stylesheet" href="/skin/css/layui.css" media="all">
        <link rel="stylesheet" href="/skin/css/admin.css" media="all">
        <link rel="stylesheet" href="/skin/css/main.css" media="all">
        <link rel="stylesheet" href="/skin/css/public.css" media="all">
        <?php hook_listen('pagemore',['css','extend']); ?>
        <script src="/skin/js/jquery.js" type="text/javascript" charset="utf-8"></script>
        <script src="/skin/js/layui.js" type="text/javascript" charset="utf-8"></script>
        <script src="/skin/js/public/public.js" type="text/javascript" charset="utf-8"></script>
        <?php hook_listen('pagemore',['js','extend']); ?>
        <script type="text/javascript" charset="utf-8">function p_tip(tip){void 0!=parent.NProgress&&(0==tip?parent.NProgress.start():1==tip&&parent.NProgress.done())}p_tip(0);</script>
    </head>
    <body onload="p_tip(1);">
        <?php hook_listen('pagemore',['css']); ?>
        <div class="form_box">
<link rel="stylesheet" href="/skin/css/main/summary.css" type="text/css" media="all" />
<div class="fun_info">
    <fieldset class="layui-elem-field">
        <legend>功能须知</legend>
        <div class="layui-field-box">
            <ul>
                <li>1.统计初始化将重新统计商品数据的单据数据。</li>
                <li>2.初始化操作很耗费系统资源，建议闲暇时执行。</li>
                <li>3.初始化过程中禁止对系统其他模块进行操作。</li>
                <li>4.操作过程中须保持互联网通讯，请勿手动终止。</li>
                <li>5.如操作过程中断，需重新执行初始化操作。</li>
                <li>6.如果在使用过程中遇到问题，请联系客服解决。</li>
            </ul>
            <button class="layui-btn" onclick="run();">开始初始化</button>
        </div>
    </fieldset>
</div>
<div class="fun_box layui-form layui-form-pane">
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
        <legend>统计初始化中</legend>
    </fieldset>
    <div class="layui-progress layui-progress-big" lay-showpercent="true" lay-filter="nod">
        <div class="layui-progress-bar layui-bg-green" lay-percent="0%"></div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">反馈信息：</label>
        <div class="layui-input-block">
            <textarea class="layui-textarea" id="run_info" disabled="disabled"></textarea>
        </div>
    </div>
</div>
<script src="/skin/js/main/summary.js" type="text/javascript" charset="utf-8"></script>
</div>
        <?php hook_listen('pagemore',['js']); ?>
    </body>
</html>