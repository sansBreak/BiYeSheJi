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
    <title>学生 信息</title>

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
            query_AllStudent();

            //打开添加学生窗口
            $("#addStu").click(function () {
                //发起ajax  取得所有班级名,并填充数据
                $.ajax({
                    url: "user/query-Class.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    type: "get",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (i, n) {
                            var html = "";
                            $.each(data, function (i, n) {
                                html += "<option value='" + n.id + "'> " + n.name + "</option>";
                            });
                            $("#classe").html(html);
                        })
                    }
                });

                //打开 模态窗口
                $("#addStuModal").modal("show");

            });
            //保存学生信息
            $("#saveBtn").click(function () {

                var loginAct = $.trim($("#loginAct").val());
                var name = $.trim($("#name").val());
                var email = $.trim($("#email").val());
                var grade = $.trim($("#grade").val());
                var major = $.trim($("#major").val());
                var department = $.trim($("#department").val());
                var classId = $.trim($("#classe").val());

                $.ajax({
                    url:"user/addStu.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    data:{
                        "loginAct":loginAct,
                        "name":name,
                        "email":email,
                        "grade":grade,
                        "major":major,
                        "department":department,
                        "classId":classId,
                    },
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        if (data){
                            query_AllStudent();
                            toastr.success("添加成功！");
                            document.getElementById("addStuForm").reset();
                        }else {
                            toastr.error("添加失败！")
                        }
                        $("#addStuModal").modal("hide");
                    }
                });

            });

            //修改学生信息
            $("#saveEditBtn").click(function () {
                var s_id = $.trim($("#s_id").val());
                var s_loginAct = $.trim($("#s_loginAct").val());
                var s_name = $.trim($("#s_name").val());
                var s_email = $.trim($("#s_email").val());
                var s_grade = $.trim($("#s_grade").val());
                var s_classe = $.trim($("#s_classe").val());
                var s_major = $.trim($("#s_major").val());
                var s_department = $.trim($("#s_department").val());

                if (s_id == "" || s_loginAct == "" || s_name == "" || s_email == "" ||
                    s_grade == "" || s_classe == "" || s_major == "" || s_department == "" ){
                    toastr.warning("请输入完整信息！");
                    return false;
                }

                $.ajax({
                    url: "user/editStu.do",
                    data: {
                        "id":s_id,
                        "loginAct":s_loginAct,
                        "name":s_name,
                        "email":s_email,
                        "grade":s_grade,
                        "classId":s_classe,
                        "major":s_major,
                        "department":s_department
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

                document.getElementById("editBookForm").reset();
                $("#editModal").modal("hide");
            })

            //加载所有学生信息
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
                            html+="<td>"+n.major+"</td>";
                            html+="<td>"+n.department+"</td>";
                            html+="<td>"+n.className+"</td>";
                            html+="<td>"+n.teacherName+"</td>";
                            html += "<td><a ONCLICK='edit(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-pencil'></span>编辑</a> &nbsp;&nbsp;";//状态
                            html += "<a ONCLICK='deleteStu(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-remove'></span>删除</a></td>";//状态

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

<script>
    //打开编辑学生信息的窗口
    function edit(id){
        $("#editModal").modal("show");
        //放入学生id
        $("#s_id").val(id);

        //发起ajax  取得所有班级名,并填充数据
        $.ajax({
            url: "user/query-Class.do",
            //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
            type: "get",
            dataType: "json",
            success: function (data) {
                $.each(data, function (i, n) {
                    var html = "";
                    $.each(data, function (i, n) {
                        html += "<option value='" + n.id + "'> " + n.name + "</option>";
                    });
                    $("#s_classe").html(html);
                })
            }
        });
        //根据id查询学生信息，并充填到编辑窗口内
        $.ajax({
            url: "user/queryStuById.do",
            //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
            data: {
                "id": id,
            },
            type: "post",
            dataType: "json",
            success: function (data) {
                $("#s_loginAct").val(data.loginAct);
                $("#s_loginAct").val(data.loginAct);
                $("#s_name").val(data.name);
                $("#s_email").val(data.email);
                $("#s_grade").val(data.grade);
                $("#s_classe").val(data.classe);
                $("#s_major").val(data.major);
                $("#s_department").val(data.department);

            }
        });
    }

    //删除学生
    function deleteStu(id){
        /*删除前，先弹出警告框，进行二次确认*/
        $("#deleteModal").modal("show");
        //点击确认键后
        $("#deleteHaulBtn").click(function () {
            $.ajax({
                url:"user/deleteStuById.do",
                //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                data:{
                    "id":id,
                },
                type:"get",
                dataType:"json",
                success:function (data) {
                    if (data){
                        toastr.success("删除成功！");
                        query_AllStudent();
                    }else {
                        toastr.success("删除失败！");
                        query_AllStudent();
                    }
                    $("#deleteModal").modal("hide");

                }
            });

        });
    }

    //加载所有学生信息
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
                    html+="<td>"+n.major+"</td>";
                    html+="<td>"+n.department+"</td>";
                    html+="<td>"+n.className+"</td>";
                    html+="<td>"+n.teacherName+"</td>";
                    html += "<td><a ONCLICK='edit(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-pencil'></span>编辑</a>&nbsp;&nbsp;";//状态
                    html += "<a ONCLICK='deleteStu(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-remove'></span>删除</a></td>";//状态

                    html+="</tr>";

                });
                $("#showStu-body").html(html);

            }

        });

    }
</script>



<div >
    <h2 style="text-align: center;">学生 信息</h2>
</div>

<div class="page-container">
    <div style="background-color: #f7f7f6">
        <button type="button" id="addStu" class="btn btn-default btn-primary " aria-label="Left Align">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"> 创建学生</span>
        </button>
    </div>
    <!--表格正文-->
    <div class="mt-5">
        <table class="table  table-bordered table-hover table-striped ">
            <caption>学生 信息</caption>
            <thead>
            <tr class="text-c bc-blue">
                <th>ID</th>
                <th>学号</th>
                <th>姓名</th>
                <th>邮箱</th>
                <th>年级</th>
                <th>专业</th>
                <th>院系</th>
                <th>班级</th>
                <th>负责老师</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="showStu-body">

            </tbody>
        </table>
    </div>
</div>

<!-- 添加学生信息 -->
<div class="modal fade" id="addStuModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">学生添加</h4>
            </div>

            <div class="modal-body">
                <form id="addStuForm" class="form-horizontal" role="form">
                    <div class="form-group" style="width: 50%">
                        <label for="loginAct" class="col-sm-4 control-label">学号</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="loginAct" >
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="name" class="col-sm-4 control-label">姓名</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="name">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="email" class="col-sm-4 control-label">邮箱</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="email">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="grade" class="col-sm-4 control-label">年级</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="grade">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="major" class="col-sm-4 control-label">专业</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="major">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="department" class="col-sm-4 control-label">院系</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="department">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="classe" class="col-sm-4 control-label">班级</label>
                        <div class="col-sm-8">
                            <select class="form-control" id="classe">


                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--编辑学生信息--%>
<div class="modal fade" id="editModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel12">编辑学生信息</h4>
            </div>

            <div class="modal-body">
                <form id="editBookForm" class="form-horizontal" role="form">
                    <div class="form-group" style="width: 50%">
                        <label for="s_id" class="col-sm-4 control-label">Id</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="s_id" value="Java从入门到精通" readonly>
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="loginAct" class="col-sm-4 control-label">学生编号</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="s_loginAct">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="s_name" class="col-sm-4 control-label">姓名</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control time" id="s_name">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="s_email" class="col-sm-4 control-label">邮箱</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control time" id="s_email">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="s_grade" class="col-sm-4 control-label">年级</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="s_grade">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="classe" class="col-sm-4 control-label">班级</label>
                        <div class="col-sm-8">
                            <select class="form-control" id="s_classe">


                            </select>
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="s_major" class="col-sm-4 control-label">专业</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="s_major">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="s_department" class="col-sm-4 control-label">院系</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="s_department">
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