<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>">

    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/lib/Hui-iconfont/1.0.8/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/style.css"/>
    <![endif]-->

    <title>教材管理系统后台——管理员</title>
</head>
<body>

<!-- 顶部菜单栏 -->
<header class="navbar-wrapper">
    <div class="navbar navbar-fixed-top" style="background-color: #3c3c3c">
        <div class="container-fluid cl">
            <a class="logo navbar-logo f-l mr-10 hidden-xs"
               style="font-size: 30px; font-weight: 400; color: white; font-family: 'STXinwei'">教材管理系统</a>
            <span class="logo navbar-slogan f-l mr-10 hidden-xs">@2021</span>
            <a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;">&#xe667;</a>

            <!--原模板中：用于新增资源的下拉菜单选项-->
            <!--<nav class="nav navbar-nav">
                <ul class="cl">
                    <li class="dropDown dropDown_hover"><a href="javascript:;" class="dropDown_A"><i
                            class="Hui-iconfont">&#xe600;</i> 新增11 <i class="Hui-iconfont">&#xe6d5;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" onclick="article_add('添加资讯','article-add.html')"><i
                                    class="Hui-iconfont">&#xe616;</i> 资讯</a></li>
                            <li><a href="javascript:;" onclick="picture_add('添加资讯','picture-add.html')"><i
                                    class="Hui-iconfont">&#xe613;</i> 图片</a></li>
                            <li><a href="javascript:;" onclick="product_add('添加资讯','product-add.html')"><i
                                    class="Hui-iconfont">&#xe620;</i> 产品</a></li>
                            <li><a href="javascript:;" onclick="member_add('添加用户','member-add.html','','510')"><i
                                    class="Hui-iconfont">&#xe60d;</i> 用户</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>-->

            <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
                <ul class="cl">
                    <li>身份——管理员 &nbsp&nbsp</li>
                    <li class="dropDown dropDown_hover">
                        <a href="#" class="dropDown_A">admin <i class="Hui-iconfont">&#xe6d5;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="login.jsp">切换账户</a></li>
                            <li><a href="#">退出</a></li>
                        </ul>
                    </li>


                    <li id="Hui-skin" class="dropDown right dropDown_hover"><a href="javascript:;" class="dropDown_A"
                                                                               title="换肤"><i class="Hui-iconfont"
                                                                                             style="font-size:18px">&#xe62a;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
                            <li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
                            <li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
                            <li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
                            <li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
                            <li><a href="javascript:;" data-val="orange" title="橙色">橙色</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>

<!--左栏-->
<aside class="Hui-aside">
    <div class="menu_dropdown bk_2">

        <dl id="menu-stu-teach-class">
            <dt><i class="Hui-iconfont">&#xe616;</i> 师生班级管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="workbench/managers/stu-teach-class/stumanage.jsp" data-title="学生管理" href="javascript:void(0)">学生管理</a></li>
                    <li><a data-href="workbench/managers/stu-teach-class/classmanage.jsp" data-title="班级管理" href="javascript:void(0)">班级管理</a></li>
                    <li><a data-href="workbench/managers/stu-teach-class/teachmanage.jsp" data-title="教师管理" href="javascript:void(0)">教师管理</a></li>
                </ul>
            </dd>
        </dl>
        <dl id="menu-bookmanage">
            <dt><i class="Hui-iconfont">&#xe616;</i> 教材管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="workbench/managers/book-manage/book-info.jsp" data-title="库存列表" href="javascript:void(0)">图书列表</a>
                    </li>
                </ul>
                <ul>
                    <li><a data-href="workbench/managers/book-manage/book-register.jsp" data-title="教材入库" href="javascript:void(0)">图书入库</a>
                    </li>
                </ul>

            </dd>
        </dl>
        <dl id="menu-booksub">
            <dt><i class="Hui-iconfont">&#xe616;</i> 订书订单管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="workbench/managers/book_appli/show-appli.jsp" data-title="订单列表" href="javascript:void(0)">订单列表</a>
                    </li>
                </ul>
            </dd>
        </dl>
        <dl id="menu-myData">
            <dt><i class="Hui-iconfont">&#xe616;</i> 个人资料<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="workbench/base/personal-info.jsp" data-title="查看个人信息"
                           href="javascript:void(0)">查看个人信息</a></li>
                </ul>
                <ul>
                    <li><a data-href="workbench/base/change-password.jsp" data-title="修改密码" href="javascript:void(0)">修改密码</a>
                    </li>
                </ul>
            </dd>
        </dl>

    </div>
</aside>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a>
</div>
<section class="Hui-article-box">
    <div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
        <div class="Hui-tabNav-wp">
            <ul id="min_title_list" class="acrossTab cl">
                <li class="active">
                    <span title="我的桌面" data-href="welcome.html">我的桌面</span>
                    <em></em></li>
            </ul>
        </div>
        <div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S"
                                                  href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a
                id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a>
        </div>
    </div>
    <div id="iframe_box" class="Hui-article">
        <div class="show_iframe">
            <div style="display:none" class="loading"></div>
            <iframe scrolling="yes" frameborder="0" src="workbench/welcome.html"></iframe>
        </div>
    </div>
</section>

<div class="contextMenu" id="Huiadminmenu">
    <ul>
        <li id="closethis">关闭当前</li>
        <li id="closeall">关闭全部</li>
    </ul>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="workbench/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="workbench/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="workbench/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="workbench/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="workbench/lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
<script type="text/javascript">
    $(function () {
        /*$("#min_title_list li").contextMenu('Huiadminmenu', {
            bindings: {
                'closethis': function(t) {
                    console.log(t);
                    if(t.find("i")){
                        t.find("i").trigger("click");
                    }
                },
                'closeall': function(t) {
                    alert('Trigger was '+t.id+'\nAction was Email');
                },
            }
        });*/
    });

    /*个人信息*/
    /*单击顶栏的右侧用户名图标，打开一个模态窗口*/
    function myselfinfo() {
        layer.open({
            type: 1,
            area: ['300px', '200px'],
            fix: false, //不固定
            maxmin: true,
            shade: 0.4,
            title: '查看信息',
            content: '<div>管理员信息</div>'
        });
    }

    /*资讯-添加*/
    function article_add(title, url) {
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }

    /*图片-添加*/
    function picture_add(title, url) {
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }

    /*产品-添加*/
    function product_add(title, url) {
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }

    /*用户-添加*/
    function member_add(title, url, w, h) {
        layer_show(title, url, w, h);
    }


</script>


</body>
</html>