<?php if (!defined('THINK_PATH')) exit(); /*a:1:{s:73:"D:\nodcloud-master\nodcloud-master/application/index\view\main\about.html";i:1689602947;}*/ ?>
<div class="layui-card-header">版本信息-全开源版本</div>
<div class="layui-card-body layui-text layadmin-about">
    <script type="text/html" template>
        <p>当前版本：<span id="now_ver"><?php echo $now_ver; ?></span></p>
    </script>
    <div class="layui-btn-container" style="text-align: center;">
        <?php if(($now_ver==$new_ver['ver'])): ?>
            <a href="https://www.nodcloud.com" target="_blank" class="layui-btn layui-btn-danger">官网首页</a>
        <?php else: $number=auth_number(); ?>
            <a lay-text="升级系统" lay-href="<?php echo $new_ver['url']; ?>?number=<?php echo $number; ?>" class="layui-btn layui-btn-danger">升级系统</a>
        <?php endif; ?>
        <a href="https://p.qiao.baidu.com/cps/chat?siteId=13056976&userId=27301598" target="_blank" class="layui-btn">联系客服</a>
    </div>
</div>
<div class="layui-card-header">关于版权</div>
<div class="layui-card-body layui-text layadmin-about">
    <blockquote class="layui-elem-quote" style="border: none;">点可云进销存系统受国家计算机软件著作权(2019SR0135099)保护，未经官网正规渠道授权擅自公开产品源文件、以及对产品二次出售或以任何形式二次发布的，我们将保留追究法律责任的权利。</blockquote>
    
<div class="layui-card-header">关于开源</div>
<div class="layui-card-body layui-text layadmin-about">
    <blockquote class="layui-elem-quote" style="border: none;">点可云进销存 V5、V6版本 于2022年7月20日，全面开源。并在GITEE\GITHUB上发行。允许用于个人学习、毕业设计、教学案例、公益事业；如果商用必须保留版权信息，请自觉遵守；禁止将本项目的代码和资源进行任何形式的出售，产生的一切任何后果责任由侵权者自负。</blockquote> 
<p>© 2019 <a href="https://www.nodcloud.com" target="_blank">NODCLOUD.COM</a> 版权所有</p>
<a href="https://gitee.com/yimiaoOpen/nodcloud" style="
    margin: 0 auto;
    margin-left: 26%;
"><img src="https://gitee.com/yimiaoOpen/nodcloud/widgets/widget_3.svg" alt="Fork me on Gitee"></a>
</div>