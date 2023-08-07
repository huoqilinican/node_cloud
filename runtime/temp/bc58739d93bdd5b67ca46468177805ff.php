<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:75:"D:\nodcloud-master\nodcloud-master/application/index\view\develop\plug.html";i:1689602947;s:72:"D:\nodcloud-master\nodcloud-master\application\index\view\main\main.html";i:1689602947;}*/ ?>
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
                        <label class="layui-form-label">插件名称</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="s|name" placeholder="请输入插件名称">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">插件状态</label>
                        <div class="layui-input-block">
                            <select id="s|state">
                                <option value="0">全部状态</option>
                                <option value="1">禁用</option>
                                <option value="2">启用</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <button class="layui-btn layui-btn-primary" onclick="search();"><i class="layui-icon layui-icon-search"></i></button>
                </div>
            </div>
        </div>
        <div class="layui-col-xs3 btn_group_right">
            <button class="layui-btn layui-btn-primary" onclick="reload();"><i class="layui-icon layui-icon-refresh"></i></button>
        </div>
    </div>
</div>
<hr />
<table id="data_table" lay-filter="table_main"></table>
<script type="text/html" id="bar_info">
    <div class="layui-btn-group">
        {{#  if(d.state.nod==-1){ }}
            <button class="layui-btn layui-btn-primary layui-btn-sm" lay-event="install">安装</button>
            <button class="layui-btn layui-btn-primary layui-btn-sm" lay-event="delect">删除</button>
        {{#  } else if(d.state.nod==0) { }}
            <button class="layui-btn layui-btn-primary layui-btn-sm" lay-event="enable">启用</button>
            <button class="layui-btn layui-btn-primary layui-btn-sm" lay-event="uninstall">卸载</button>
        {{#  } else if(d.state.nod==1) { }}
            {{#  layui.each(d.set, function(index, set_vo){ }}
                <button class="layui-btn layui-btn-primary layui-btn-sm" lay-event="view" parameter="{{set_vo.parameter}}">{{set_vo.title}}</button>
            {{#  }); }}
            <button class="layui-btn layui-btn-primary layui-btn-sm" lay-event="discont">停用</button>
        {{#  } }}
    </div>
</script>
<script src="/skin/js/develop/plug.js" type="text/javascript" charset="utf-8"></script>
</div>
        <?php hook_listen('pagemore',['js']); ?>
    </body>
</html>