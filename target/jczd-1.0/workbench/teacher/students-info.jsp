<%@ page import="per.liu.domain.*" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/lib/Hui-iconfont/1.0.8/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <![endif]-->

    <meta charset="UTF-8">
    <title>学生 信息</title>

    <!-- 载入bootstrap的css -->
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
    <script src="js/jquery-3.4.1.js"></script>
    <!-- 包括所有已编译的插件 -->
    <script src="bootstrap/js/bootstrap.js"></script>
    <!--引入自定义的css文件-->
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/style.css"/>

    <script>
        $(function () {
            //页面加载后，自动加载学生信息
            query_AllStudent();


            function query_AllStudent() {

                $.ajax({

                    url:"user/query_AllStudent.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    data:{
                    },
                    type:"post",
                    dataType:"json",
                    success:function (data) {

                        var html="";
                        $.each(data, function (i, n) {

                            html+="<tr class='text-c'>";
                            html+="<td>"+n.id+"</td>";
                            html+="<td>"+n.loginAct+"</td>";
                            html+="<td>"+n.name+"</td>";
                            html+="<td>"+n.email+"</td>";
                            html+="<td>"+n.grade+"</td>";
                            html+="<td>"+n.classe+"</td>";
                            html+="<td>"+n.major+"</td>";
                            html+="<td>"+n.department+"</td>";


                            html+="</tr>";



                        });
                        $("#showStu-body").html(html);




                    }

                });


            }
        })


    </script>


</head>
<body>
<div>
    <h2 style="text-align: center;">学生 信息</h2>
</div>

<div class="page-container">
    <!--表格正文-->
    <div class="mt-5">
        <table class="table  table-bordered table-hover table-striped ">
            <caption>学生 信息</caption>
            <thead>
            <tr class="text-c bc-blue">
                <th>编号</th>
                <th>学号</th>
                <th>姓名</th>
                <th>邮箱</th>
                <th>年级</th>
                <th>班级</th>
                <th>专业</th>
                <th>学院</th>
            </tr>
            </thead>

            <tbody id="showStu-body">

            </tbody>
        </table>
    </div>
</div>


</body>
</html>