<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:71:"D:\nodcloud-master\nodcloud-master/application/index\view\sys\main.html";i:1689602947;s:72:"D:\nodcloud-master\nodcloud-master\application\index\view\main\main.html";i:1689602947;}*/ ?>
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
<link rel="stylesheet" href="/skin/css/sys/sys.css" type="text/css" media="all" />
<div class="layui-tab layui-tab-brief">
    <ul class="layui-tab-title">
        <li nod="basics" class="layui-this">基础信息</li>
        <li nod="function">功能设置</li>
        <li nod="cashier">零售配置</li>
        <li nod="home">首页配置</li>
    </ul>
    <div class="layui-tab-content layui-form layui-form-pane">
        <div class="layui-tab-item layui-show">
            <div class="layui-form-item">
                <label class="layui-form-label">系统名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="sys_name" placeholder="请输入系统名称" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">公司名称</label>
                <div class="layui-input-inline">
                    <input type="text" id="company_name" placeholder="请输入公司名称" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">公司电话</label>
                <div class="layui-input-inline">
                    <input type="text" id="company_tel" placeholder="请输入公司电话" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">公司地址</label>
                <div class="layui-input-inline">
                    <input type="text" id="company_add" placeholder="请输入公司地址" class="layui-input">
                </div>
            </div>
        </div>
        <div class="layui-tab-item">
            <div class="layui-form-item">
                <label class="layui-form-label" nod-tips="商品管理页面的库存默认阀值">库存默认阀值</label>
                <div class="layui-input-inline">
                    <input type="text" id="room_threshold" placeholder="请输入默认阀值" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" nod-tips="全局打印纸张设置<br/>【A4】210mm×297mm<br/>【241-2】210mm×140mm">默认打印纸张</label>
                <div class="layui-input-inline">
                    <select id="print_paper">
                        <option value="0">A4</option>
                        <option value="1">241-2</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" nod-tips="单据页面制单人是否可选">制单人可选</label>
                <div class="layui-input-inline">
                    <select id="user_opt">
                        <option value="0">否</option>
                        <option value="1">是</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" nod-tips="启用后将自动审核单据">单据自动审核</label>
                <div class="layui-input-inline">
                    <select id="auto_auditing">
                        <option value="0">否</option>
                        <option value="1">是</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" nod-tips="是否启用批次功能">启用批次功能</label>
                <div class="layui-input-inline">
                    <select id="enable_batch">
                        <option value="0">否</option>
                        <option value="1">是</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" nod-tips="是否启用串码功能">启用串码功能</label>
                <div class="layui-input-inline">
                    <select id="enable_serial">
                        <option value="0">否</option>
                        <option value="1">是</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-tab-item">
            <div class="layui-form-item">
                <label class="layui-form-label" nod-tips="零售页面标题信息">零售标题</label>
                <div class="layui-input-inline">
                    <input type="text" id="cashier_title" placeholder="请输入零售标题" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" nod-tips="例：【比例1为1元等于1积分，比例2为1元等于2积分】">积分比例</label>
                <div class="layui-input-inline">
                    <input type="text" id="integral_proportion" placeholder="请输入积分比例" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" nod-tips="预设零售页面客户信息">默认客户</label>
                <div class="layui-input-inline">
                    <div id="cashier_customer_page" class="selectpage"></div>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" nod-tips="预设零售页面资金账户">默认资金账户</label>
                <div class="layui-input-inline">
                    <div id="cashier_account_page" class="selectpage"></div>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label" nod-tips="提交零售单后自动打印小票">自动打印小票</label>
                <div class="layui-input-inline">
                    <select id="cashier_print">
                        <option value="0">否</option>
                        <option value="1">是</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-tab-item">
            <div class="layui-form-item">
                <label class="layui-form-label" nod-tips="首页数据图表天数">图表天数</label>
                <div class="layui-input-inline">
                    <input type="text" id="form_day" placeholder="请输入数据图表天数" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label" nod-tips="首页公告模块显示的内容">公告信息</label>
                <div class="layui-input-block">
                    <textarea id="notice" placeholder="请输入公告信息" class="layui-textarea"></textarea>
                </div>
            </div>
        </div>
    </div>
    <?php if((get_root('senior_add'))): ?>
        <div class="set_btn">
            <button class="layui-btn" onclick="save();">保存设置</button>
        </div>
    <?php endif; ?>
</div>
<script type="text/javascript" charset="utf-8">
    var sys=<?php echo json_encode($sys); ?>;
    var cashier_customer_selectdata=<?php echo get_selectpage('customer',$sys['cashier_customer']); ?>;
    var cashier_account_selectdata=<?php echo get_selectpage('account',$sys['cashier_account']); ?>;
</script>
<script src="/skin/js/public/selectpage.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/sys/sys.js" type="text/javascript" charset="utf-8"></script>
</div>
        <?php hook_listen('pagemore',['js']); ?>
    </body>
</html>