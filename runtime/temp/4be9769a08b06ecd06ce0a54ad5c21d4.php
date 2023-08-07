<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:71:"D:\nodcloud-master\nodcloud-master/application/index\view\log\main.html";i:1689602947;s:72:"D:\nodcloud-master\nodcloud-master\application\index\view\main\main.html";i:1689602947;}*/ ?>
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
<div class="layui-form layui-form-pane">
    <div class="layui-row">
        <div class="layui-col-xs9" id="search_data">
            <div class="layui-row layui-col-space3">
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">操作内容</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="s|text" placeholder="请输入操作内容">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">操作用户</label>
                        <div class="layui-input-block">
                            <div id="userpage" class="selectpage"></div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <button class="layui-btn layui-btn-primary" onclick="show_more_info(this);" more="0"><i class="layui-icon layui-icon-down"></i></button>
                    <button class="layui-btn layui-btn-primary" onclick="search();"><i class="layui-icon layui-icon-search"></i></button>
                </div>
            </div>
            <div class="layui-row layui-col-space3" show>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">开始日期</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="s|start_time" placeholder="请选择开始日期" >
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">结束日期</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="s|end_time" placeholder="请选择结束日期" >
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-xs3 layui-btn-group btn_group_right">
            <?php if((get_root('senior_del'))): ?>
                <button class="layui-btn layui-btn-primary" onclick="empty();">清空</button>
            <?php endif; ?>
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
<script type="text/javascript" charset="utf-8">
    var formfield=<?php echo get_formfield('log_form','layui'); ?>;
</script>
<script src="/skin/js/public/selectpage.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/log/main.js" type="text/javascript" charset="utf-8"></script>
</div>
        <?php hook_listen('pagemore',['js']); ?>
    </body>
</html>