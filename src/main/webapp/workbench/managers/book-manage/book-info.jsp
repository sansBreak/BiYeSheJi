<%@ page import="per.liu.domain.*" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>老师 教材管理——书籍信息查询(学校仓库内)</title>

    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/lib/Hui-iconfont/1.0.8/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <%--引入时间控件--%>
    <link href="workbench/plugins/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>
    <![endif]-->

    <!-- 载入bootstrap的css -->
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
    <script src="js/jquery-3.4.1.js"></script>
    <!-- 包括所有已编译的插件 -->
    <script src="bootstrap/js/bootstrap.js"></script>
    <!--引入toastr插件-->
    <link rel="stylesheet" type="text/css" href="workbench/plugins/toastr/toastr.css"/>
    <script src="workbench/plugins/toastr/toastr.js"></script>
    <!--引入自定义的css文件-->
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/style.css"/>
    <%--引入时间插件--%>
    <script type="text/javascript"
            src="workbench/plugins/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="workbench/plugins/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <script>
        $(function () {
            //页面加载完成后，自动运行查询函数
            queryAllBookInfo();

            //编辑模态窗口内，保存修改后的图书信息
            $("#saveBtn").click(function () {

                $.ajax({
                    url: "workbench/book/updateBookById.do",
                    data: {
                        "id": $.trim($("#book_id").val()),
                        "bId": $.trim($("#bId").val()),
                        "name": $.trim($("#name").val()),
                        "ISBN": $.trim($("#isbn").val()),
                        "author": $.trim($("#author").val()),
                        "price": $.trim($("#price").val()),
                        "pub_time": $.trim($("#pub_time").val()),
                        "storage_time": $.trim($("#storage_time").val()),
                        "publisher": $.trim($("#publisher").val()),
                        "amount": $.trim($("#amount").val())
                    },
                    type: "get",
                    dataType: "json",
                    success: function (data) {
                        //使用toastr插件弹出成功弹窗
                        if (data) {
                            toastr.success("修改成功成功！");
                            //之后刷新图书列表，更新内容
                            queryAllBookInfo();
                        } else {
                            toastr.error("修改失败！")
                        }
                    }
                });

                /*
                * 在申请图书模态窗口内点击保存按钮，发起ajax请求，返回成功或失败消息
                * */

                //关闭前处理窗口内内容

                document.getElementById("editBookForm").reset();
                $("#editModal").modal("hide");
            });


            //-------------------------------------
            //为全选的复选框绑定事件
            $("#qx").click(function () {
                //当qx被点击时，name为xz的input标签全部被选中
                $("input[name=xz]").prop("checked", this.checked);
            });
            //若已经勾选的对象的数量与全部对象的数量相等，则全选框自动变为勾选；不相等则自动取消勾选
            $("#infoBody").on("click", $("input[name=xz]"), function () {
                $("#qx").prop("checked", $("input[name=xz]").length == $("input[name=xz]:checked").length);
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

            //该函数用于查询仓库内所有图书信息
            function queryAllBookInfo() {
                //发起ajax请求，获取图书信息
                $.ajax({
                    url: "workbench/book/query-AllBookInfo.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    data: {},
                    type: "post",
                    dataType: "json",
                    //返回结果是个list集合
                    success: function (data) {
                        var html = "";
                        $.each(data, function (i, n) {

                            html += "<tr class='text-c'>";
                            html += "<td>" + n.id + "</td>";
                            html += "<td>" + n.bId + "</td>";
                            html += "<td>" + n.name + "</td>";
                            html += "<td>" + n.isbn + "</td>";
                            html += "<td>" + n.author + "</td>";
                            html += "<td>" + n.price + "</td>";
                            html += "<td>" + n.publisher + "</td>";
                            html += "<td>" + n.pub_time + "</td>";
                            html += "<td>" + n.storage_time + "</td>";
                            html += "<td>" + n.amount + "</td>";
                            html += "<td><a ONCLICK='edit(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-pencil'></span>编辑</a></td>";//状态
                            html += "</tr>";
                        });
                        $("#infoBody").html(html);
                    }
                });
            }
        });
    </script>
</head>
<body>

<script>
    //点击编辑按钮，得到当前选中图书的id，然后通过ajax，查询出其他信息
    function edit(id) {
        //id通过函数传入
        $("#editModal").modal("show");
        //放入图书id
        $("#book_id").val(id);
        //根据id查询图书信息，并充填到编辑窗口内
        $.ajax({
            url: "workbench/book/query-BookInfo-ById.do",
            //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
            data: {
                "id": id
            },
            type: "post",
            dataType: "json",
            success: function (data) {
                $("#bId").val(data.bId);
                $("#name").val(data.name);
                $("#isbn").val(data.isbn);
                $("#author").val(data.author);
                $("#price").val(data.price);
                $("#pub_time").val(data.pub_time);
                $("#storage_time").val(data.storage_time);
                $("#publisher").val(data.publisher);
                $("#amount").val(data.amount);
            }

        });


    }
</script>

<div>
    <h2 style="text-align: center;">
        管理员 教材管理——图书列表
    </h2>
</div>

<div class="page-container">
    <!--表格正文-->
    <div class="mt-5">
        <table class="table  table-bordered table-hover table-striped ">
            <thead>
            <tr class="text-c bc-blue">
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
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="infoBody">

            </tbody>
        </table>
    </div>

</div>


<div class="modal fade" id="editModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">编辑图书信息</h4>
            </div>

            <div class="modal-body">
                <form id="editBookForm" class="form-horizontal" role="form">
                    <div class="form-group" style="width: 50%">
                        <label for="book_id" class="col-sm-4 control-label">Id</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="book_id" value="Java从入门到精通" readonly>
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="bId" class="col-sm-4 control-label">书籍编号</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="bId">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="name" class="col-sm-4 control-label">图书名称</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="name">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="isbn" class="col-sm-4 control-label">ISBN号</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="isbn">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="author" class="col-sm-4 control-label">作者</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="author">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="price" class="col-sm-4 control-label">单价</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="price">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="pub_time" class="col-sm-4 control-label">出版时间</label>
                        <div class="col-sm-8">
                            <i></i>
                            <span class="glyphicon glyphicon-calendar form-control-feedback"></span>
                            <input type="text" class="form-control time" id="pub_time">

                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="storage_time" class="col-sm-4 control-label">入库时间</label>
                        <div class="col-sm-8">
                            <i></i>
                            <span class="glyphicon glyphicon-calendar form-control-feedback"></span>
                            <input type="text" class="form-control time" id="storage_time">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="publisher" class="col-sm-4 control-label">出版社</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="publisher">
                        </div>
                    </div>
                    <div class="form-group" style="width: 50%">
                        <label for="amount" class="col-sm-4 control-label">库存数量</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" id="amount">
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
</body>
</html>