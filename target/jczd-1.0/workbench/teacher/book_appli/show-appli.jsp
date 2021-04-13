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
    <!--引入toastr插件-->
    <link rel="stylesheet" type="text/css" href="workbench/plugins/toastr/toastr.css"/>
    <script src="workbench/plugins/toastr/toastr.js"></script>


    <script>
        $(function () {

            query_AllApplication();

            //加载全部申请
            function query_AllApplication(){
                $.ajax({
                    url:"workbench/application/query-AllApplication-ByTch.do",
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
                                html += "<td STYLE='color: #5bc0de'>" + n.status + "</td>";//状态
                                html += "<td><a ONCLICK='delete_no(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-remove'></span>撤销</a></td>";//状态

                            }else if ("审批未通过" == n.status){
                                html += "<td STYLE='color: #d9534f'>" + n.status + "</td>";//状态
                                html += "<td><a ONCLICK='delete(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-remove'></span>撤销</a></td>";//状态

                            }else if ("审批通过" == n.status){
                                html += "<td STYLE='color: #5cb85c'>" + n.status + "</td>";//状态
                            }
                            html+="</tr>";

                        });
                        $("#shpwAppli-body").html(html);

                    }
                });
            }


        })
    </script>

</head>
<body>

<script>


    //删除未审批的申请
    function delete_no(id){
        /*删除前，先弹出警告框，进行二次确认*/
        $("#deleteModal").modal("show");
        //点击确认键后
        $("#deleteHaulBtn").click(function () {

           //1、应该先进行审批为不过
            $.ajax({
                url: "workbench/application/rejectionAppli.do",
                //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                data: {
                    "id": id,
                },
                type: "post",
                dataType: "json",
                success: function (data) {
                    //2、再删除

                    $.ajax({
                        url:"workbench/application/delete-Application.do",
                        //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                        data:{
                            "id":id,
                        },
                        type:"get",
                        dataType:"json",
                        success:function (data) {
                            if (data){
                                toastr.success("删除成功！");
                                query_AllApplication();
                            }else {
                                toastr.success("删除失败！");
                                query_AllApplication();
                            }
                            $("#deleteModal").modal("hide");

                        }
                    });
                }
            });


        });
    }

    //删除已审批的申请
    function delete(id){
        /*删除前，先弹出警告框，进行二次确认*/
        $("#deleteModal").modal("show");
        //点击确认键后
        $("#deleteHaulBtn").click(function () {

            //直接进行删除
            $.ajax({
                url:"workbench/application/delete-Application.do",
                //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                data:{
                    "id":id,
                },
                type:"get",
                dataType:"json",
                success:function (data) {
                    if (data){
                        toastr.success("删除成功！");
                        query_AllApplication();
                    }else {
                        toastr.success("删除失败！");
                        query_AllApplication();
                    }
                    $("#deleteModal").modal("hide");

                }
            });


        });
    }

    function query_AllApplication(){
        $.ajax({
            url:"workbench/application/query-AllApplication-ByTch.do",
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
                        html += "<td STYLE='color: #5bc0de'>" + n.status + "</td>";//状态
                        html += "<td><a ONCLICK='delete_no(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-remove'></span>撤销</a></td>";//状态

                    }else if ("审批未通过" == n.status){
                        html += "<td STYLE='color: #d9534f'>" + n.status + "</td>";//状态

                    }else if ("审批通过" == n.status){
                        html += "<td STYLE='color: #5cb85c'>" + n.status + "</td>";//状态
                    }
                    html+="</tr>";

                });
                $("#shpwAppli-body").html(html);

            }
        });
    }
</script>


<div>
    <h2 style="text-align: center;">老师 查看申请订单</h2>
</div>
<%--正文--%>
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
                <th data-formatter="displaycolor" data-sortable="true">状态</th>
                <th data-formatter="displaycolor" data-sortable="true">操作</th>
            </tr>
            </thead>

            <tbody id="shpwAppli-body">


            </tbody>
        </table>
    </div>
</div>

<!--信息删除确认 模态窗口-->
<div class="modal fade" id="deleteModal">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
                <h3 class="modal-title">提示</h3>
            </div>
            <div class="modal-body">
                <!-- 隐藏需要删除的id -->
                <input type="hidden" id="deleteHaulId" />
                <p style="font-size: 15px">该学生信息删除后不可恢复，请确认是否要删除？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="deleteHaulBtn">确认</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>