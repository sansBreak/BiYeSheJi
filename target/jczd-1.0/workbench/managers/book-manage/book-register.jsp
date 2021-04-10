<%@ page import="per.liu.domain.*" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <base href="<%=basePath%>">
    <%--
        <link rel="stylesheet" type="text/css" href="workbench/static/h-ui/css/H-ui.min.css"/>
    --%>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/lib/Hui-iconfont/1.0.8/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/skin/default/skin.css" id="skin"/>

    <%--引入时间控件--%>
    <link href="workbench/plugins/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet"/>
    <![endif]-->

    <!-- 载入bootstrap的css -->
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <!-- jQuery (Bootstrap 的 JavaScript 插件需要引入 jQuery) -->
    <script src="js/jquery-3.4.1.js"></script>
    <!-- 包括所有已编译的插件 -->
    <script src="bootstrap/js/bootstrap.js"></script>
    <!--引入自定义的css文件-->
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/style.css"/>
    <%--引入时间插件--%>
    <script type="text/javascript" src="workbench/plugins/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="workbench/plugins/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <!--引入toastr插件-->
    <link rel="stylesheet" type="text/css" href="workbench/plugins/toastr/toastr.css"/>
    <script src="workbench/plugins/toastr/toastr.js"></script>
    <meta charset="UTF-8">
    <title>教材入库</title>

    <script>
        $(function () {

            $("#saveBtn").click(function () {
                //判断输入框内容不为空
                var name = $.trim($("#bookName").val());
                var ISBN = $.trim($("#ISBN").val());
                var author = $.trim($("#author").val());
                var price = $.trim($("#price").val());
                var publisher =   $.trim($("#publisher").val());
                var pub_time = $.trim($("#pub_time").val());
                var amount = $.trim($("#amount").val());

                if(name == "" || ISBN == "" || author == "" || price == "" || publisher == "" ||
                    pub_time == "" || amount == ""){

                    toastr.warning("请输入完整信息");
                    return false;
                }

                $.ajax({
                    url:"workbench/book/bookAdd.do",
                    data:{
                        "name":name,
                        "ISBN":ISBN,
                        "author":author,
                        "price":price,
                        "publisher":publisher,
                        "pub_time":pub_time,
                        "amount":amount
                    },
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        //使用toastr插件弹出成功弹窗
                        if (data) {
                            toastr.success("入库成功！");
                            document.getElementById("addForm").reset();
                        } else {
                            toastr.error("入库失败！")
                        }
                    }
                });


            });


            //加入时间控件  使用的是class选择器
            $(".time").datetimepicker({
                minView: "month",
                language: 'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true,
                pickerPosition: "top-left",
            });



            $("#amount").keyup(function(e){

                var inputNumber = $(e.currentTarget).val();
                if (inputNumber.length == 1) {
                    inputNumber = inputNumber.replace(/[^1-9]/g, '');
                    $("#inputNumberVal").val(inputNumber);
                } else {
                    inputNumber = inputNumber.replace(/\D/g, '');
                    $("#inputNumberVal").val(inputNumber);
                }

            })
        })
    </script>

    <style>
        .toast-center-center {
            top: 20%;
            left: 80%;
            margin-top: -30px;
            margin-left: -150px;
        }
    </style>
</head>

<body>
<div>
    <h2 style="text-align: center;">教材入库</h2>
</div>


</body>
<div class="page-container-50">
    <!--一个表单-->
    <!-- 表单中的栅格系统不用row  而是用form-horizontal：水平排列的表单 加到form元素中   -->
    <div style="padding-top: 10px">
        <form class="form-horizontal" id="addForm">
            <div class="form-group">
                <label class="col-md-4 control-label" for="bookName">教材名称 <sup>*</sup></label>
                <div class="col-md-4">
                    <input type="text" class="form-control" id="bookName" placeholder="请输入教材名称"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-4 control-label" for="ISBN">ISBN号 <sup>*</sup></label>
                <div class="col-md-4">
                    <input type="text" class="form-control" id="ISBN" placeholder="请输入ISBN号"/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-md-4 control-label" for="author">作者 <sup>*</sup></label>
                <div class="col-md-4">
                    <input type="text" class="form-control" id="author" placeholder="请输入作者"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-4 control-label" for="price">教材单价 <sup>*</sup></label>
                <div class="col-md-4">
                    <input type="text" class="form-control" id="price" placeholder="请输入教材单价"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-4 control-label" for="publisher">出版社 <sup>*</sup></label>
                <div class="col-md-4">
                    <input type="text" class="form-control" id="publisher" placeholder="请输入出版社名"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-4 control-label" for="pub_time">出版时间 <sup>*</sup></label>
                <div class="col-md-4">
                    <i></i>
                    <span class="glyphicon glyphicon-calendar form-control-feedback"></span>
                    <input type="text" class="form-control time" id="pub_time" placeholder="请输入出版时间"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-4 control-label" for="amount">入库数量 <sup>*</sup></label>
                <div class="col-md-4">
                    <input type="text" class="form-control" onkeyup="value=value.replace(/^(0+)|[^\d]+/g,'')" id="amount" placeholder="请输入入库数量"/>
                </div>
            </div>

            <div class="col-md-2 col-md-offset-5">
                <input type="button" id="saveBtn" class="btn btn-primary" value="提交">
            </div>
        </form>
    </div>
</div>
</html>