<%@ page import="per.liu.domain.Student" %>
<%@ page import="per.liu.domain.Teacher" %>
<%@ page import="per.liu.domain.Manager" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>学生 个人信息</title>

    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/lib/Hui-iconfont/1.0.8/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/style.css">
    <![endif]-->

    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/style.css"/>

    <script>
        $(function () {
            //从session中取得当前用户的身份
            <%
                Object user = request.getSession().getAttribute("user");
                String identity = (String) request.getSession().getAttribute("identity");
                String userName=null;
                if ("stu".equals(identity)){
                         userName = ((Student)user).getName();
                }else if ("tch".equals(identity)){
                         userName = ((Teacher)user).getName();
                }else if ("mgr".equals(identity)){
                         userName = ((Manager)user).getName();
                }
            %>
			//将通过session取得用户姓名放在页面中
            var name = '<%=userName%>';
            $("#userName-div").html(name);

            //修改密码操作
            $("#btn-save").click(function () {
                //运行改密码函数
                changePwd();
            })

			//自定义函数：用于更改密码
			function changePwd() {
				var pwd = $("#newpassword").val();
				var pwd2 = $("#newpassword2").val();

				//对两次输入的密码进行判断
                if (pwd !== pwd2){
                    $("#msg").html("两次输入的密码不一致!!!");
                    return false;
                }
                if (pwd==="" || pwd2===""){
                    $("#msg").html("请输入完整密码！！！");
                    return false;   //若账号密码为空，则需要停止执行后续方法
                }
                if (pwd.length <6){
                    $("#msg").html("密码最低为6位！！！");
                    return false;   //若账号密码为空，则需要停止执行后续方法
                }

				//像后台发起ajax请求
				$.ajax({
					url:"user/change-password.do",
					data:{
					    //两次输入的密码是否一致，在前端确即可
						"loginPwd":pwd,
					},
					type:"post",
					dataType:"json",
					success:function (data) {
					    //返回值为boolean类型，可以直接进行判断
						if (data){
							alert("更改成功");
						}
					}
				});

                //处理完毕后，页面复位
                /*this.location.reload();*/
                $("#newpassword").val("");
                $("#newpassword2").val("");
                $("#msg").html("修改密码成功！！！");
                return false;
            }
        })
    </script>
</head>
<body class="">
<article class="page-container box-shadow-grey" style=" margin:50px auto; width:35%;  ">
    <form action="/" method="post" class="form form-horizontal" id="form-change-password">
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-4">账户：</label>
            <div id="userName-div" class="formControls col-xs-8 col-sm-8"></div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-4"><span class="c-red">*</span>新密码：</label>
            <div class="formControls col-xs-8 col-sm-8">
                <input type="text" class="input-text" autocomplete="off" placeholder="请输入新密码" name="newpassword"
                       id="newpassword">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-4"><span class="c-red">*</span>确认密码：</label>
            <div class="formControls col-xs-8 col-sm-8">
                <input type="text" class="input-text" autocomplete="off" placeholder="请再次输入新密码" name="newpassword2"
                       id="newpassword2">
                <span id="msg" style="color: red ;font-weight: bold">&nbsp</span>
            </div>
        </div>
        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-4">
                <input id="btn-save" class="btn btn-primary " value="保存">
            </div>
        </div>
    </form>
</article>
</body>
</html>