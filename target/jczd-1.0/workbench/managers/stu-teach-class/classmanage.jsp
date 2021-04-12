<%@ page import="per.liu.domain.*" %>
<%
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/lib/Hui-iconfont/1.0.8/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <![endif]-->

    <meta charset="UTF-8">
    <title>班级 信息</title>

    <!-- 载入bootstrap的css -->
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
    <script src="js/jquery-3.4.1.js"></script>
    <!-- 包括所有已编译的插件 -->
    <script src="bootstrap/js/bootstrap.js"></script>
    <!--引入自定义的css文件-->
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/style.css"/>
    <!--引入toastr插件-->
    <link rel="stylesheet" type="text/css" href="workbench/plugins/toastr/toastr.css"/>
    <script src="workbench/plugins/toastr/toastr.js"></script>

    <script>
        $(function () {
            //页面加载后加载列表内容
            query_AllClass();

            //打开添加班级窗口
            $("#addClassBtn").click(function () {

                //发起ajax  取得所有班级名,并填充数据
                $.ajax({
                    url: "user/queryAllTch.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    type: "get",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (i, n) {
                            var html = "";
                            $.each(data, function (i, n) {
                                html += "<option value='" + n.id + "'> " + n.name + "</option>";
                            });
                            $("#add_tchName").html(html);
                        })
                    }
                });

                //打开 模态窗口
                $("#addModal").modal("show");
            });


            //保存学生信息
            $("#add_saveBtn").click(function () {

                var teacherId = $.trim($("#add_tchName").val());
                var name = $.trim($("#add_name").val());


                $.ajax({
                    url:"user/addClass.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    data:{
                        "teacherId":teacherId,
                        "name":name,
                    },
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        if (data){
                            query_AllClass();
                            toastr.success("添加成功！");
                            document.getElementById("addClassForm").reset();
                        }else {
                            toastr.error("添加失败！")
                        }
                        $("#addModal").modal("hide");

                    }
                });

            });


            //修改班级信息
            $("#saveEditBtn").click(function () {
                var c_id = $.trim($("#c_id").val());
                var c_name = $.trim($("#c_name").val());
                var c_tchName = $.trim($("#c_tchName").val());


                if (c_id == "" || c_name == "" || c_tchName == ""){
                    toastr.warning("请输入完整信息！");
                    return false;
                }

                $.ajax({
                    url: "user/editClass.do",
                    data: {
                        "id":c_id,
                        "name":c_name,
                        "teacherId":c_tchName,
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        //使用toastr插件弹出成功弹窗
                        if (data) {
                            toastr.success("修改成功成功！");
                            //之后刷新图书列表，更新内容
                            query_AllClass();
                        } else {
                            toastr.error("修改失败！")
                        }
                    }
                });
                //关闭前处理窗口内内容
                document.getElementById("editClassForm").reset();
                $("#editModal").modal("hide");
            });

            //加载班级信息的函数
            function query_AllClass() {
                $.ajax({
                    url:"user/query_AllClass.do",
                    data:{
                    },
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        var html="";
                        $.each(data, function (i, n) {

                            html+="<tr class='text-c'>";
                            html+="<td>"+n.id+"</td>";
                            html+="<td>"+n.name+"</td>";
                            html+="<td>"+n.tchName+"</td>";
                            html += "<td><a ONCLICK='edit(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-pencil'></span>编辑</a> &nbsp;&nbsp;";//状态
                            html += "<a ONCLICK='deleteClass(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-remove'></span>删除</a></td>";//状态
                            html+="</tr>";

                        });
                        $("#class-body").html(html);

                    }

                });

            }

        })



    </script>

</head>
<body >

<script>

    //打开编辑班级信息的窗口
    function edit(id){
        $("#editModal").modal("show");
        //放入班级id
        $("#c_id").val(id);

        //发起ajax  取得所有老师信息,并填充数据
       $.ajax({
            url: "user/queryAllTch.do",
            type: "get",
            dataType: "json",
            success: function (data) {
                $.each(data, function (i, n) {
                    var html = "";
                    $.each(data, function (i, n) {
                        html += "<option value='" + n.id + "'> " + n.name + "</option>";
                    });
                    $("#c_tchName").html(html);
                })
            }
        });

        //根据id查询班级信息，并充填到编辑窗口内
         $.ajax({
            url: "user/queryClassById.do",
            data: {
                "id": id,
            },
            type: "post",
            dataType: "json",
            success: function (data) {

                $("#c_name").val(data.name);

            }
        });





    }

    //删除班级
    function deleteClass(id){
        /*删除前，先弹出警告框，进行二次确认*/
        $("#deleteModal").modal("show");

        //点击确认键后
        $("#deleteHaulBtn").click(function () {
            $.ajax({
                url:"user/deleteClassById.do",
                //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                data:{
                    "id":id,
                },
                type:"get",
                dataType:"json",
                success:function (data) {
                    if (data){
                        toastr.success("删除成功！");
                        query_AllClass();
                    }else {
                        toastr.success("删除失败！");
                        query_AllClass();
                    }
                    $("#deleteModal").modal("hide");

                }
            });

        });

        //加载班级信息的函数
        function query_AllClass() {
            $.ajax({
                url:"user/query_AllClass.do",
                data:{
                },
                type:"post",
                dataType:"json",
                success:function (data) {
                    var html="";
                    $.each(data, function (i, n) {

                        html+="<tr class='text-c'>";
                        html+="<td>"+n.id+"</td>";
                        html+="<td>"+n.name+"</td>";
                        html+="<td>"+n.tchName+"</td>";
                        html += "<td><a ONCLICK='edit(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-pencil'></span>编辑</a> &nbsp;&nbsp;";//状态
                        html += "<a ONCLICK='deleteClass(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-remove'></span>删除</a></td>";//状态
                        html+="</tr>";

                    });
                    $("#class-body").html(html);

                }

            });

        }
    }
</script>

<div>
    <h2 style="text-align: center;">班级 信息</h2>
</div>

<div class="page-container-200">
    <div style="background-color: #f7f7f6">
        <button type="button" id="addClassBtn" class="btn btn-default btn-primary " aria-label="Left Align">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"> 添加班级</span>
        </button>
    </div>
    <!--表格正文-->
    <div class="mt-5">
        <table class="table  table-bordered table-hover table-striped ">
            <thead>
            <tr class="text-c bc-blue">
                <th>编号</th>
                <th>班级</th>
                <th>负责老师</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="class-body">

            </tbody>
        </table>
    </div>
</div>

<!-- 添加班级信息 -->
<div class="modal fade" id="addModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 70%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">班级添加</h4>
            </div>
            <div class="modal-body" >
                <form id="addClassForm" class="form-horizontal" role="form">
                    <div class="form-group" style="width: 60%">
                        <label for="add_name" class="col-sm-4 control-label">班级</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="add_name">
                        </div>
                    </div>
                    <div class="form-group" style="width: 60%">
                        <label for="add_tchName" class="col-sm-4 control-label">老师</label>
                        <div class="col-sm-8">
                            <select class="form-control" id="add_tchName">


                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="add_saveBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--编辑班级信息--%>
<div class="modal fade" id="editModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel12">编辑班级信息</h4>
            </div>

            <div class="modal-body">
                <form id="editClassForm" class="form-horizontal" role="form">
                    <div class="form-group" style="width: 60%">
                        <label for="c_id" class="col-sm-4 control-label">Id</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="c_id"  readonly>
                        </div>
                    </div>

                    <div class="form-group" style="width: 60%">
                        <label for="c_name" class="col-sm-4 control-label">班级</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control time" id="c_name">
                        </div>
                    </div>
                    <div class="form-group" style="width: 60%">
                        <label for="c_tchName" class="col-sm-4 control-label">负责老师</label>
                        <div class="col-sm-8">
                            <select class="form-control" id="c_tchName">

                            </select>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveEditBtn">保存</button>
            </div>
        </div>
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
                <p style="font-size: 15px">该班级信息删除后不可恢复，请确认是否要删除？</p>
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