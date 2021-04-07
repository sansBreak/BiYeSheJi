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

    <script>
        $(function () {
            //页面加载完成后，自动运行查询函数
            queryAllBookInfo();


            //为申请图书按钮绑定事件，执行打开 模态窗口操作
            $("#applyBookBtn").click(function () {
                //用户必须勾选一项图书才能打开模态窗口
                if ($("input[name=xz]:checked").length == 0) {
                    alert("你还未勾选！")
                    return false;
                } else if ($("input[name=xz]:checked").length > 1) {
                    alert("只能同时勾选一项图书！")
                    return false;
                }

                /*取得session中的老师姓名,放入申请人框内*/
                <%Teacher teacher = (Teacher)request.getSession().getAttribute("tch");%>
                var tchName = '<%=teacher.getName() %>';
                $("#apply-teacher").val(tchName);

                //取得勾选的图书id
                var $xz = $("input[name=xz]:checked");
                var id = $xz.val();
                //发起ajax  根据图书id，从数据库取得选择得出图书信息,并将数据填充进模态窗口
                $.ajax({
                    url: "workbench/book/query-BookInfo-ById.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    data: {
                        "id": id
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        $("#ab-name").val(data.name);
                        $("#ab-author").val(data.author);
                        $("#ab-publisher").val(data.author);
                        $("#ab-amount").val(data.amount);
                    }

                });

                //发起ajax  要求返回当前用户所负责的班级和老师姓名,并将数据填充进模态窗口
                $.ajax({
                    url: "workbench/book/query-Class-ByTch.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    type: "get",
                    dataType: "json",
                    success: function (data) {
                        $.each(data, function (i, n) {
                            var html = "";
                            $.each(data, function (i, n) {
                                html += "<option value='" + n.id + "'> " + n.name + "</option>";
                            });
                            $("#apply-class").html(html);
                        })
                    }
                });
                //打开 模态窗口
                $("#applyBookModal").modal("show");
            });

            //为保存按钮绑定事件，执行添加操作 点击后，将窗口内填的数据发给后端处理，并清除窗口内输入框内容
            $("#saveBtn").click(function () {

                //取得勾选的图书id
                var $xz = $("input[name=xz]:checked");
                var abId = $xz.val();

                //检查申请数量是否超过库存数量
                var appli_amount = $.trim($("#apply-amount").val());
                var kuchun_amount = $.trim($("#ab-amount").val());
                if (appli_amount > kuchun_amount) {
                    toastr.warning("申请数量超过库存数量了！");
                    return false;
                }


                alert(appli_amount);
                alert(kuchun_amount);
                /*
                * 在申请图书模态窗口内点击保存按钮，发起ajax请求，返回成功或失败消息
                * */
                $.ajax({
                    url: "workbench/application/addAppli.do",
                    data: {
                        "book_id": abId,        //申请教材的id
                        "appli_amount": appli_amount,      //  教材申请数量
                        "class_id": $.trim($("#apply-class").val()),      //  申请班级
                        "kuchun_amount": kuchun_amount,      //  库存数量
                    },
                    type: "get",
                    dataType: "json",
                    success: function (data) {
                        //使用toastr插件弹出成功弹窗
                        if (data) {
                            toastr.success("申请已发送成功！");
                            //之后刷新图书列表，更新内容
                            queryAllBookInfo();
                        } else {
                            toastr.error("申请发送失败！ (╯°Д°)╯︵┻━┻")
                        }

                    }
                });

                //关闭前处理窗口内内容
                $("#apply-amount").val("");
                $("#applyBookModal").modal("hide");


            });

            /*-----------------------------------------------------------*/
            //为全选的复选框绑定事件
            $("#qx").click(function () {
                //当qx被点击时，name为xz的input标签全部被选中
                $("input[name=xz]").prop("checked", this.checked);
            });
            //若已经勾选的对象的数量与全部对象的数量相等，则全选框自动变为勾选；不相等则自动取消勾选
            $("#infoBody").on("click", $("input[name=xz]"), function () {
                $("#qx").prop("checked", $("input[name=xz]").length == $("input[name=xz]:checked").length);
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
                            //html+="<option value='"+n.id+"'>"+n.name+"</option>"

                            html += "<tr class='text-c'>";
                            html += '<td><input type="checkbox" name="xz" value="' + n.id + '"/></td>';
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
<div>
    <h2 style="text-align: center;">老师 订书订单管理——图书列表</h2>
</div>

<div class="page-container">

    <div class="btn-group" style="position: relative;bottom: 5px ;top: 18%;">
        <button type="button" class="btn btn-primary" id="applyBookBtn"><span class="glyphicon glyphicon-plus"></span>
            申请图书
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

    <!-- 创建市场活动的模态窗口 -->
    <div class="modal fade" id="applyBookModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 85%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel1">申请图书</h4>
                </div>

                <div class="modal-body">
                    <form id="applyBookForm" class="form-horizontal" role="form">

                        <div class="form-group" style="width: 50%">
                            <label for="ab-name" class="col-sm-4 control-label">教材名称</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="ab-name" value="Java从入门到精通" readonly>
                            </div>
                        </div>
                        <div class="form-group" style="width: 50%">
                            <label for="ab-author" class="col-sm-4 control-label">作者</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="ab-author" value="明日科技" readonly>
                            </div>
                        </div>
                        <div class="form-group" style="width: 50%">
                            <label for="ab-publisher" class="col-sm-4 control-label">出版社</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="ab-publisher" value="清华大学出版社" readonly>
                            </div>
                        </div>
                        <div class="form-group" style="width: 50%">
                            <label for="ab-amount" class="col-sm-4 control-label">库存数量</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="ab-amount" readonly>
                            </div>
                        </div>

                        <hr style="border-top:1px dashed #987cb9;" width="100%" color="#987cb9" size=1>

                        <div class="form-group" style="width: 60%">
                            <label for="apply-class" class="col-sm-4 control-label">申请班级</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="apply-class">


                                </select>
                            </div>
                        </div>
                        <br>
                        <div class="form-group" style="width: 60%">
                            <label for="apply-amount" class="col-sm-4 control-label">申请数量</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="apply-amount" placeholder="请输入你的申请数量">
                            </div>
                        </div>
                        <br>
                        <div class="form-group" style="width: 60%">
                            <label for="apply-teacher" class="col-sm-4 control-label">申请人</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="apply-teacher" value="宙斯" readonly>
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
</div>
</body>
</html>