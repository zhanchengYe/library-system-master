<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>借阅管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
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

        .btn-back {
            background: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <div class="layuimini-main">
            <div class="demoTable">
                <div class="layui-form-item layui-form ">
                    借书卡
                    <div class="layui-inline">
                        <input class="layui-input" name="readerNumber" id="readerNumber" autocomplete="off">
                    </div>
                    图书名称
                    <div class="layui-inline">
                        <input class="layui-input" name="name" id="name" autocomplete="off">
                    </div>
                    归还类型
                    <div class="layui-inline">
                        <select class="layui-input" name="type" id="type">
                            <option value=""></option>
                            <option value="0">正常还书</option>
                            <option value="1">延迟还书</option>
                            <option value="2">破损还书</option>
                            <option value="3">丢失</option>
                        </select>
                    </div>
                   图书类型
                    <div class="layui-inline">
                        <select class="layui-input" name="status" id="status">
                            <option value=""></option>
                            <option value="0">未借出</option>
                            <option value="1">在借中</option>
                        </select>
                    </div>
                    <button class="layui-btn" data-type="reload">搜索</button>
                </div>
            </div>
        </div>
        <script type="text/html" id="toolbarDemo">
            <div class="modern-toolbar">
                <h3 style="margin-bottom: 15px; color: #2c3e50; font-weight: 600;">
                    <i class="layui-icon layui-icon-util" style="color: #1E9FFF;"></i> 操作工具
                </h3>
                <button class="layui-btn modern-btn btn-add" lay-event="add">
                    <i class="layui-icon layui-icon-add-1"></i> 新增借阅
                </button>
                <button class="layui-btn modern-btn btn-back" lay-event="back">
                    <i class="layui-icon layui-icon-return"></i> 批量归还
                </button>
                <button class="layui-btn modern-btn btn-delete" lay-event="delete">
                    <i class="layui-icon layui-icon-delete"></i> 批量删除
                </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
            {{# if(d.backDate==null){ }}
                <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">异常还书</a>
                <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
            {{# }else{ }}
               <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
            {{# } }}
        </script>

    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '${pageContext.request.contextPath}/lendListAll',//查询借阅图书记录
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                //{field: 'id', width: 100, title: 'ID', sort: true},
                {templet: '<div><a href="javascript:void(0)" style="color:#00b7ee" lay-event="bookInfoEvent">{{d.bookInfo.name}}</a></div>',
                    width: 100, title: '图书名称'},
                {templet: '<div>{{d.readerInfo.readerNumber}}</div>', width: 120, title: '借书卡'},
                {templet: '<div><a href="javascript:void(0)" style="color:#00b7ee" lay-event="readerInfoEvent">{{d.readerInfo.realName}}</a></div>',
                    width: 100, title: '借阅人'},
                // {templet: '<div>{{d.reader.name}}</div>', width: 80, title: '借阅人'},
                {templet:"<div>{{layui.util.toDateString(d.lendDate,'yyyy-MM-dd HH:mm:ss')}}</div>", width: 160, title: '借阅时间'},
                {field: 'backDate', width: 160, title: '还书时间'},
                {title:"还书类型",minWidth: 120,templet:function(res){
                        if(res.backType=='0'){
                            return '<span class="layui-badge" style="background-color: #28a745;">正常还书</span>'
                        }else if(res.backType=='1'){
                            return '<span class="layui-badge" style="background-color: #ffc107;">延迟还书</span>'
                        }
                        // ... 其他状态
                    }},
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
            limits: [10, 15, 20, 25, 50, 100],
            limit: 15,
            page: true,
            skin: 'line',
            id:'testReload'
        });


        var $ = layui.$, active = {
            reload: function(){
                var name = $('#name').val();
                var readerNumber = $('#readerNumber').val();
                var backType = $('#backType').val();
                var status = $('#status').val();
                //执行重载
                table.reload('testReload', {
                    page: {
                        curr: 1 //重新从第 1 页开始
                    }
                    ,where: {
                        name: name,
                        readerNumber:readerNumber,
                        backType:backType,
                        status:status
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
            if (obj.event === 'edit') {  // 监听添加操作
                var index = layer.open({
                    title: '异常还书',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${pageContext.request.contextPath}/excBackBook?id='+data.id+"&bookId="+data.bookId,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                layer.confirm('确定是否删除', function (index) {
                    //调用删除功能
                    //获取记录信息的id集合
                    deleteInfoByIds(data.id,data.bookId,index);
                    layer.close(index);
                });
            }else if( obj.event === 'bookInfoEvent') {//书的借阅线
                  //获取书的id
                  var bid=data.bookId;
                  queryLookBookList("book",bid);
            }else{//读者借阅线
                //获取读者的id
                var rid=data.readerId;
                queryLookBookList("user",rid);
            }
        });

        /**
         * 借阅线打开内容
         */
        function queryLookBookList(flag,id){
            var index = layer.open({
                title: '借阅时间线',
                type: 2,
                shade: 0.2,
                maxmin:true,
                shadeClose: true,
                area: ['60%', '60%'],
                content: '${pageContext.request.contextPath}/queryLookBookList?id='+id+"&flag="+flag,
            });
            $(window).on("resize", function () {
                layer.full(index);
            });
        }




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
            //拼接id
            return arr.join(",");
        };


        /**
         * 获取选中记录的中图书id集合*/
        function getCheackBookId(data){
            var arr=new Array();
            for(var i=0;i<data.length;i++){
                arr.push(data[i].bookId);
            }
            //拼接id
            return arr.join(",");
        };

        /**
         * 提交删除功能
         */
        function deleteInfoByIds(ids ,bookIds,index){
            //向后台发送请求
            $.ajax({
                url: "deleteLendListByIds",
                type: "POST",
                data: {ids: ids,bookIds:bookIds},
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
         * 提交还书功能
         */
        function backBooksByIds(ids ,bookIds,index){
            //向后台发送请求
            $.ajax({
                url: "backLendListByIds",
                type: "POST",
                data: {ids: ids,bookIds:bookIds},
                success: function (result) {
                    if (result.code == 0) {//如果成功
                        layer.msg('还书成功', {
                            icon: 6,
                            time: 500
                        }, function () {
                            parent.window.location.reload();
                            var iframeIndex = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(iframeIndex);
                        });
                    } else {
                        layer.msg("还书失败");
                    }
                }
            })
        };
        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '借书管理',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '${pageContext.request.contextPath}/addLendList',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            }else if (obj.event === 'back'){//还书操作
                //获取选中的记录信息
                //获取选中的记录信息
                var checkStatus=table.checkStatus(obj.config.id);
                //debugger;
                var data=checkStatus.data;

                if(data.length==0){//如果没有选中信息
                    layer.msg("请选择要借阅还书的记录信息");
                }else{
                    //获取记录信息的id集合
                    var ids=getCheackId(data);//借阅记录的id集合
                    var bookIds=getCheackBookId(data);//图书的id集合
                    layer.confirm('确定还书么', function (index) {
                        //调用还书功能
                        backBooksByIds(ids,bookIds,index);
                        layer.close(index);
                    });
                }
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
                    //获取记录信息的id集合
                    var ids=getCheackId(data);//借阅记录的id集合
                    var bookIds=getCheackBookId(data);//图书的id集合
                    layer.confirm('确定是否删除', function (index) {
                        //调用删除功能
                        deleteInfoByIds(ids,bookIds,index);
                        layer.close(index);
                    });
                }
            }
        });

    });
</script>

</body>
</html>
