<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>首页</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        .layui-card {border:1px solid #f2f2f2;border-radius:5px;}
        .icon {margin-right:10px;color:#1aa094;}
        .icon-cray {color:#ffb800!important;}
        .icon-blue {color:#1e9fff!important;}
        .icon-tip {color:#ff5722!important;}
        .layuimini-qiuck-module {text-align:center;margin-top: 10px}
        .layuimini-qiuck-module a i {display:inline-block;width:100%;height:60px;line-height:60px;text-align:center;border-radius:2px;font-size:30px;background-color:#F8F8F8;color:#333;transition:all .3s;-webkit-transition:all .3s;}
        .layuimini-qiuck-module a cite {position:relative;top:2px;display:block;color:#666;text-overflow:ellipsis;overflow:hidden;white-space:nowrap;font-size:14px;}
        .welcome-module {width:100%;height:210px;}
        .panel {background-color:#fff;border:1px solid transparent;border-radius:3px;-webkit-box-shadow:0 1px 1px rgba(0,0,0,.05);box-shadow:0 1px 1px rgba(0,0,0,.05)}
        .panel-body {padding:10px}
        .panel-title {margin-top:0;margin-bottom:0;font-size:12px;color:inherit}
        .label {display:inline;padding:.2em .6em .3em;font-size:75%;font-weight:700;line-height:1;color:#fff;text-align:center;white-space:nowrap;vertical-align:baseline;border-radius:.25em;margin-top: .3em;}
        .layui-red {color:red}
        .main_btn > p {height:40px;}
        .layui-bg-number {background-color:#F8F8F8;}
        .layuimini-notice:hover {background:#f6f6f6;}
        .layuimini-notice {  padding: 15px 20px; /* 增加内边距 */
            margin-bottom: 10px; /* 添加间距 */
            border-radius: 8px; /* 圆角效果 */
            box-shadow: 0 2px 8px rgba(0,0,0,0.1); /* 阴影效果 */
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); /* 渐变背景 */ }
        .layuimini-notice-title,.layuimini-notice-label {
            padding-right: 70px !important;text-overflow:ellipsis!important;overflow:hidden!important;white-space:nowrap!important;}
        .layuimini-notice-title {font-size: 16px; /* 增大标题字体 */
            font-weight: bold;
            color: #2c3e50; /* 深色标题 */  }
        .layuimini-notice-extra {position:absolute;top:50%;margin-top:-8px;right:16px;display:inline-block;height:16px;color:#999;}
    </style>
</head>
<body>
<div class="layuimini-container">

            <div class="layui-col-md4">

                <div class="layui-card">
                    <div class="layui-card-header"><i class="fa fa-bullhorn icon icon-tip"></i>公告</div>
                        <div class="layui-card-body layui-text">
                            <c:forEach var="notice" items="${noticeList}">
                                <div class="layuimini-notice">
                                    <div class="layuimini-notice-title">${notice.topic}</div>
                                    <!--   <div class="layuimini-notice-extra"><fmt:formatDate value="${notice.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></div>-->
                                    <div class="layuimini-notice-content layui-hide">
                                        ${notice.content}
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
            </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['layer', 'miniTab','echarts'], function () {
        var $ = layui.jquery,
            layer = layui.layer,
            miniTab = layui.miniTab,
            echarts = layui.echarts;

        miniTab.listen();

        /**
         * 查看公告信息
         **/
        $('body').on('click', '.layuimini-notice', function () {
            var title = $(this).children('.layuimini-notice-title').text(),
                noticeTime = $(this).children('.layuimini-notice-extra').text(),
                content = $(this).children('.layuimini-notice-content').html();
            var html = '<div style="padding:20px; text-align:justify; line-height: 24px; background: #ffffff; border-radius: 8px;">\n' +
                '<div style="text-align: center; margin-bottom: 20px; font-weight: bold; color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px"><h3>' + title + '</h3></div>\n' +
                '<div style="font-size: 14px; color: #34495e;">' + content + '</div>\n' +
                '</div>\n';
            parent.layer.open({
                type: 1,
                title: '公告'+'<span style="float: right;right: 1px;font-size: 12px;color: #b1b3b9;margin-top: 1px">'+noticeTime+'</span>',
                area: '300px;',
                shade: 0.8,
                id: 'layuimini-notice',
                btnAlign: 'c',
                moveType: 1,
                content:html
            });
        });
    });
</script>
</body>
</html>

