<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
    <!--引入阿里矢量图标中的内容-->
    <script type="text/javascript" src="http://at.alicdn.com/t/font_2409766_vgauotpqav.js"></script>

    <style type="text/css">
        /*“书”图片的css配置*/
        .icon {
            height: 40px;
            vertical-align: -0em;
            fill: currentColor;
            overflow: hidden;
        }

        /*设置所有文本颜色*/
        p {
            color: #555;
        }
    </style>

    <script>
        $(function () {
            //如果当前登录页不是顶层窗口，将其设为顶层窗口
            if (window.top != window) {
                window.top.location = window.location;
            }

            //页面加载完毕后，将用户文本框中的内容清空，单选按钮复位
            $("#loginAct").val("");
            $("#loginPwd").val("");
            $("input[name=identity-radio]:eq(0)").prop("checked", 'checked');

            //页面打开后，自动为用户的文本框获得焦点
            $("#loginAct").focus();

            //为登录按钮绑定事件，执行登录操作
            $("#submitBtn").click(function () {
                login();
            })

            //绑定键盘事件，敲击回车键登录
            $(window).keydown(function (event) {
                // event只是一个变量名，随意编写，是一个引用，指向了一个事件对象，所有的键盘事件对象都有一个keyCode属性，用来获取键值。				有的键盘事件对象都有一个keyCode属性，用来获取键值。
                if (event.keyCode === 13) { // 回车键是13
                    login();
                }
            });
        })

        //自定义方法，写在$(function(){})的外面
        function login() {
            /*取用户登录身份*/
            $xz = $("input[name=identity-radio]:checked");
            var identity = $xz.val();

            //首先验证账号密码不能为空
            /*取得账号密码，使用$.trim(文本)去掉左右空格*/
            var loginAct = $.trim($("#loginAct").val());
            var loginPwd = $.trim($("#loginPwd").val());

            if (loginAct == "" || loginPwd == "") {
                $("#msg").html("用户名或密码不能为空！！！")
                return false;   //若账号密码为空，则需要停止执行后续方法
            }

            //去后台验证登录相关操作
            $.ajax({
                url: "user/login.do",
                data: {
                    "identity": identity,
                    "loginAct": loginAct,
                    "loginPwd": loginPwd,
                },
                type: "post",
                dataType: "json",
                success: function (data) {
                    /*
                    data{"success":true/false,"msg":"哪里出错"}
                    * */
                    //如果登录成功，跳转到欢迎页
                    if (data.success) {

                        if (identity == "stu") {
                            window.location.href = "workbench/student/index.jsp";
                        }else if (identity == "tch"){
                            window.location.href = "workbench/teacher/index.jsp";
                        }else if (identity == "mgr"){
                            window.location.href = "workbench/managers/index.jsp";
                        }

                        //如果登录失败，则显示错误信息
                    } else {
                        $("#msg").html(data.msg);
                    }
                }
            })
        }
    </script>

</head>
<body style="background: #F6F6F6">

<!--顶部通栏-->
<div style="background-color: #3C3C3C; height: 45px;">
    <div class="col-md-3 col-md-offset-1"
         style=";position: absolute;  left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'STXinwei'">
        教材管理系统 <span style="font-size: 12px;">&copy;@2021&nbsp;</span>
    </div>
</div>

<!--左侧放一个“书”的图片，右侧放一个登录框-->
<div class="container" style="padding-top: 50px;padding-bottom: 100px;">
    <div class="row">
        <!--左侧-->
        <div class="col-md-5 col-sm-3" style="margin-top: 70px;">
            <img src="imgs/book.png" style="width: 100%"/>
        </div>

        <!--中间放个div，用于放置一个竖线-->
        <div class="col-md-1 col-sm-0" style="height: 450px;border-right:1px dashed #8B8682;"></div>

        <!--右侧-->
        <div class="col-md-5 col-md-offset-1 col-sm-3"
             style="margin-top: 70px;padding-bottom: 30px;border:2px solid #8B8989;box-shadow:4px 4px 5px #999">
            <div class="page-header" style="padding-left: 80px">
                <h1 style="font-size: 28px;color: #1191ef; font-family: '微软雅黑 '">用户登录</h1>
            </div>
            <%--表单--%>
            <form action="#" class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="control-label  form-inline col-md-3">用户身份</label>
                    <div class="col-md-8">
                        <label class="radio-inline">
                            <input type="radio" name="identity-radio" value="stu" checked> 学生
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="identity-radio" value="tch"> 教师
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="identity-radio" value="mgr"> 管理员
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label  form-inline col-md-3" for="loginAct">账号</label>
                    <div class="col-md-8">
                        <input type="text" class="form-control " id="loginAct" placeholder="请输入账号">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label form-inline col-md-3" for="loginPwd">密码</label>
                    <div class="col-md-8">
                        <input type="password" class="form-control" id="loginPwd" placeholder="请输入密码">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-8 col-md-offset-3">
                        <span id="msg" style="color: red ;font-weight: bold">&nbsp</span>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-8 col-md-offset-2" style="border: 0px solid red">
                        <button type="button" class="btn btn-primary btn-lg btn-block"
                                style=" position: relative;top: 5px;" id="submitBtn">登录
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!--左下方放一个文本域，写温馨提示-->
        <div class="col-md-7" style="height: 50px">
            <p class="lead" style="color: #fda855; font-weight: bold">温馨提示：</p>
            <p>1、教师账号为教师工号，学生账号为学生学号，不可更改。</p>
            <p>2、默认密码均为账号后六位，建议登陆后修改默认密码。</p>
            <p>3、祝你使用愉快，若在使用过程中出现问题，请及时联系管理员。</p>
        </div>

    </div>

</div>


</body>
</html>