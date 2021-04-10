<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<%@page import="per.liu.domain.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>学生 个人信息</title>

    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/lib/Hui-iconfont/1.0.8/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/style.css">
    <![endif]-->

    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css"/>
    <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
    <link rel="stylesheet" type="text/css" href="workbench/static/h-ui.admin/css/style.css"/>

    <script>
        $(function () {

            //从session中取得当前用户的身份
            var identity="<%=session.getAttribute("identity")%>";


            //根据用户是否，对页面标题进行修改
            if (identity == "stu"){
                $("#h2").html("学生 个人信息");
            }else if (identity == "tch"){
                $("#h2").html("教师 个人信息");
            }else if (identity == "mgr"){
                $("#h2").html("管理员 个人信息");
            }

            //进入页面后，自动发起请求，取得用户信息
             $.ajax({
                  url:"user/personal-info.do",
                  data:{
                  },
                  type:"get",
                  dataType:"json",
                  success:function (data) {
                      var html="";

                      //用户是学生时
                      if (identity == "stu"){
                          html += '<tr class="text-c"> <th style="background-color:#f4fafe" width="30%">学号</th> <td>'+data.loginAct+'</td></tr>';
                          html += '<tr class="text-c"> <th style="background-color:#f4fafe" width="30%">姓名</th> <td>'+data.name+'</td></tr>';
                          html += '<tr class="text-c"> <th style="background-color:#f4fafe" width="30%">年级</th> <td>'+data.grade+'</td></tr>';
                          html += '<tr class="text-c"> <th style="background-color:#f4fafe" width="30%">专业</th> <td>'+data.major+'</td></tr>';
                          html += '<tr class="text-c"> <th style="background-color:#f4fafe" width="30%">院系</th> <td>'+data.department+'</td></tr>';
                          html += '<tr class="text-c"> <th style="background-color:#f4fafe" width="30%">邮箱</th> <td>'+data.email+'</td></tr>';

                          //用户是教师时
                      }else if (identity == "tch"){
                          html += '<tr class="text-c"> <th style="background-color:#f4fafe" width="30%">工号</th> <td>'+data.loginAct+'</td></tr>';
                          html += '<tr class="text-c"> <th style="background-color:#f4fafe" width="30%">姓名</th> <td>'+data.name+'</td></tr>';
                          html += '<tr class="text-c"> <th style="background-color:#f4fafe" width="30%">院系</th> <td>'+data.department+'</td></tr>';
                          html += '<tr class="text-c"> <th style="background-color:#f4fafe" width="30%">邮箱</th> <td>'+data.email+'</td></tr>';

                      }else if (identity == "mgr"){
                          html += '<tr class="text-c"> <th style="background-color:#f4fafe" width="30%">工号</th> <td>'+data.loginAct+'</td></tr>';
                          html += '<tr class="text-c"> <th style="background-color:#f4fafe" width="30%">姓名</th> <td>'+data.name+'</td></tr>';
                          html += '<tr class="text-c"> <th style="background-color:#f4fafe" width="30%">邮箱</th> <td>'+data.email+'</td></tr>';
                      }
                      $("#infoBody").html(html);
                  }
              });
            return false;
        })
    </script>
</head>
<body class="">
<h2 style="text-align: center;" id="h2">个人信息</h2>
<div class="page-container-200">
    <!--表格正文-->
    <div class="mt-5">
        <table class="table  table-bordered table-hover table-bg table-striped">

            <tdead>
                <tr>
                    <th colspan="2" style="font-size: 15px; background-color:#f4fafe ">个人信息</th>
                </tr>
            </tdead>

            <tbody id="infoBody">

            </tbody>
        </table>
    </div>
</div>
</body>
</html>