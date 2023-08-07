<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:77:"D:\nodcloud-master\nodcloud-master/application/index\view\develop\encode.html";i:1689602947;s:72:"D:\nodcloud-master\nodcloud-master\application\index\view\main\main.html";i:1689602947;}*/ ?>
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
                        <label class="layui-form-label">代码类型</label>
                        <div class="layui-input-block">
                            <select id="s|type">
                                <option value="0">HTML</option>
                                <option value="1">JS</option>
                                <option value="2">CSS</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <button class="layui-btn layui-btn-primary" onclick="compress();">压缩</button>
                </div>
            </div>
        </div>
        <div class="layui-col-xs3 layui-btn-group btn_group_right">
            <button class="layui-btn layui-btn-primary" onclick="reload();"><i class="layui-icon layui-icon-refresh"></i></button>
        </div>
    </div>
    <hr />
    <div class="layui-row layui-col-space12">
        <div class="layui-col-xs6">
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">压缩代码</label>
                <div class="layui-input-block">
                    <textarea placeholder="请输入代码内容" class="layui-textarea" id="code" rows="12"></textarea>
                </div>
            </div>
        </div>
        <div class="layui-col-xs6">
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">压缩结果</label>
                <div class="layui-input-block">
                    <textarea class="layui-textarea" id="info" rows="12"></textarea>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/skin/js/develop/encode.js" type="text/javascript" charset="utf-8"></script>
</div>
        <?php hook_listen('pagemore',['js']); ?>
    </body>
</html>