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
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/style.css"/>
    <![endif]-->

    <meta charset="UTF-8">
    <title>学生 领书详情</title>

    <!-- 载入bootstr吧ap的css -->
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
    <script src="js/jquery-3.4.1.js"></script>
    <!-- 包括所有已编译的插件 -->
    <script src="bootstrap/js/bootstrap.js"></script>
    <script>
        $(function () {
            queryReceiveBooks();

            //加载班级领书信息
            function queryReceiveBooks() {

                $.ajax({

                    url:"workbench/book/queryReceiveBooks.do",
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
                            html+="<td>"+n.book_name+"</td>";
                            html+="<td>"+n.isbn+"</td>";
                            html+="<td>"+n.author+"</td>";
                            html+="<td>"+n.book_price+"</td>";
                            html+="<td>"+n.book_publisher+"</td>";
                            html+="<td>"+n.pub_time+"</td>";
                            html+="<td>"+n.storage_time+"</td>";
                            html+="<td>"+n.grant_time+"</td>";
                            html+="<td>"+n.grant_place+"</td>";


                            html+="</tr>";

                        });
                        $("#bookBody").html(html);
                    }
                });


            }
            
            
        })
    </script>

</head>
<body>
<div >
    <h2  style="text-align: center;">学生 领书详情</h2>
</div>

<div class="page-container">
    <!--表格正文-->
    <div class="mt-5">
        <table class="table  table-bordered table-hover table-striped ">
            <caption>领书详情 表</caption>
            <thead>
            <tr class="text-c bc-blue">
                <th>ID</th>
                <th>教材名称</th>
                <th>ISBN号</th>
                <th>作者</th>
                <th>教材单价</th>
                <th>出版社</th>
                <th>出版时间</th>
                <th>入库时间</th>
                <th>领书时间</th>
                <th>领书地点</th>

            </tr>
            </thead>

            <tbody id="bookBody">
            <tr class="text-c">
                <td>1</td>
                <td>第二学期</td>
                <td>NO.39</td>
                <td>Java从入门到精通</td>
                <td>9787302444541</td>
                <td>明日科技</td>
                <td>69.80元</td>
                <td>清华大学出版社</td>
                <td>2016.10.01</td>
                <td>2020.02.29</td>
                <td>2020.09.05</td>
                <td>待领取</td>
            </tr>

            </tbody>
        </table>
    </div>
</div>


</body>
</html>