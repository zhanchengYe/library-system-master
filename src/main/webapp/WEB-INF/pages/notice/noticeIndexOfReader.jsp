<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>类型管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
    <style>
        /* 整体容器美化 */
        .layuimini-container {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
        }

        /* 搜索区域卡片化 */
        .demoTable {
            background: #ffffff;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            border-left: 4px solid #1E9FFF;
        }

        .demoTable .layui-input {
            border: 2px solid #e1e8ed;
            border-radius: 8px;
            padding: 10px 15px;
            transition: all 0.3s ease;
        }

        .demoTable .layui-input:focus {
            border-color: #1E9FFF;
            box-shadow: 0 0 0 3px rgba(30, 159, 255, 0.1);
        }

        .demoTable .layui-btn {
            border-radius: 8px;
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            transition: all 0.3s ease;
            text-align: center;
            display: flex; /* 使用Flexbox */
            justify-content: center; /* 水平居中 */
            align-items: center; /* 垂直居中 */
        }

        .demoTable .layui-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        /* 表格容器美化 */
        .layui-table-view {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .layui-table-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .layui-table-header th {
            color: #253540;
            font-weight: 600;
        }

        .layui-table tbody tr:hover {
            background: #f8f9ff;
            transition: all 0.3s ease;
        }

        .layuimini-main {
            padding: 20px;
        }
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <div class="demoTable">
            <div style="background: #ffffff; border-radius: 12px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.08);">
            <h3 style="margin-bottom: 20px; color: #2c3e50; font-weight: 600;">
                <i class="layui-icon layui-icon-search" style="color: #1E9FFF;"></i> 搜索条件
            </h3>
            <div style="display: flex; align-items: center; gap: 15px;">
                公告主题：
                <div class="layui-inline">
                    <input class="layui-input" name="topic" id="topic" placeholder="请输入公告主题" autocomplete="off">
                </div>
                <button class="layui-btn" data-type="reload">
                    <i class="layui-icon layui-icon-search"></i> 搜索
                </button>
            </div>
        </div>

        <!--表单，查询出的数据在这里显示-->
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
        </div>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="query">查询详情</a>
        </script>

    </div>
</div>

<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/noticeAll',//查询类型数据
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                //{type: "checkbox", width: 50},
                //{field: 'id', width: 100, title: 'ID', sort: true},
                {field: 'topic', width: 150, title: '公告主题'},
                {field: 'content', width: 200, title: '公告内容'},
                {field: 'author', width: 100, title: '发布者'},
                {templet:"<div>{{layui.util.toDateString(d.createDate,'yyyy-MM-dd HH:mm:ss')}}</div>", width: 200, title: '发布时间'},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,  <!--默认显示15条-->
            page: true,
            skin: 'line',
            id:'testReload'
        });

        var $ = layui.$, active = {
            reload: function(){
                var topic = $('#topic').val();
                console.log(name)
                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        topic: topic
                    }
                }, 'data');
            }
        };

        $('.demoTable .layui-btn').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

        /**
         * tool操作栏监听事件
         */
        table.on('tool(currentTableFilter)', function (obj) {
            var data=obj.data;
            if (obj.event === 'query') {  // 监听查询详情操作
                var index = layer.open({
                    title: '查看公告',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '${pageContext.request.contextPath}/queryNoticeById?id='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            }
        });
    });
</script>

</body>
</html>
