<?php if (!defined('THINK_PATH')) exit(); /*a:2:{s:72:"D:\nodcloud-master\nodcloud-master/application/index\view\main\home.html";i:1689602947;s:72:"D:\nodcloud-master\nodcloud-master\application\index\view\main\main.html";i:1689602947;}*/ ?>
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
    <link rel="stylesheet" href="/skin/css/home.css" media="all">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md9">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">常用功能</div>
                        <div class="layui-card-body">
                            <div class="layui-carousel layadmin-carousel layadmin-shortcut">
                                <?php if(empty($often) || (($often instanceof \think\Collection || $often instanceof \think\Paginator ) && $often->isEmpty())): ?>
                                    <p style="position: absolute;font-size: 16px;top: 36%;left: 39%;" lay-tips="您可在【常用功能】中配置该内容"><i class="layui-icon layui-icon-component" style="margin-right: 6px;"></i> 这里空空如也~</p>
                                <?php else: ?>
                                    <div carousel-item>
                                        <?php if(is_array($often) || $often instanceof \think\Collection || $often instanceof \think\Paginator): $i = 0; $__LIST__ = $often;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$often_vo): $mod = ($i % 2 );++$i;?>
                                            <ul class="layui-row layui-col-space10">
                                                <?php if(is_array($often_vo) || $often_vo instanceof \think\Collection || $often_vo instanceof \think\Paginator): $i = 0; $__LIST__ = $often_vo;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$often_nod): $mod = ($i % 2 );++$i;?>
                                                    <li class="layui-col-xs3">
                                                        <a lay-href="<?php echo $often_nod['set']; ?>">
                                                            <i class="layui-icon layui-icon-star"></i>
                                                            <cite><?php echo $often_nod['name']; ?></cite>
                                                        </a>
                                                    </li>
                                                <?php endforeach; endif; else: echo "" ;endif; ?>
                                            </ul>
                                        <?php endforeach; endif; else: echo "" ;endif; ?>
                                    </div>
                                <?php endif; ?>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">汇总信息</div>
                        <div class="layui-card-body">
                            <div class="layui-carousel layadmin-carousel layadmin-backlog">
                                <div carousel-item>
                                    <ul class="layui-row layui-col-space10">
                                        <li class="layui-col-xs4">
                                            <a class="layadmin-backlog-body" lay-text="资金账户" lay-href="/index/account/main.html">
                                                <h3>资金总数</h3>
                                                <p><cite><?php echo $account; ?></cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs4">
                                            <a class="layadmin-backlog-body" lay-text="客户管理" lay-href="/index/customer/main.html">
                                                <h3>客户总数</h3>
                                                <p><cite><?php echo $customer; ?></cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs4">
                                            <a class="layadmin-backlog-body" lay-text="供应商管理" lay-href="/index/supplier/main.html">
                                                <h3>供应商总数</h3>
                                                <p><cite><?php echo $supplier; ?></cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs4">
                                            <a class="layadmin-backlog-body" lay-text="库存查询" lay-href="/index/main/room.html">
                                                <h3>库存总数</h3>
                                                <p><cite><?php echo $room; ?></cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs4">
                                            <a class="layadmin-backlog-body" lay-text="库存预警" lay-href="/index/main/room_warning.html">
                                                <h3>库存预警</h3>
                                                <p><cite><?php echo $roomwarning_nums; ?></cite></p>
                                            </a>
                                        </li>
                                        <li class="layui-col-xs4">
                                            <a class="layadmin-backlog-body" lay-text="职员管理" lay-href="/index/user/main.html">
                                                <h3>职员总数</h3>
                                                <p><cite><?php echo $user; ?></cite></p>
                                            </a>
                                        </li>
                                    </ul>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">数据概览</div>
                        <div class="layui-card-body">
                            <div class="layui-carousel layadmin-carousel layadmin-dataview" data-anim="fade" lay-filter="LAY-index-dataview">
                                <div carousel-item id="LAY-index-dataview">
                                    <div><i class="layui-icon layui-icon-loading1 layadmin-loading"></i></div>
                                    <div></div>
                                    <div></div>
                                    <div></div>
                                    <div></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-header">公告信息<i class="layui-icon layui-icon-tips" lay-tips="您可在【系统参数】中设置公告" lay-offset="5"></i></div>
                <div class="layui-card-body layui-text">
                    <?php if(empty($sys['notice']) || (($sys['notice'] instanceof \think\Collection || $sys['notice'] instanceof \think\Paginator ) && $sys['notice']->isEmpty())): ?>
                        <p style="text-align: center;font-size: 16px;line-height: 67px;"><i class="layui-icon layui-icon-component" style="margin-right: 6px;"></i> 这里空空如也~</p>
                    <?php else: ?>
                        <p><?php echo nl2br($sys['notice']); ?></p>
                    <?php endif; ?>
                </div>
            </div>
            <div class="layui-card">
                <div class="layui-card-header">负载监测</div>
                <div class="layui-card-body layadmin-takerates">
                    <?php 
                        $cache_max_size=128;
                        $cache_now_size=get_dir_size($_SERVER['DOCUMENT_ROOT'].DS.'runtime');
                        $cache_Percentage=round($cache_now_size*100/$cache_max_size,2);
                     ?>
                    <div class="layui-progress" lay-showPercent="yes">
                        <h3 lay-tips="缓存量大于80%建议清理" lay-offset="5">系统缓存量[<?php echo $cache_now_size; ?>M]</h3>
                        <div class="layui-progress-bar" lay-percent="<?php echo $cache_Percentage; ?>%"></div>
                    </div>
                    <?php 
                        $mysql_max_size=32;
                        $mysql_now_size=get_mysql_size();
                        $mysql_Percentage=round($mysql_now_size*100/$mysql_max_size,2);
                     ?>
                    <div class="layui-progress" lay-showPercent="yes">
                        <h3 lay-tips="数据量<?php echo $mysql_max_size; ?>M下可获得优质体验" lay-offset="5">存储数据量[<?php echo $mysql_now_size; ?>M]</h3>
                        <div class="layui-progress-bar" lay-percent="<?php echo $mysql_Percentage; ?>%"></div>
                    </div>
                </div>
            </div>
            <div class="layui-card">
                <div class="layui-card-header">环境信息</div>
                <div class="layui-card-body layui-text">
                    <table class="layui-table">
                        <colgroup>
                            <col width="120"><col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <td>系统类型</td>
                                <td><?php echo PHP_OS; ?></td>
                            </tr>
                            <tr>
                                <td>解译引擎</td>
                                <td><?php echo $_SERVER['SERVER_SOFTWARE']; ?></td>
                            </tr>
                            <tr>
                                <td>PHP版本</td>
                                <td><?php echo PHP_VERSION; ?></td>
                            </tr>
                            <tr>
                                <td>MYSQL版本</td>
                                <td><?php echo \think\db::query("select VERSION() as ver")[0]['ver']; ?></td>
                            </tr>
                            <tr>
                                <td>通信协议</td>
                                <td><?php echo $_SERVER['SERVER_PROTOCOL']; ?></td>
                            </tr>
                            <tr>
                                <td>程序版本</td>
                                <td><?php echo get_ver(); ?></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" charset="utf-8">
        var day=<?php echo json_encode($day_arr); ?>;//时间范围
        var echarts_data=<?php echo json_encode($echarts_data); ?>;//时间范围
    </script>
    <script src="/skin/js/main/home.js" type="text/javascript" charset="utf-8"></script>
</div>
        <?php hook_listen('pagemore',['js']); ?>
    </body>
</html>