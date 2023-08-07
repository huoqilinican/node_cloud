<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:77:"D:\nodcloud-master\nodcloud-master/application/index\view\recashier\main.html";i:1689602947;s:72:"D:\nodcloud-master\nodcloud-master\application\index\view\main\main.html";i:1689602947;}*/ ?>
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
<link rel="stylesheet" href="/skin/css/jqui.css" type="text/css" media="all" />
<link rel="stylesheet" href="/skin/css/jqgrid.css" type="text/css" media="all" />
<link rel="stylesheet" href="/skin/css/select2.css" type="text/css" media="all" />
<div class="layui-form layui-form-pane">
    <div class="push_data">
        <div class="layui-row">
            <div class="layui-col-xs9">
                <div class="layui-row layui-col-space3">
                    <div class="layui-col-xs4">
                        <div class="layui-form-item remove_margin reset_item">
                            <label class="layui-form-label">客户</label>
                            <div class="layui-input-block">
                                <div id="nod_customer" class="selectpage" nod="customer" tip="请选择客户" url="/index/service/customer_list"></div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4">
                        <div class="layui-form-item remove_margin reset_item">
                            <label class="layui-form-label">单据日期</label>
                            <div class="layui-input-block">
                                <input type="text" class="layui-input" id="time" placeholder="请输入单据日期" value="<?php echo (isset($class['time']) && ($class['time'] !== '')?$class['time']:date('Y-m-d',time())); ?>" />
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-xs4">
                        <div class="layui-form-item remove_margin reset_item">
                            <label class="layui-form-label">单据编号</label>
                            <div class="layui-input-block">
                                <input type="text" class="layui-input" id="number" placeholder="请输入单据编号" value="<?php echo (isset($class['number']) && ($class['number'] !== '')?$class['number']:get_number('LSTHD')); ?>" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="set_btn">
                <?php if(empty(\think\Request::instance()->get('id')) || ((\think\Request::instance()->get('id') instanceof \think\Collection || \think\Request::instance()->get('id') instanceof \think\Paginator ) && \think\Request::instance()->get('id')->isEmpty())): ?>
                    <button class="layui-btn layui-btn-normal" onclick="save('0');">新增单据</button>
                <?php else: if(empty($class['type']['nod']) || (($class['type']['nod'] instanceof \think\Collection || $class['type']['nod'] instanceof \think\Paginator ) && $class['type']['nod']->isEmpty())): if((get_root('recashier_edit'))): ?>
                            <button class="layui-btn layui-btn-normal" onclick="save(<?php echo isset($class['id'])?$class['id']:'0'; ?>);">保存单据</button>
                        <?php endif; if((get_root('recashier_auditing'))): ?>
                            <button class="layui-btn layui-btn-primary" onclick="auditing(<?php echo isset($class['id'])?$class['id']:'0'; ?>,true);">审核单据</button>
                        <?php endif; else: if((get_root('recashier_auditing'))): ?>
                            <button class="layui-btn layui-btn-primary" onclick="auditing(<?php echo $class['id']; ?>,false);">反审核单据</button>
                        <?php endif; endif; endif; ?>
                <button class="layui-btn" onclick="replace();">重新载入</button>
            </div>
        </div>
    </div>
    <div class="layui-row top_12">
        <div class="layui-col-md12">
            <table id="data_table"></table>
        </div>
    </div>
    <div class="push_data">
        <div class="layui-row layui-col-space12 top_12">
            <div class="layui-col-xs4">
                <div class="layui-form-item remove_margin">
                    <label class="layui-form-label">单据金额</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" id="total" placeholder="单据金额" disabled value="<?php echo isset($class['total'])?$class['total']:''; ?>" />
                    </div>
                </div>
            </div>
            <div class="layui-col-xs4">
                <div class="layui-form-item remove_margin ">
                    <label class="layui-form-label" onclick="get_totals();">实际金额</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" id="actual" placeholder="实际金额 | 点击左侧快捷录入" value="<?php echo isset($class['actual'])?$class['actual']:''; ?>" />
                    </div>
                </div>
            </div>
            <div class="layui-col-xs4">
                <div class="layui-form-item remove_margin ">
                    <label class="layui-form-label">实付金额</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" id="money" placeholder="请输入实付金额" value="<?php echo isset($class['money'])?$class['money']:''; ?>" disabled="disabled"/>
                    </div>
                </div>
            </div>
            <div class="layui-col-xs4">
                <div class="layui-form-item remove_margin ">
                    <label class="layui-form-label">制单人</label>
                    <div class="layui-input-block">
                        <div id="nod_user" class="selectpage" nod="user" tip="请选择制单人" url="/index/service/user_list"></div>
                    </div>
                </div>
            </div>
            <div class="layui-col-xs4">
                <div class="layui-form-item remove_margin ">
                    <label class="layui-form-label">结算账户</label>
                    <div class="layui-input-block">
                        <div id="nod_account" class="selectpage" nod="account" tip="请选择结算账户" url="/index/service/account_list"></div>
                    </div>
                </div>
            </div>
            <div class="layui-col-xs4">
                <div class="layui-form-item remove_margin ">
                    <label class="layui-form-label">扣除积分</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" id="integral" placeholder="请输入扣除积分" value="<?php echo isset($class['integral'])?$class['integral']:''; ?>" />
                    </div>
                </div>
            </div>
            <div class="layui-col-xs4">
                <div class="layui-form-item remove_margin ">
                    <label class="layui-form-label" id="upload_region">单据附件</label>
                    <div class="layui-input-block" onclick="look_file(this);">
                        <input type="text" id="file" class="layui-input" placeholder="点击左侧区域上传" disabled nod="<?php echo (isset($class['file']) && ($class['file'] !== '')?$class['file']:''); ?>" value="<?php if(!(empty($class['file']) || (($class['file'] instanceof \think\Collection || $class['file'] instanceof \think\Paginator ) && $class['file']->isEmpty()))): ?>[ 已上传 | 点击查看 ]<?php endif; ?>" />
                    </div>
                </div>
            </div>
            <div class="layui-col-xs8">
                <div class="layui-form-item remove_margin ">
                    <label class="layui-form-label">备注信息</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" id="data" placeholder="请输入备注信息" value="<?php echo isset($class['data'])?$class['data']:''; ?>" />
                    </div>
                </div>
            </div>
            <more></more>
        </div>
    </div>
</div>
<script src="/skin/js/public/public_table.js" type="text/javascript" charset="utf-8"></script>
<script type="text/html" id="more_html"><?php hook_listen('formmore'); ?></script>
<script type="text/javascript" charset="utf-8">
    var price_type='retail';//初始化价格类型
    var hide_field={hide_field:'buy,sell'};//设置隐藏的字段信息
    var auditing_type='<?php echo isset($class['type']['nod'])?$class['type']['nod']:'0'; ?>';
    var sys=<?php echo json_encode(get_sys(['user_opt','enable_batch','enable_serial','integral_proportion'])); ?>;
    var formfield=<?php echo get_formfield('recashier_main','jqgrid'); ?>;
    var more_val=<?php if(empty($class) || (($class instanceof \think\Collection || $class instanceof \think\Paginator ) && $class->isEmpty())): ?>{}<?php else: ?><?php echo json_encode($class['more']); endif; ?>;
    var plug_val=<?php if(empty($class) || (($class instanceof \think\Collection || $class instanceof \think\Paginator ) && $class->isEmpty())): ?>{nod_user:<?php echo get_selectpage('user',Session('is_user_id')); ?>}<?php else: ?>{nod_user:<?php echo get_selectpage('user',$class['user']); ?>,nod_customer:<?php echo get_selectpage('customer',$class['customer']); ?>,nod_account:<?php echo get_selectpage('account',$class['account']); ?>}<?php endif; ?>;
    var bill_info=<?php if(empty($class) || (($class instanceof \think\Collection || $class instanceof \think\Paginator ) && $class->isEmpty())): ?>{}<?php else: ?><?php echo json_encode($info); endif; ?>;
    sys.user_opt==0&&($('#nod_user').attr('disabled','disabled'));
</script>
<script src="/skin/js/public/jqgrid.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/public/selectpage.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/public/select2.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/recashier/table.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/recashier/main.js" type="text/javascript" charset="utf-8"></script>
</div>
        <?php hook_listen('pagemore',['js']); ?>
    </body>
</html>