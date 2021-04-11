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
    <%--引入时间控件--%>
    <link href="workbench/plugins/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet"/>
    <![endif]-->

    <meta charset="UTF-8">
    <title>查看申请订单</title>

    <!-- 载入bootstrap的css -->
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
    <script src="js/jquery-3.4.1.js"></script>
    <!-- 包括所有已编译的插件 -->
    <script src="bootstrap/js/bootstrap.js"></script>
    <!--引入toastr插件-->
    <link rel="stylesheet" type="text/css" href="workbench/plugins/toastr/toastr.css"/>
    <script src="workbench/plugins/toastr/toastr.js"></script>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/style.css"/>
    <%--引入时间插件--%>
    <script type="text/javascript" src="workbench/plugins/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="workbench/plugins/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <script type="text/javascript">
        $(function () {

            //页面加载后，自动加载所有申请
            query_AllApplication();

            //审批模态窗口中，取得当前订单的id，点击同意申请按钮，发起ajax请求
            $("#agreeBtn").click(function () {

                var id = $.trim($("#noneInput").val());
                var grant_place = $.trim($("#grant_place").val());
                var grant_time = $.trim($("#grant_time").val());

                if (grant_place == "" || grant_time == "" ){
                    toastr.warning("请输入完整信息！");
                    return false;
                }

                $.ajax({
                    url: "workbench/application/agreeAppli.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    data: {
                        "id": id,
                        "grant_place": grant_place,
                        "grant_time": grant_time,
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        if (data) {
                            toastr.success("操作成功！");
                            //更新列表
                            query_AllApplication();
                        }else {
                            toastr.error("操作失败！")
                        }
                    }
                });
                //关闭窗口
                $("#shenPiModal").modal("hide");


            });

            //驳回申请
            $("#rejectionBtn").click(function () {
                var id = $.trim($("#noneInput").val());

                $.ajax({
                    url: "workbench/application/rejectionAppli.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    data: {
                        "id": id,
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        if (data) {
                            toastr.success("操作成功！");
                            //更新列表
                            query_AllApplication();
                        }else {
                            toastr.error("操作失败！")
                        }
                    }
                });
                $("#shenPiModal").modal("hide");
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

            function query_AllApplication() {
                //发起ajax请求，获取所有
                $.ajax({
                    url: "workbench/application/query-AllApplication.do",
                    //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                    data: {},
                    type: "post",
                    dataType: "json",
                    //返回结果是个list集合
                    success: function (data) {
                        var html = "";
                        $.each(data, function (i, n) {

                            html += "<tr class='text-c'>";
                            html += "<td>" + n.id + "</td>";      //订单编号
                            html += "<td>" + n.book_name + "</td>";     //教材名称
                            html += "<td>" + n.book_price + "</td>";    //教材单价
                            html += "<td>" + n.book_publisher + "</td>";    //出版社
                            html += "<td>" + n.tch_name + "</td>";          //申请老师
                            html += "<td>" + n.class_name + "</td>";          //申请班级
                            html += "<td>" + n.appli_amount + "</td>";    //申请数量

                            if ("未审批" == n.status) {
                                html += "<td STYLE='color: #5bc0de'>" + n.status + "</td>";//状态
                                html += "<td><a ONCLICK='shenPi(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-pencil'></span>审批</a></td>";//状态

                            } else if ("审批未通过" == n.status) {
                                html += "<td STYLE='color: #d9534f'>" + n.status + "</td>";//状态
                                html += "<td><a ONCLICK='deleteAppli(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-remove'></span>删除申请</a></td>";//状态

                            } else if ("审批通过" == n.status) {
                                html += "<td STYLE='color: #5cb85c'>" + n.status + "</td>";//状态
                                html += "<td><a ONCLICK='deleteAppli(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-remove'></span>删除申请</a></td>";//状态
                            }
                            html += "</tr>";
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
        //未审批的列，点击审批后即可进行审批 id是申请订单的id
        function shenPi(id) {
            //id通过函数传入
            $("#shenPiModal").modal("show");
            //将id放在隐藏区域，备用
            $("#noneInput").val(id);
        }

        //删除申请
        function deleteAppli(id)    {
            /*删除前，先弹出警告框，进行二次确认*/
            $("#deleteModal").modal("show");
            //点击确认键后
            $("#deleteHaulBtn").click(function () {
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
                            $("#deleteModal").modal("hide");
                        }else {
                            toastr.success("删除失败！");
                            query_AllApplication();
                            $("#deleteModal").modal("hide");
                        }
                    }
                });

            });
        }

        //加载所有申请
        function query_AllApplication() {
            //发起ajax请求，获取所有
            $.ajax({
                url: "workbench/application/query-AllApplication.do",
                //规定要发送到服务器的数据，可以是：string， 数组，多数是 json
                data: {},
                type: "post",
                dataType: "json",
                //返回结果是个list集合
                success: function (data) {
                    var html = "";
                    $.each(data, function (i, n) {

                        html += "<tr class='text-c'>";
                        html += "<td>" + n.id + "</td>";      //订单编号
                        html += "<td>" + n.book_name + "</td>";     //教材名称
                        html += "<td>" + n.book_price + "</td>";    //教材单价
                        html += "<td>" + n.book_publisher + "</td>";    //出版社
                        html += "<td>" + n.tch_name + "</td>";          //申请老师
                        html += "<td>" + n.class_name + "</td>";          //申请班级
                        html += "<td>" + n.appli_amount + "</td>";    //申请数量

                        if ("未审批" == n.status) {
                            html += "<td STYLE='color: #5bc0de'>" + n.status + "</td>";//状态
                            html += "<td><a ONCLICK='shenPi(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-pencil'></span>审批</a></td>";//状态

                        } else if ("审批未通过" == n.status) {
                            html += "<td STYLE='color: #d9534f'>" + n.status + "</td>";//状态
                            html += "<td><a ONCLICK='deleteAppli(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-remove'></span>删除申请</a></td>";//状态

                        } else if ("审批通过" == n.status) {
                            html += "<td STYLE='color: #5cb85c'>" + n.status + "</td>";//状态
                            html += "<td><a ONCLICK='deleteAppli(\"" + n.id + "\")'  href='javascript:void(0);' ><span class='glyphicon glyphicon-remove'></span>删除申请</a></td>";//状态
                        }
                        html += "</tr>";
                    });
                    $("#shpwAppli-body").html(html);
                }
            });

        }
</script>

<%--隐藏区域，用于存放一些数据--%>
<form>
    <input type="hidden" id="noneInput" name="noneInput" value=""/>
</form>

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
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>

            <tbody id="shpwAppli-body">

            </tbody>
        </table>
    </div>
</div>
<%--编辑模态窗口--%>
<div class="modal fade" id="shenPiModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h3 class="modal-title" id="myModalLabel" style="font-weight: bolder">编辑图书信息</h3>
            </div>
            <div class="form-group" style="width: 60%;margin-top: 30px">
                <label for="grant_place" class="col-sm-4 control-label">领书地点 <span style="color: red">*</span></label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="grant_place" placeholder="请输入领书地点">
                </div>
            </div>
            <div class="form-group" style="width: 60%">
                <label for="grant_time" class="col-sm-4 control-label">领书时间 <span style="color: red">*</span></label>
                <div class="col-sm-8">
                    <i></i>
                    <span class="glyphicon glyphicon-calendar form-control-feedback"></span>
                    <input type="text" class="form-control time" id="grant_time" placeholder="请输入领书时间">
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-danger" id="rejectionBtn">驳回</button>
                <button type="button" class="btn btn-primary" id="agreeBtn">同意</button>
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
                <p style="font-size: 15px">该申请删除后不可恢复，请确认是否要删除该条申请？</p>
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