<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:73:"D:\nodcloud-master\nodcloud-master/application/index\view\goods\main.html";i:1689602947;s:72:"D:\nodcloud-master\nodcloud-master\application\index\view\main\main.html";i:1689602947;}*/ ?>
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
<link rel="stylesheet" href="/skin/css/ztree/metro.css" type="text/css" media="all" />
<link rel="stylesheet" href="/skin/css/goods/goods.css" type="text/css" media="all" />
<div class="layui-form layui-form-pane">
    <div class="layui-row">
        <div class="layui-col-xs9" id="search_data">
            <div class="layui-row layui-col-space3">
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">商品名称</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="s|name" placeholder="请输入商品名称">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">商品编号</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="s|number" placeholder="请输入商品编号">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">规格型号</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="s|spec" placeholder="请输入规格型号">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3 layui-btn-group">
                    <button class="layui-btn layui-btn-primary" onclick="show_more_info(this);" more='0'><i class="layui-icon layui-icon-down"></i></button>
                    <button class="layui-btn layui-btn-primary" onclick="search();"><i class="layui-icon layui-icon-search"></i></button>
                </div>
            </div>
            <div class="layui-row layui-col-space3" show>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">商品分类</label>
                        <div class="layui-input-block">
                            <input type="text" id="s|class" placeholder="请选择商品分类" class="layui-input" onclick="show_ztree(this);" nod="">
            				<div class="ztree_box">
            					<ul id="s_goodsclass" class="ztree layui-anim layui-anim-upbit"></ul>
            				</div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">商品品牌</label>
                        <div class="layui-input-block">
                            <div id="s_brand" class="selectpage"></div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">商品单位</label>
                        <div class="layui-input-block">
                            <div id="s_user" class="selectpage"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space3" show>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">条形码</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="s|code" placeholder="请输入条形码">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">商品货位</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="s|location" placeholder="请输入商品货位">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">备注信息</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="s|data" placeholder="请输入备注信息">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-xs3 layui-btn-group btn_group_right">
            <?php if((get_root('basics_add'))): ?>
                <button class="layui-btn layui-btn-primary" onclick="detail(0);">新增</button>
                <button class="layui-btn layui-btn-primary" onclick="imports();">导入</button>
            <?php endif; ?>
            <button class="layui-btn layui-btn-primary" onclick="exports();">导出</button>
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
    <div class="layui-btn-group">
        <?php if((get_root('basics_edit'))): ?>
            <button class="layui-btn layui-btn-primary layui-btn-sm" lay-event="edit">修改</button>
        <?php endif; if((get_root('basics_del'))): ?>
            <button class="layui-btn layui-btn-primary layui-btn-sm" lay-event="delect">删除</button>
        <?php endif; ?>
    </div>
</script>
<script type="text/html" id="batch_html">
    <?php if((get_root('basics_del'))): ?>
        <button class="layui-btn" onclick="delect('batch');" batch>删除</button>
    <?php endif; ?>
</script>
<script type="text/html" id="more_html"><?php hook_listen('formmore'); ?></script>
<script type="text/javascript" charset="utf-8">
    var formfield=<?php echo get_formfield('goods_form','layui'); ?>;
    var ztree_data=<?php array_unshift($goodsclass,['id'=>0,'pid'=>0,'name'=>'全部分类','open'=>'true']);echo json_encode(array_field($goodsclass,['id','pid','name','open'])); ?>;
    var attribute=<?php echo json_encode($attribute); ?>;
    var default_stocktip=<?php echo get_sys(['room_threshold']); ?>;
</script>
<script src="/skin/js/public/ztree.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/public/selectpage.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/public/kindeditor/kindeditor-all.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/public/kindeditor/lang/zh-CN.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/goods/main.js" type="text/javascript" charset="utf-8"></script>
</div>
        <?php hook_listen('pagemore',['js']); ?>
    </body>
</html>