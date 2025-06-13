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
        /* 美化现有的demoTable类 */
        .demoTable {
            background: #ffffff;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            border-left: 4px solid #1E9FFF;
        }

        /* 美化layui-form-item */
        .demoTable .layui-form-item {
            margin-bottom: 0;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        /* 美化layui-inline */
        .demoTable .layui-inline {
            margin-right: 15px;
        }

        /* 美化输入框 */
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

        /* 美化搜索按钮 */
        .demoTable .layui-btn {
            border-radius: 0.5rem;
            padding: 0.625rem 1.25rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            transition: all 0.3s ease;
            text-align: center;
            color: #fff;
            font-weight: 500;
            letter-spacing: 0.025em;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            cursor: pointer;
            white-space: nowrap;
            display: inline-flex; /* 修改为 flex 布局 */
            align-items: center; /* 垂直居中 */
            justify-content: center; /* 水平居中 */
            user-select: none;
            -webkit-user-select: none;
            touch-action: manipulation;
        }

        .demoTable .layui-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            filter: brightness(1.05);
        }

        .demoTable .layui-btn:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px -1px rgba(0, 0, 0, 0.12);
            filter: brightness(0.95);
        }

        .demoTable .layui-btn:focus {
            outline: 0;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.4);
        }

        .demoTable .layui-btn:disabled {
            opacity: 0.65;
            cursor: not-allowed;
            box-shadow: none;
        }
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <div class="demoTable">
            公告主题：
            <div class="layui-inline">
                <input class="layui-input" name="topic" id="topic" autocomplete="off">
            </div>
            <button class="layui-btn" data-type="reload">搜索</button>
        </div>

        <script type="text/html" id="toolbarDemo">
            <div class="modern-toolbar">
                <h3 style="margin-bottom: 15px; color: #2c3e50; font-weight: 600;">
                    <i class="layui-icon layui-icon-util" style="color: #1E9FFF;"></i> 操作工具
                </h3>
                <button class="layui-btn modern-btn btn-add" lay-event="add">
                    <i class="layui-icon layui-icon-add-1"></i> 发布公告
                </button>
                <button class="layui-btn modern-btn btn-delete" lay-event="delete">
                    <i class="layui-icon layui-icon-delete"></i> 批量删除
                </button>
            </div>
        </script>

        <!--表单，查询出的数据在这里显示-->
        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="query">查询详情</a>
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
            url: '${pageContext.request.contextPath}/noticeAll',//查询类型数据
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'topic', width: 150, title: '公告主题'},
                {field: 'content', width: 200, title: '公告内容'},
                {field: 'author', width: 100, title: '发布者'},
                // 删除这一行：{templet:"<div>{{layui.util.toDateString(d.createDate,'yyyy-MM-dd HH:mm:ss')}}</div>", width: 200, title: '发布时间'},
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
                url: "deleteNoticeByIds",
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
            if (obj.event === 'add') {  // 监听发布公告操作
                var index = layer.open({
                    title: '发布公告',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '60%'],
                    content: '${pageContext.request.contextPath}/noticeAdd',
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
