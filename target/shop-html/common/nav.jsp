<%--
  Created by IntelliJ IDEA.
  User: gy
  Date: 2019/10/18
  Time: 9:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="/script.jsp"></script>
</head>
<body>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">飞狐教育</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav" id="item-ul">

            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#" onclick="loginOut()"><span class="glyphicon glyphicon-off"></span>退出</a></li>
            </ul>
        </div><!-- /.navbar-collapse -->

    </div><!-- /.container-fluid -->
</nav>
</body>
<script>
    $(function () {
        queryUserList();
    })

    var imgUrl="http://192.168.147.128:80/";
    $.ajaxSetup({

        complete:function(data,TS){
        var time =     data.getResponseHeader("ajaxTime");
        if(time=="timeOut"){
            window.location.href="/login.jsp"
        }
    //对返回的数据data做判断，
    //session过期的话，就location到一个页面
        }

    });
    function queryUserList(){
        $.post({
            url:"/user/queryUserList.do",
            dataType:"json",
           success:function (data) {
                //alert(JSON.stringify(data))
                     var url="";
                   $(data).each(function(){
                           url += "<li id=item" + this.id + "\><a href=" + this.menuUrl + "#" + this.id + ">" + this.menuName + "</a></li>";
                   });
                   $("#item-ul").html(url)
                  },
            error:function () {
                alert("导航条查询失败")
            }
        })
    }


    $(function () {
        //获取请求路径#的值
       var hash =  window.location.hash
       if(hash.length>0){
           //清除所有的样式
           $("#item-ul >li").removeClass("active");
           //去除#
         var id=  hash.substring(1);
         //给指定的标签加样式
           $("#item"+id).addClass("active");
       }

    })

    function loginOut() {
        location.href="/user/loginOut.do";
    }
    
</script>
</html>
