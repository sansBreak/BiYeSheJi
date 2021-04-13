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
    <title>老师 信息</title>

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
            query_AllTeacher();


            //打开添加教师窗口
            $("#addTchBtn").click(function () {

                //打开 模态窗口
                $("#addTchModal").modal("show");

            });
            //保存教师信息
            $("#saveAddBtn").click(function () {

                var loginAct = $.trim($("#loginAct").val());
                var name = $.trim($("#name").val());
                var email = $.trim($("#email").val());
                var department = $.trim($("#department").val());

                if (loginAct == "" || name == "" || email == "" || department == "") {

                    toastr.warning("请输入完整信息");
                    return false;
                }

                $.ajax({
                    url: "user/addTch.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    data: {
                        "loginAct": loginAct,
                        "name": name,
                        "email": email,
                        "department": department,
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        if (data) {
                            query_AllTeacher();
                            toastr.success("添加成功！");
                            document.getElementById("addTchForm").reset();
                        } else {
                            toastr.error("添加失败！")
                        }
                        $("#addTchModal").modal("hide");
                    }
                });

            });
            //修改学生信息
            $("#saveEditBtn").click(function () {
                var t_id = $.trim($("#t_id").val());
                var t_loginAct = $.trim($("#t_loginAct").val());
                var t_name = $.trim($("#t_name").val());
                var t_email = $.trim($("#t_email").val());
                var t_department = $.trim($("#t_department").val());

                if (t_id == "" || t_loginAct == "" || t_name == "" || t_email == "" ||t_department == "") {
                    toastr.warning("请输入完整信息！");
                    return false;
                }

                $.ajax({
                    url: "user/editTch.do",
                    data: {
                        "id": t_id,
                        "loginAct": t_loginAct,
                        "name": t_name,
                        "email": t_email,
                        "department": t_department
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        //使用toastr插件弹出成功弹窗
                        if (data) {
                            toastr.success("修改成功成功！");
                            //之后刷新图书列表，更新内容
                            query_AllStudent();
                        } else {
                            toastr.error("修改失败！")
                        }
                    }
                });
                
                //关闭前处理窗口内内容

                document.getElementById("editTchForm").reset();
                $("#editModal").modal("hide");
            })


            //加载所有学生信息
            function query_AllTeacher() {
                $.ajax({
                    url: "user/queryAllTch.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    data: {},
                    type: "post",
                    dataType: "json",
                    success: function (data) {

                        var html = "";
                        $.each(data, function (i, n) {

                            html += "<tr class='text-c'>";
                            html += "<td>" + n.id + "</td>";
                            html += "<td>" + n.loginAct + "</td>";
                            html += "<td>" + n.name + "</td>";
                            html += "<td>" + n.email + "</td>";
                            html += "<td>" + n.department + "</td>";
                            html += "<td><a ONCLICK='edit(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-pencil'></span>编辑</a> &nbsp;&nbsp;";//状态
                            html += "<a ONCLICK='deleteStu(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-remove'></span>删除</a></td>";//状态

                            html += "</tr>";

                        });
                        $("#showTch-body").html(html);

                    }

                });

            }
        })


    </script>


</head>
<body>
<script>
    //打开编辑学生信息的窗口
    function edit(id) {
        $("#editModal").modal("show");
        //放入教工id
        $("#t_id").val(id);

        //根据id查询学生信息，并充填到编辑窗口内
        $.ajax({
            url: "user/queryTchById.do",
            //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
            data: {
                "id": id,
            },
            type: "post",
            dataType: "json",
            success: function (data) {
                $("#t_loginAct").val(data.loginAct);
                $("#t_name").val(data.name);
                $("#t_email").val(data.email);
                $("#t_department").val(data.department);

            }
        });
    }


</script>


<div>
    <h2 style="text-align: center;">老师 信息</h2>
</div>

<%--正文--%>
<div class="page-container">
    <div style="background-color: #f7f7f6">
        <button type="button" id="addTchBtn" class="btn btn-default btn-primary " aria-label="Left Align">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"> 添加老师</span>
        </button>
    </div>
    <!--表格正文-->
    <div class="mt-5">
        <table class="table  table-bordered table-hover table-striped ">
            <caption>老师</caption>
            <thead>
            <tr class="text-c bc-blue">
                <th>编号</th>
                <th>教工号</th>
                <th>姓名</th>
                <th>邮箱</th>
                <th>院系</th>
                <th>操作</th>
            </tr>
            </thead>

            <tbody id="showTch-body">

            </tbody>
        </table>
    </div>
</div>

<!-- 添加教师信息 -->
<div class="modal fade" id="addTchModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">教师添加</h4>
            </div>

            <div class="modal-body">
                <form id="addTchForm" class="form-horizontal" role="form">
                    <div class="form-group" style="width: 60%">
                        <label for="loginAct" class="col-sm-4 control-label">教工号</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="loginAct">
                        </div>
                    </div>
                    <div class="form-group" style="width: 60%">
                        <label for="name" class="col-sm-4 control-label">姓名</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="name">
                        </div>
                    </div>
                    <div class="form-group" style="width: 60%">
                        <label for="email" class="col-sm-4 control-label">邮箱</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="email">
                        </div>
                    </div>
                    <div class="form-group" style="width: 60%">
                        <label for="department" class="col-sm-4 control-label">院系</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="department">
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveAddBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--编辑教师信息--%>
<div class="modal fade" id="editModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel12">编辑教师信息</h4>
            </div>

            <div class="modal-body">
                <form id="editTchForm" class="form-horizontal" role="form">
                    <div class="form-group" style="width: 60%">
                        <label for="t_id" class="col-sm-4 control-label">Id</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="t_id" readonly>
                        </div>
                    </div>
                    <div class="form-group" style="width: 60%">
                        <label for="t_loginAct" class="col-sm-4 control-label">教工号</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="t_loginAct">
                        </div>
                    </div>
                    <div class="form-group" style="width: 60%">
                        <label for="t_name" class="col-sm-4 control-label">姓名</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control time" id="t_name">
                        </div>
                    </div>
                    <div class="form-group" style="width: 60%">
                        <label for="t_email" class="col-sm-4 control-label">邮箱</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control time" id="t_email">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="t_department" class="col-sm-4 control-label">院系</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="t_department">
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
</body>
</html>