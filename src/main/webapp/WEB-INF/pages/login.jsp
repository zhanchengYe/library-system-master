<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>图书管理系统</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Access-Control-Allow-Origin" content="*">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery-3.4.1/jquery-3.4.1.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">

    <style>
        html, body {width: 100%;height: 100%;overflow: hidden}
        body {
            background: url("${pageContext.request.contextPath}/images/img.png") no-repeat center; background-size: cover;
        }

        .layui-container {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .admin-login-background {
            width: 420px;
            padding: 40px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .admin-login-background::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #ffffff, #ffffff);
        }

        .logo-title h1 {
            color: #2c3e50;
            font-size: 28px;
            font-weight: 300;
            margin-bottom: 30px;
            text-align: center;
        }

        .login-form {
            background: transparent;
            border: none;
            padding: 0;
            box-shadow: none;
        }

        .layui-form-item {
            margin-bottom: 25px;
            position: relative;
        }

        .layui-input, .layui-input select {
            height: 50px;
            border: 2px solid #e1e8ed;
            border-radius: 10px;
            padding-left: 50px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        .layui-input:focus {
            border-color: #667eea;
            background: #ffffff;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .login-form .layui-form-item label {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #667eea;
            font-size: 18px;
            z-index: 10;
        }

        .layui-btn-fluid {
            height: 50px;
            border-radius: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-top: 20px;
        }

        .layui-btn-fluid:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .captcha-container {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .captcha-input {
            flex: 1;
        }

        .captcha-img {
            width: 120px;
            height: 50px;
            border-radius: 8px;
            overflow: hidden;
            border: 2px solid #e1e8ed;
        }

        .captcha-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .admin-login-background {
            animation: fadeInUp 0.6s ease-out;
        }

        .layui-form-item {
            animation: fadeInUp 0.6s ease-out;
            animation-fill-mode: both;
        }

        .layui-form-item:nth-child(1) { animation-delay: 0.1s; }
        .layui-form-item:nth-child(2) { animation-delay: 0.2s; }
        .layui-form-item:nth-child(3) { animation-delay: 0.3s; }
        .layui-form-item:nth-child(4) { animation-delay: 0.4s; }
        .layui-form-item:nth-child(5) { animation-delay: 0.5s; }
    </style>
</head>
<body>

<div class="layui-container">
    <div class="admin-login-background">
        <div class="layui-form login-form">
            <form class="layui-form"  action="${pageContext.request.contextPath}/loginIn" method="post">
                <div class="layui-form-item logo-title">
                    <h1>图书借阅管理系统</h1>
                    <div style="color: red;text-align: center;">${msg}</div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-username"></label>
                    <input type="text" name="username" lay-verify="required" placeholder="用户名" autocomplete="off" class="layui-input" >
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-password"></label>
                    <input type="password" name="password" lay-verify="required" placeholder="密码" autocomplete="off" class="layui-input" >
                </div>
                <div class="layui-form-item">
                    <label class="layui-icon layui-icon-username"></label>
                    <select name="type" lay-verify="required">

                        <option value="1">管理员</option>
                        <option value="2">读者</option>
                    </select>
                </div>
                <div class="layui-form-item">

                    <div class="layui-input-inline">
                        <div class="field">
                            <a href="javascript:void(0)"  id="code" ></a>
                        </div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <button class="layui-btn layui-btn layui-btn-normal layui-btn-fluid" lay-submit="" lay-filter="login">登录</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    getCode();
    /**
     * 获取验证码
     */
    function getCode(){
        document.getElementById("code").src=timestamp("verifyCode");
    }

    /**
     * 实现刷新更滑验证码
     */
    function timestamp(url){
        var gettime=new Date().getTime();
        if(url.indexOf("?")>-1){
            url=url+"&timestamp="+gettime;
        }else{
            url=url+"?timestamp="+gettime;
        }
        return url;
    }


    layui.use(['form'], function () {
        var form = layui.form,
            layer = layui.layer;
        form.on('submit(login)', function (data) {
            data = data.field;
            if (data.username == '') {
                layer.msg('用户名不能为空');
                return false;
            }
            if (data.password == '') {
                layer.msg('密码不能为空');
                return false;
            }

            if (data.type == '') {
                layer.msg('类型不能为空');
                return false;
            }
        });
    });
</script>
</body>
</html>