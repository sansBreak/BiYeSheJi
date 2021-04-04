<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html >
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>老师 教材管理——书籍信息查询(学校仓库内)</title>

    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/lib/Hui-iconfont/1.0.8/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <![endif]-->

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
            //页面加载完成后，自动运行查询函数
            queryAllBookInfo();



            //为全选的复选框绑定事件
            $("#qx").click(function () {
                //当qx被点击时，name为xz的input标签全部被选中
                $("input[name=xz]").prop("checked",this.checked);

            });

            //若已经勾选的对象的数量与全部对象的数量相等，则全选框自动变为勾选；不相等则自动取消勾选
            $("#infoBody").on("click", $("input[name=xz]"), function () {
                $("#qx").prop("checked", $("input[name=xz]").length == $("input[name=xz]:checked").length);

            });

            //该函数用于查询仓库内所有图书信息
            function queryAllBookInfo() {
                //发起ajax请求
                $.ajax({
                    url:"workbench/book/query-AllBookInfo.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    data:{

                    },
                    type:"post",
                    dataType:"json",
                    //返回结果是个list集合
                    success:function (data) {
                        var html="";
                        $.each(data, function (i, n) {
                            //html+="<option value='"+n.id+"'>"+n.name+"</option>"

                            html+="<tr class='text-c'>";
                            html+='<td><input type="checkbox" name="xz" value="' + n.id + '"/></td>';
                            html+="<td>"+n.id+"</td>";
                            html+="<td>"+n.bId+"</td>";
                            html+="<td>"+n.name+"</td>";
                            html+="<td>"+n.isbn+"</td>";
                            html+="<td>"+n.author+"</td>";
                            html+="<td>"+n.price+"</td>";
                            html+="<td>"+n.publisher+"</td>";
                            html+="<td>"+n.pub_time+"</td>";
                            html+="<td>"+n.storage_time+"</td>";
                            html+="<td>"+n.amount+"</td>";
                            html+="</tr>";
                        });
                        $("#infoBody").html(html);
                    }
                });
            }
        });


    </script>
</head>
<body>
<div >
    <h2  style="text-align: center;">老师 订书订单管理——图书列表</h2>
</div>

<div class="page-container">

    <div class="btn-group" style="position: relative;bottom: 5px ;top: 18%;">
        <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span>
            申请教材
        </button>
    </div>

    <!--表格正文-->
    <div class="mt-5">
        <table class="table  table-bordered table-hover table-striped ">
            <thead>
                <tr class="text-c bc-blue">
                    <th><input id="qx" type="checkbox"/></th>
                    <th>ID</th>
                    <th>教材编号</th>
                    <th>教材名称</th>
                    <th>ISBN号</th>
                    <th>作者（主编）</th>
                    <th>教材单价</th>
                    <th>出版社</th>
                    <th>出版时间</th>
                    <th>入库时间</th>
                    <th>库存数量</th>
                </tr>
            </thead>

            <tbody id="infoBody">

            </tbody>
        </table>
    </div>
</div>
</body>
</html>