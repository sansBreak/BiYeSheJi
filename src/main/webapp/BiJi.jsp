<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%--本jsp保存一些经常重复使用的代码--%>

    <%--base标签--%>
    <base href="<%=basePath%>">

<%--  ajax  --%>
<script type="text/javascript">

    $.ajax({

        url:"",
        //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
        data:{

        },
        type:"get/post",
        dataType:"json",
        success:function () {

        }
    });

    //加入时间控件  使用的是class选择器
    $(".time").datetimepicker({
        minView: "month",
        language: 'zh-CN',
        format: 'yyyy-mm-dd',
        autoclose: true,
        todayBtn: true,
        pickerPosition: "bottom-left"
    });

    String createBy = ((User)request.getSession().getAttribute("user")).getName()

    /*js中取得session中的值*/
    var identity="<%=session.getAttribute("identity")%>";

    /*在jsp中导入包*/
    <%@page import="per.liu.domain.*"%>

    //从session中取得对象的属性
    <%Student user1 = (Student)request.getSession().getAttribute("user");%>
    var name = '<%=user1.getName() %>';
    alert(name);

    //纯java方式
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
</script>

<body>
<article class="page-container box-shadow-grey" style=" margin:50px auto; width:35%;  ">
    <form action="/" method="post" class="form form-horizontal" id="form-change-password">
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>账户：</label>
            <div class="formControls col-xs-8 col-sm-9"> 张三 </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>新密码：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="password" class="input-text" autocomplete="off" placeholder="请输入新密码" name="newpassword" id="newpassword">
            </div>
        </div>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-3"><span class="c-red">*</span>确认密码：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <input type="password" class="input-text" autocomplete="off" placeholder="请再次输入新密码" name="newpassword2" id="new-password2">
            </div>
        </div>
        <div class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;保存&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</article>
</body>


</body>
</html>
