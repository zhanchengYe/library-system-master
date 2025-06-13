<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>统计数据</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/public.css" media="all">
    <style>
        /* 整合上述所有样式 */
        .layui-card {
            border: 1px solid #f2f2f2;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 15px;
            transition: box-shadow 0.3s ease;
        }

        .layui-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }

        /* 其他样式... */
    </style>
    <style>
        .layui-card {
            border: 1px solid #f2f2f2;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 15px;
        }

        .layui-card-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            padding: 12px 15px;
            font-weight: 500;
            color: #495057;
        }

        .layui-card-body {
            padding: 15px;
        }

        .layui-col-space15 {
            margin: -7.5px;
        }

        .layui-col-space15 > [class*="layui-col-"] {
            padding: 7.5px;
        }
    </style>
    <style>
        #bookTypeChart, #lendStatusChart, #trendChart {
            border: 1px solid #e9ecef;
            border-radius: 4px;
            background-color: #fff;
        }

        .chart-container {
            position: relative;
            overflow: hidden;
        }

        .chart-loading {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: #999;
        }
    </style>
    <style>
        .layui-table {
            margin-top: 0;
        }

        .layui-table th {
            background-color: #f8f9fa;
            font-weight: 500;
            color: #495057;
        }

        .layui-table td {
            border-bottom: 1px solid #f0f0f0;
        }

        .layui-table tbody tr:hover {
            background-color: #f5f5f5;
        }

        .layui-progress {
            margin: 0;
            height: 16px;
        }

        .layui-progress-bar {
            border-radius: 8px;
        }
    </style>
    <style>
        .filter-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .filter-section .layui-form-label {
            color: white;
            font-weight: 500;
        }

        .filter-section .layui-input {
            border: 1px solid rgba(255,255,255,0.3);
            background: rgba(255,255,255,0.1);
            color: white;
        }

        .filter-section .layui-input::placeholder {
            color: rgba(255,255,255,0.7);
        }

        .filter-section .layui-btn {
            background: rgba(255,255,255,0.2);
            border: 1px solid rgba(255,255,255,0.3);
            color: white;
        }

        .filter-section .layui-btn:hover {
            background: rgba(255,255,255,0.3);
        }
    </style>
    <style>
        @media (max-width: 768px) {
            .layui-col-md6 {
                width: 100%;
                margin-bottom: 15px;
            }

            #bookTypeChart, #lendStatusChart, #trendChart {
                height: 300px !important;
            }

            .layui-table {
                font-size: 12px;
            }

            .filter-section .layui-inline {
                display: block;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>

<!-- 时间筛选区域 -->
<div class="layui-card" style="margin-bottom: 15px;">
    <div class="layui-card-body">
        <div class="layui-form layui-form-pane">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">统计时间</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="startDate" placeholder="开始日期">
                    </div>
                    <div class="layui-form-mid">-</div>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" id="endDate" placeholder="结束日期">
                    </div>
                </div>
                <div class="layui-inline">
                    <button class="layui-btn" onclick="refreshStats()">
                        <i class="layui-icon layui-icon-search"></i> 刷新统计
                    </button>

                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 日期选择器初始化
    layui.use(['laydate'], function(){
        var laydate = layui.laydate;

        laydate.render({
            elem: '#startDate',
            type: 'date'
        });

        laydate.render({
            elem: '#endDate',
            type: 'date'
        });
    });

    // 刷新统计数据
    function refreshStats() {
        var startDate = document.getElementById('startDate').value;
        var endDate = document.getElementById('endDate').value;

        if(startDate && endDate) {
            // 重新加载页面并传递参数
            window.location.href = 'statisticIndex?startDate=' + startDate + '&endDate=' + endDate;
        } else {
            layer.msg('请选择时间范围');
        }
    }
</script>
<!-- 多图表布局 -->
<div class="layui-row layui-col-space15">
    <div class="layui-col-md6">
        <div class="layui-card">
            <div class="layui-card-header">图书类型分布</div>
            <div class="layui-card-body">
                <div id="bookTypeChart" style="width: 100%;height:350px"></div>
            </div>
        </div>
    </div>
    <div class="layui-col-md6">
        <div class="layui-card">
            <div class="layui-card-header">借阅状态统计</div>
            <div class="layui-card-body">
                <div id="lendStatusChart" style="width: 100%;height:350px"></div>
            </div>
        </div>
    </div>
</div>


<div class="layui-row" style="margin-top: 15px;">
    <div class="layui-col-md12">
        <div class="layui-card">
            <div class="layui-card-header">月度借阅趋势</div>
            <div class="layui-card-body">
                <div id="trendChart" style="width: 100%;height:300px"></div>
            </div>
        </div>
    </div>
</div>

<!-- 详细数据表格 -->
<div class="layui-row" style="margin-top: 15px;">
    <div class="layui-col-md12">
        <div class="layui-card">
            <div class="layui-card-header">详细统计数据</div>
            <div class="layui-card-body">
                <table class="layui-table" lay-skin="line">
                    <thead>
                    <tr>
                        <th>序号</th>
                        <th>图书类型</th>
                        <th>图书数量</th>
                        <th>占比</th>
                        <th>状态</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${bookTypeList}" var="type" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${type.name}</td>
                            <td>${type.counts}</td>
                            <td>
                                <div class="layui-progress" lay-showpercent="true">
                                    <div class="layui-progress-bar" lay-percent="${type.counts * 100 / 500}%"></div>
                                </div>
                            </td>
                            <td>
                                <span class="layui-badge layui-bg-green">正常</span>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['echarts'], function(){
        var echarts = layui.echarts;

        // 图书类型柱状图
        var bookTypeChart = echarts.init(document.getElementById('bookTypeChart'), 'walden');
        var bookTypeOption = {
            title: {
                text: '图书类型分布',
                left: 'center',
                textStyle: { fontSize: 16 }
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: { type: 'shadow' }
            },
            xAxis: {
                type: 'category',
                data: [
                    <c:forEach items="${bookTypeList}" var="type" varStatus="status">
                    '${type.name}'<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ],
                axisLabel: { rotate: 45 }
            },
            yAxis: {
                type: 'value',
                name: '数量',
                nameTextStyle: { padding: [0, 0, 0, 20] }
            },
            series: [{
                name: '图书数量',
                type: 'bar',
                data: [
                    <c:forEach items="${bookTypeList}" var="type" varStatus="status">
                    ${type.counts}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ],
                itemStyle: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                        {offset: 0, color: '#83bff6'},
                        {offset: 0.5, color: '#188df0'},
                        {offset: 1, color: '#188df0'}
                    ])
                }
            }]
        };
        bookTypeChart.setOption(bookTypeOption);

        // 借阅状态饼图
        var lendStatusChart = echarts.init(document.getElementById('lendStatusChart'), 'walden');
        var lendStatusOption = {
            title: {
                text: '借阅状态分布',
                left: 'center',
                textStyle: { fontSize: 16 }
            },
            tooltip: {
                trigger: 'item',
                formatter: '{a} <br/>{b}: {c} ({d}%)'
            },
            legend: {
                orient: 'vertical',
                left: 'left'
            },
            series: [{
                name: '借阅状态',
                type: 'pie',
                radius: '50%',
                center: ['50%', '60%'],
                data: [
                    {value: ${lendStatusStats.borrowing}, name: '在借中'},
                    {value: ${lendStatusStats.returned}, name: '已归还'}
                ],
                emphasis: {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }]
        };
        lendStatusChart.setOption(lendStatusOption);

        // 月度借阅趋势线图
        var trendChart = echarts.init(document.getElementById('trendChart'), 'walden');
        var trendOption = {
            title: {
                text: '月度借阅趋势',
                left: 'center',
                textStyle: { fontSize: 16 }
            },
            tooltip: {
                trigger: 'axis',
                formatter: '{b}: {c}本'
            },
            xAxis: {
                type: 'category',
                data: [
                    <c:forEach items="${monthlyTrend}" var="month" varStatus="status">
                    '${month.month}'<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ]
            },
            yAxis: {
                type: 'value',
                name: '借阅数量'
            },
            series: [{
                name: '借阅数量',
                type: 'line',
                smooth: true,
                data: [
                    <c:forEach items="${monthlyTrend}" var="month" varStatus="status">
                    ${month.count}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ],
                itemStyle: { color: '#ff7f50' },
                areaStyle: {
                    color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                        {offset: 0, color: 'rgba(255, 127, 80, 0.3)'},
                        {offset: 1, color: 'rgba(255, 127, 80, 0.1)'}
                    ])
                }
            }]
        };
        trendChart.setOption(trendOption);

        // 响应式处理
        window.addEventListener('resize', function() {
            bookTypeChart.resize();
            lendStatusChart.resize();
            trendChart.resize();
        });
    });
</script>
</body>
</html>
