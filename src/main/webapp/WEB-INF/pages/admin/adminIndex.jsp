<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>管理员管理</title>
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
        /* 搜索区域卡片 */
        .search-card {
            background: linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
            border-left: 4px solid #1E9FFF;
            position: relative;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .search-card::before {
            content: "";
            position: absolute;
            top: 0;
            right: 0;
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, rgba(30, 159, 255, 0.05) 0%, rgba(30, 159, 255, 0.02) 100%);
            border-radius: 0 0 0 100%;
            transform: translate(50%, -50%);
            z-index: 0;
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .search-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        .search-card:hover::before {
            width: 140px;
            height: 140px;
        }

        .search-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.25rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid #f1f3f5;
        }

        .search-card-title {
            font-size: 1.125rem;
            font-weight: 600;
            color: #333;
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .search-card-title i {
            color: #1E9FFF;
            font-size: 1.25rem;
        }

        .search-card-title::after {
            content: "";
            position: absolute;
            bottom: -0.75rem;
            left: 0;
            width: 40px;
            height: 2px;
            background: #1E9FFF;
        }

        .search-card-tools {
            display: flex;
            gap: 0.75rem;
        }

        .search-card-tools .tool-btn {
            background: transparent;
            border: 1px solid #e9ecef;
            border-radius: 0.375rem;
            padding: 0.375rem 0.75rem;
            color: #495057;
            font-size: 0.875rem;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 0.375rem;
        }

        .search-card-tools .tool-btn:hover {
            background: #f8f9fa;
            border-color: #dee2e6;
            color: #1E9FFF;
        }

        .search-card-tools .tool-btn i {
            font-size: 1rem;
        }

        .search-card .layui-form {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.25rem;
        }

        .search-card .layui-form-item {
            margin-bottom: 0;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .search-card .layui-form-label {
            padding: 0;
            width: auto;
            text-align: left;
            color: #495057;
            font-weight: 500;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .search-card .layui-form-label.required::after {
            content: "*";
            color: #e74c3c;
            font-size: 0.75rem;
        }

        .search-card .layui-input-block {
            margin-left: 0;
        }

        .search-card .layui-input,
        .search-card select {
            border: 2px solid #e1e8ed;
            border-radius: 0.5rem;
            padding: 0.625rem 0.9375rem;
            transition: all 0.3s ease;
            height: auto;
            font-size: 0.875rem;
            color: #495057;
        }

        .search-card .layui-input::placeholder,
        .search-card select::placeholder {
            color: #adb5bd;
        }

        .search-card .layui-input:focus,
        .search-card select:focus {
            border-color: #1E9FFF;
            box-shadow: 0 0 0 3px rgba(30, 159, 255, 0.15);
            outline: none;
            transform: translateY(-1px);
        }

        /* 输入框图标样式 */
        .search-card .layui-input-icon {
            position: relative;
        }

        .search-card .layui-input-icon input {
            padding-left: 2.25rem;
        }

        .search-card .layui-input-icon i {
            position: absolute;
            left: 0.875rem;
            top: 50%;
            transform: translateY(-50%);
            color: #868e96;
            pointer-events: none;
            transition: color 0.2s ease;
        }

        .search-card .layui-input-icon input:focus + i {
            color: #1E9FFF;
        }

        /* 搜索按钮样式 */
        .search-card .search-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 0.5rem;
            padding: 0.625rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .search-card .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            filter: brightness(1.05);
        }

        .search-card .search-btn:active {
            transform: translateY(0);
            filter: brightness(0.95);
        }

        .search-card .search-btn i {
            font-size: 1rem;
        }

        /* 重置按钮样式 */
        .search-card .reset-btn {
            background: #ffffff;
            color: #495057;
            border: 1px solid #e9ecef;
            border-radius: 0.5rem;
            padding: 0.625rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .search-card .reset-btn:hover {
            background: #f8f9fa;
            border-color: #dee2e6;
            transform: translateY(-1px);
        }

        .search-card .reset-btn:active {
            transform: translateY(0);
            background: #f1f3f5;
        }

        .search-card .reset-btn i {
            font-size: 1rem;
        }

        /* 响应式调整 */
        @media (max-width: 768px) {
            .search-card {
                border-radius: 0;
                margin: 0 -1rem;
                padding: 1rem 1.25rem;
            }

            .search-card .layui-form {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .search-card-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.75rem;
                margin-bottom: 1rem;
            }

            .search-card-tools {
                width: 100%;
                justify-content: space-between;
            }

            .search-card .search-btn,
            .search-card .reset-btn {
                width: 100%;
                margin-top: 0.5rem;
            }
        }


        /* 工具栏按钮美化 */
        .modern-toolbar {
            background: #ffffff;
            border-radius: 12px;
            padding: 15px 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .modern-btn {
            border-radius: 8px;
            padding: 10px 20px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: none;
            margin-right: 10px;
        }

        .modern-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }

        .btn-add {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }

        /* 表格容器美化 */
        .table-container {
            background: #ffffff;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        /* 表格头部美化 */
        .layui-table-header {
            background: linear-gradient(135deg, #b3b8b8 0%, #764ba2 100%);
        }

        .layui-table-header th {
            background: transparent;
            color: #32373a;
            font-weight: 600;
        }

        /* 表格行美化 */
        .layui-table tbody tr:hover {
            background: #f8f9ff;
            transform: scale(1.01);
            transition: all 0.3s ease;
        }

        /* 状态徽章美化 */
        .admin-badge {
            border-radius: 20px;
            padding: 5px 12px;
            font-size: 12px;
            font-weight: 500;
            border: none;
        }

        .admin-normal {
            background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
            color: #2c3e50;
        }

        .admin-senior {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            color: #2c3e50;
        }

        /* 操作按钮美化 */
        .action-btn {
            border-radius: 6px;
            padding: 6px 12px;
            font-size: 12px;
            border: none;
            transition: all 0.3s ease;
        }

        .action-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .search-card, .modern-toolbar, .table-container {
                margin: 10px;
                padding: 15px;
            }

            .modern-btn {
                margin-bottom: 10px;
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <div class="demoTable">
            <div class="search-card">
                <div class="table-container">
                <h3 style="margin-bottom: 20px; color: #2c3e50; font-weight: 600;">
                    <i class="layui-icon layui-icon-search" style="color: #1E9FFF;"></i> 搜索条件
                </h3>
                <div class="layui-form-item layui-form">
                    <div class="layui-row layui-col-space15">
                        <div class="layui-col-md6">
                            <label class="layui-form-label">用户名：</label>
                            <div class="layui-input-block">
                                <input class="layui-input" name="username" id="username" placeholder="请输入用户名" autocomplete="off">
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <label class="layui-form-label">管理员类型：</label>
                            <div class="layui-input-block">
                                <select id="adminType" name="adminType" class="layui-input">
                                    <option value="">请选择</option>
                                    <option value="0">普通管理员</option>
                                    <option value="1">高级管理员</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-row" style="margin-top: 20px; text-align: center;">
                        <button class="layui-btn modern-btn" data-type="reload" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                            <i class="layui-icon layui-icon-search"></i> 搜索
                        </button>

                    </div>
                </div>
            </div>
        </div>

        <script type="text/html" id="toolbarDemo">
            <div class="modern-toolbar">
                <h3 style="margin-bottom: 15px; color: #2c3e50; font-weight: 600;">
                    <i class="layui-icon layui-icon-util" style="color: #1E9FFF;"></i> 操作
                </h3>
                <button class="layui-btn modern-btn btn-add" lay-event="add">
                    <i class="layui-icon layui-icon-add-1"></i> 添加管理员
                </button>
                <button class="layui-btn modern-btn btn-delete" lay-event="delete">
                    <i class="layui-icon layui-icon-delete"></i> 批量删除
                </button>
            </div>
        </script>

        <!--表单，查询出的数据在这里显示-->
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>
    </div>
        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">修改密码</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
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
            url: '${pageContext.request.contextPath}/adminAll',//查询全部数据
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter',{
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                //{field: 'id', width: 100, title: 'ID', sort: true},
                {field: 'username', width: 150, title: '用户名'},
                {field: 'adminType', width: 200, title: '管理员类型', templet: function (res) {
                        if (res.adminType == '0'){
                            return '<span class="admin-badge admin-normal">普通管理员</span>';
                        } else {
                            return '<span class="admin-badge admin-senior">高级管理员</span>';
                        }
                    }},
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
                var username = $('#username').val();
                var adminType = $('#adminType').val();
                console.log(name)
                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        username: username,
                        adminType:adminType
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
            if (obj.event === 'edit') {  // 监听修改操作
                var index = layer.open({
                    title: '修改管理员信息',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '${pageContext.request.contextPath}/queryAdminById?id='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                layer.confirm('确定是否删除', function (index) {
                    //调用删除功能
                    deleteInfoByIds(data.id,index);
                    layer.close(index);
                });
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        /**
         * 获取选中记录的id信息
         */
        function getCheackId(data){
            var arr=new Array();
            for(var i=0;i<data.length;i++){
                arr.push(data[i].id);
            }
            //拼接id,变成一个字符串
            return arr.join(",");
        };

        /**
         * 提交删除功能
         */
        function deleteInfoByIds(ids ,index){
            //向后台发送请求
            $.ajax({
                url: "deleteAdminByIds",
                type: "POST",
                data: {ids: ids},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('删除成功', {
                            icon: 6,
                            time: 500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg("删除失败");
                    }
                }
            })
        };

        /**
         * toolbar栏监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '添加管理员',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '${pageContext.request.contextPath}/adminAdd',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {
                /*
                  1、提示内容，必须删除大于0条
                  2、获取要删除记录的id信息
                  3、提交删除功能 ajax
                */
                //获取选中的记录信息
                var checkStatus=table.checkStatus(obj.config.id);
                var data=checkStatus.data;
                if(data.length==0){//如果没有选中信息
                    layer.msg("请选择要删除的记录信息");
                }else{
                    //获取记录信息的id集合,拼接的ids
                    var ids=getCheackId(data);
                    layer.confirm('确定是否删除', function (index) {
                        //调用删除功能
                        deleteInfoByIds(ids,index);
                        layer.close(index);
                    });
                }
            }
        });

    });
</script>

</body>
</html>
