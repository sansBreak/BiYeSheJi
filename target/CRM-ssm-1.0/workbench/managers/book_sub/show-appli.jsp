<%@ page import="per.liu.domain.*" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html >
<head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/lib/Hui-iconfont/1.0.8/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <![endif]-->

    <meta charset="UTF-8">
    <title>查看申请订单</title>

    <!-- 载入bootstrap的css -->
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
    <script src="js/jquery-3.4.1.js"></script>
    <!-- 包括所有已编译的插件 -->
    <script src="bootstrap/js/bootstrap.js"></script>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/style.css"/>



    <script>
        $(function () {

            //发起ajax请求，获取所有
            $.ajax({
                url:"workbench/application/query-AllApplication.do",
                //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                data:{
                },
                type:"post",
                dataType:"json",
                //返回结果是个list集合
                success:function (data) {
                    var html="";
                    $.each(data, function (i, n) {

                        html+="<tr class='text-c'>";
                        html+="<td>"+n.id+"</td>";      //订单编号
                        html+="<td>"+n.book_name+"</td>";     //教材名称
                        html+="<td>"+n.book_price+"</td>";    //教材单价
                        html+="<td>"+n.book_publisher+"</td>";    //出版社
                        html+="<td>"+n.tch_name+"</td>";          //申请老师
                        html+="<td>"+n.class_name+"</td>";          //申请班级
                        html+="<td>"+n.appli_amount+"</td>";    //申请数量

                        if ("未审批" == n.status){
                            html+="<td><button type='button' class='btn btn-info btn-sm custom'>"+n.status+"</button></td>";//状态

                        }else if ("审批未通过" == n.status){
                            html+="<td><button type='button' class='btn btn-danger btn-sm custom'>"+n.status+"</button></td>";//状态

                        }else if ("审批通过" == n.status){
                            html+="<td><button type='button' class='btn btn-success btn-sm custom'>"+n.status+"</button></td>";//状态
                        }
                        html+="</tr>";



                    });
                    $("#shpwAppli-body").html(html);

                }
            });

        })
    </script>

</head>
<body>
<div>
    <h2 style="text-align: center;">管理员 查看申请订单</h2>
</div>

<div class="page-container">
    <!--表格正文-->
    <div class="mt-5">
        <table class="table  table-bordered table-hover table-striped ">
            <caption>查看申请订单</caption>
            <thead>
            <tr class="text-c bc-blue">
                <th>订单编号</th>
                <th>教材名称</th>
                <th>教材单价</th>
                <th>出版社</th>
                <th>申请老师</th>
                <th>申请班级</th>
                <th>申请数量</th>
                <th data-formatter="displaycolor">状态</th>
            </tr>
            </thead>

            <tbody id="shpwAppli-body">


            </tbody>
        </table>
    </div>
</div>


</body>
</html>