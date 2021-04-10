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


    //解除关联
    $.each(data, function (i, n) {
        html += '<tr>';
        html += '<td>' + n.name + '</td>';
        html += '<td>' + n.startDate + '</td>';
        html += '<td>' + n.endDate + '</td>';
        html += '<td>' + n.owner + '</td>';            //unbund(\''+n.id+'\')中，我希望取得的id是关联关系表中的id，用于解除管理,在dao层中，可将该条activity的id改为tbl_clue_activity_relation的id
        html += '<td><a href="javascript:void(0);" onclick="unbund(\'' + n.id + '\')" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a></td>';
        html += '</tr>';
    })
    $("#activityBody").html(html)

</script>

<body>
<article class="page-container box-shadow-grey" style=" margin:50px auto; width:35%;  ">
</article>
</body>


</body>
</html>
