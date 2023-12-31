<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:75:"D:\nodcloud-master\nodcloud-master/application/index\view\cashier\main.html";i:1689602947;s:72:"D:\nodcloud-master\nodcloud-master\application\index\view\main\main.html";i:1689602947;}*/ ?>
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
<link rel="stylesheet" href="/skin/css/select2.css" type="text/css" media="all" />
<link rel="stylesheet" href="/skin/css/cashier/cashier.css" type="text/css" media="all" />
<div class="main_top">
    <h1><?php echo $sys['cashier_title']; ?></h1>
</div>
<div class="main_box">
    <div class="layui-row">
        <div class="layui-col-xs3 goods_list">
            <div class="layui-card">
                <div class="layui-card-header">商品信息</div>
                <div class="layui-card-body">
                    <div class="list_top">
                        <table class="layui-table" lay-skin="line">
                            <thead>
                                <tr>
                                    <th>商品名称</th>
                                    <th>数量</th>
                                    <th>金额</th>
                                    <th>操作</th>
                                </tr> 
                            </thead>
                            <tbody id="goods_main"></tbody>
                        </table>
                    </div>
                    <div class="list_bom">
                        <div class="layui-row">
                            <div class="layui-col-xs6">
                                <p class="count">合计<span id="goods_count">0</span>项</p>
                            </div>
                            <div class="layui-col-xs6">
                                <p class="money">总金额：<span id="goods_money">0</span></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-xs9 room_list">
            <div class="layui-card">
                <div class="layui-card-header">
                    <div class="layui-row">
                        <div class="layui-col-xs7">
                            <span>商品列表</span>
                        </div>
                        <div class="layui-col-xs5 so_group">
                            <div class="layui-row">
                                <div class="layui-col-xs10">
                                    <input class="layui-input" id="so_info" type="text" placeholder="商品名称 / 首拼字母 / 条形码" />
                                </div>
                                <div class="layui-col-xs2">
                                    <button class="layui-btn layui-btn-primary" onclick="so_goods();">
                                        <i class="layui-icon layui-icon-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-card-body">
                    <div class="layui-row layui-col-space5" id="room_main"></div>
                </div>
            </div>
            <div class="page_list"><div id="page"></div></div>
        </div>
        <div class="layui-col-xs9 goods_info" style="display:none;">
            <div class="layui-card">
                <div class="layui-card-header" onclick="hide_goods_info();">
                    <div class="layui-row">
                        <span>商品详情</span>
                        <i class="layui-icon layui-icon-close-fill" style="font-size: 26px;top: 32%;"></i>
                    </div>
                </div>
                <div class="layui-card-body">
                    <div class="layui-form layui-form-pane"><?php echo get_formfield('cashier_main','default'); ?></div>
                </div>
            </div>
        </div>
        <div class="layui-col-xs9 settle_info" style="display:none;">
            <div class="layui-card">
                <div class="layui-card-header" onclick="hide_goods_info();">
                    <div class="layui-row">
                        <span>结账详情</span>
                        <i class="layui-icon layui-icon-close-fill" style="font-size: 26px;top: 32%;"></i>
                    </div>
                </div>
                <div class="layui-card-body">
                    <div class="layui-form layui-form-pane">
                        <div class="layui-form-item">
                            <label class="layui-form-label">购买客户</label>
                            <div class="layui-input-block">
                                <div id="nod_customer" class="selectpage" nod="customer" tip="请选择客户" url="/index/service/customer_list"></div>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">单据金额</label>
                            <div class="layui-input-block">
                                <input type="text" id="total" class="layui-input" disabled="disabled">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">实际金额</label>
                            <div class="layui-input-block">
                                <input type="text" id="actual" class="layui-input" placeholder="请输入实际金额">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">客户付款</label>
                            <div class="layui-input-block">
                                <input type="text" id="money" class="layui-input" placeholder="请输入客户付款">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">找零金额</label>
                            <div class="layui-input-block">
                                <input type="text" id="oddchange" class="layui-input" value="0" disabled="disabled">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">赠送积分</label>
                            <div class="layui-input-block">
                                <input type="text" id="integral" class="layui-input" placeholder="请输入赠送积分">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label class="layui-form-label">结算账户</label>
                            <div class="layui-input-block">
                                <div id="nod_account" class="selectpage" nod="account" tip="请选择结算账户" url="/index/service/account_list"></div>
                            </div>
                        </div>
                        <div class="layui-form-item" pane>
                            <label class="layui-form-label">组合支付</label>
                            <div class="layui-input-block">
                                <input type="checkbox" id="paymemu" lay-skin="switch" lay-text="开|关" lay-filter="paymemu">
                            </div>
                        </div>
                        <table class="layui-table" id="pay_tab" style="display:none;">
                            <thead>
                                <tr>
                                    <th>结算账户</th>
                                    <th>结算金额</th>
                                    <th onclick="add_pay();">相关操作<i class="layui-icon layui-icon-add-circle"></i></th>
                                </tr>
                            </thead>
                            <tbody id="pay_tbody"></tbody>
                        </table>
                		<div class="layui-form-item">
                            <label class="layui-form-label">备注信息</label>
                            <div class="layui-input-block">
                                <input type="text" id="data" class="layui-input" placeholder="请输入备注信息">
                            </div>
                        </div>
                        <more></more>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="main_bom">
    <button class="layui-btn layui-btn-primary" onclick="replace();">重新载入</button>
    <button class="layui-btn settle" onclick="settle();">结账</button>
</div>
<script type="text/html" id="more_html"><?php hook_listen('formmore'); ?></script>
<script type="text/javascript" charset="utf-8">
    var integral_proportion=<?php echo $sys['integral_proportion']; ?>;
    var cashier_customer=<?php echo !empty($sys['cashier_customer'])?$sys['cashier_customer']:'false'; ?>;
    var cashier_account=<?php echo !empty($sys['cashier_account'])?$sys['cashier_account']:'false'; ?>;
    var cashier_print=<?php echo !empty($sys['cashier_print'])?$sys['cashier_print']:'false'; ?>;
    var account_arr=<?php echo json_encode($account_arr); ?>;
    var plug_val={};//初始化插件数据
    <?php if(!(empty($sys['cashier_customer']) || (($sys['cashier_customer'] instanceof \think\Collection || $sys['cashier_customer'] instanceof \think\Paginator ) && $sys['cashier_customer']->isEmpty()))): ?>plug_val.nod_customer=<?php echo get_selectpage('customer',$sys['cashier_customer']); ?>;<?php endif; if(!(empty($sys['cashier_account']) || (($sys['cashier_account'] instanceof \think\Collection || $sys['cashier_account'] instanceof \think\Paginator ) && $sys['cashier_account']->isEmpty()))): ?>plug_val.nod_account=<?php echo get_selectpage('account',$sys['cashier_account']); ?>;<?php endif; if(empty($sys['enable_batch']) || (($sys['enable_batch'] instanceof \think\Collection || $sys['enable_batch'] instanceof \think\Paginator ) && $sys['enable_batch']->isEmpty())): ?> $('input[nod="batch"]').parent().parent().hide();<?php endif; if(empty($sys['enable_batch']) || (($sys['enable_batch'] instanceof \think\Collection || $sys['enable_batch'] instanceof \think\Paginator ) && $sys['enable_batch']->isEmpty())): ?> $('#set_serial').parent().parent().hide();<?php endif; ?>
</script>
<script src="/skin/js/public/selectpage.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/public/select2.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/cashier/main.js" type="text/javascript" charset="utf-8"></script>
</div>
        <?php hook_listen('pagemore',['js']); ?>
    </body>
</html>