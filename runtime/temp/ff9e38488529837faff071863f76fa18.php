<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:76:"D:\nodcloud-master\nodcloud-master/application/index\view\purchase\bill.html";i:1689602947;s:72:"D:\nodcloud-master\nodcloud-master\application\index\view\main\main.html";i:1689602947;}*/ ?>
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
                        <label class="layui-form-label">单据编号</label>
                        <div class="layui-input-block">
                            <input type="text" class="layui-input" id="s|number" placeholder="请输入单据编号">
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">供应商</label>
                        <div class="layui-input-block">
                            <div id="nod_supplier" class="selectpage" nod="s|supplier" tip="全部供应商" url="/index/service/supplier_list" checkbox></div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">核销状态</label>
                        <div class="layui-input-block">
                            <select id="s|billtype">
                                <option value="0">全部状态</option>
                                <option value="1">未核销</option>
                                <option value="2">部分核销</option>
                                <option value="3">已核销</option>
                                <option value="4">强制核销</option>
                            </select>
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
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">结算账户</label>
                        <div class="layui-input-block">
                            <div id="nod_account" class="selectpage" nod="s|account" tip="全部结算账户" url="/index/service/account_list" checkbox></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space3" show>
                <div class="layui-col-xs3">
                    <div class="layui-form-item remove_margin reset_item">
                        <label class="layui-form-label">制单人</label>
                        <div class="layui-input-block">
                            <div id="nod_user" class="selectpage" nod="s|user" tip="全部制单人" url="/index/service/user_list" checkbox></div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-xs6">
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
        <button class="layui-btn layui-btn-primary layui-btn-sm" lay-event="view">查看</button>
        <button class="layui-btn layui-btn-primary layui-btn-sm" lay-event="set_bill">操作</button>
    </div>
</script>
<script type="text/html" id="batch_html">
    <button class="layui-btn" onclick="set_bills();" batch>批量操作</button>
</script>
<script type="text/javascript" charset="utf-8">
    var formfield=<?php echo get_formfield('purchasebill_form','layui'); ?>;
</script>
<script src="/skin/js/public/selectpage.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/purchase/bill.js" type="text/javascript" charset="utf-8"></script>
</div>
        <?php hook_listen('pagemore',['js']); ?>
    </body>
</html>