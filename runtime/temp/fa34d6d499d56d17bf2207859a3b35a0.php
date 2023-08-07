<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:77:"D:\nodcloud-master\nodcloud-master/application/index\view\develop\action.html";i:1689602947;s:72:"D:\nodcloud-master\nodcloud-master\application\index\view\main\main.html";i:1689602947;}*/ ?>
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
<div class="layui-form layui-form-pane">
    <div class="layui-row">
        <div class="layui-col-xs3 layui-col-xs-offset9  layui-btn-group btn_group_right">
            <button class="layui-btn layui-btn-primary" onclick="detail(0);">新增</button>
            <button class="layui-btn layui-btn-primary" onclick="reload();"><i class="layui-icon layui-icon-refresh"></i></button>
        </div>
    </div>
    <hr />
    <div class="layui-row">
        <div class="layui-col-md12">
            <table class="layui-table table_center remove_margin" id="tab">
                <thead>
                    <tr>
                        <th>所属行为</th>
                        <th>行为名称</th>
                        <th>行为内容</th>
                        <th>行为排序</th>
                        <th>备注信息</th>
                        <th>相关操作</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if(is_array($list) || $list instanceof \think\Collection || $list instanceof \think\Paginator): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?>
                        <tr id="<?php echo $vo['id']; ?>" pid="<?php echo $vo['pid']; ?>">
                            <td><?php if($vo['pid'] == '0'): ?>顶级行为<?php else: ?><?php echo $vo['pidinfo']['name']; endif; ?></td>
                            <td><?php echo $vo['name']; ?></td>
                            <td><?php echo $vo['value']; ?></td>
                            <td><?php echo $vo['sort']; ?></td>
                            <td><?php echo $vo['data']; ?></td>
                            <td>
                                <div class="layui-btn-group">
                                    <button class="layui-btn layui-btn-sm layui-btn-primary" onclick="detail(<?php echo $vo['id']; ?>);">修改</button>
                                    <button class="layui-btn layui-btn-sm layui-btn-primary" onclick="del(<?php echo $vo['id']; ?>);">删除</button>
                                </div>
                            </td>
                        </tr>
                    <?php endforeach; endif; else: echo "" ;endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript" charset="utf-8">
    var ztree_data=<?php $list=array_filter($list,function($nod){return $nod['pid']==0 && ($nod);});array_unshift($list,['id'=>0,'pid'=>0,'name'=>'顶级行为','open'=>'true']);echo json_encode(array_field($list,['id','pid','name','open'])); ?>;
</script>
<script src="/skin/js/public/treeTable.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/public/ztree.js" type="text/javascript" charset="utf-8"></script>
<script src="/skin/js/develop/action.js" type="text/javascript" charset="utf-8"></script>
</div>
        <?php hook_listen('pagemore',['js']); ?>
    </body>
</html>