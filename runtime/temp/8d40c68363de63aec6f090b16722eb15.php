<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:72:"D:\nodcloud-master\nodcloud-master/application/index\view\root\main.html";i:1689602947;s:72:"D:\nodcloud-master\nodcloud-master\application\index\view\main\main.html";i:1689602947;}*/ ?>
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
<link rel="stylesheet" href="/skin/css/root/root.css" type="text/css" media="all" />
<div class="layui-form layui-form-pane">
    <div class="layui-row">
        <div class="layui-col-xs9" id="search_data">
            <div class="layui-row layui-col-space3">
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">职员账号</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="s|user" placeholder="请输入职员账号">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">职员名称</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="s|name" placeholder="请输入职员名称">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">所属商户</label>
                        <div class="layui-input-block">
                            <div id="merchantpage" class="selectpage"></div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <button class="layui-btn layui-btn-primary" onclick="search();"><i class="layui-icon layui-icon-search"></i></button>
                </div>
            </div>
        </div>
        <div class="layui-col-xs3 layui-btn-group btn_group_right">
            <button class="layui-btn layui-btn-primary" onclick="reload();"><i class="layui-icon layui-icon-refresh"></i></button>
        </div>
    </div>
    <hr />
    <div class="layui-row">
        <div class="layui-col-md12">
            <table id="data_table" lay-filter="table_main"></table>
        </div>
    </div>
</div>
<script type="text/html" id="bar_info">
    <div>
        <?php if((get_root('senior_edit'))): ?>
            <button class="layui-btn layui-btn-primary layui-btn-sm" lay-event="root">设置</button>
        <?php endif; ?>
    </div>
</script>
<script type="text/html" id="more_html"><?php hook_listen('formmore'); ?></script>
<script type="text/javascript" charset="utf-8">
    var formfield=<?php echo get_formfield('root_form','layui'); ?>;
</script>
<script src="/skin/js/public/selectpage.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/root/main.js" type="text/javascript" charset="utf-8"></script>
</div>
        <?php hook_listen('pagemore',['js']); ?>
    </body>
</html>