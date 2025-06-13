package com.yx.controller;

import com.yx.po.BookInfo;
import com.yx.po.TypeInfo;
import com.yx.service.BookInfoService;
import com.yx.service.TypeInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class StatisticsController {

    @Autowired
    private BookInfoService bookInfoService;

    @Autowired
    private TypeInfoService typeInfoService;


    @GetMapping("statisticIndex")
    public String statistics(Model model){
        // 原有的图书类型统计
        List<BookInfo> bookTypeList = bookInfoService.getBookCountByType();
        model.addAttribute("bookTypeList", bookTypeList);

        // 新增：借阅状态统计
        Map<String, Object> lendStatusStats = new HashMap<>();
        // 需要在LendListService中添加这些方法
        lendStatusStats.put("borrowing", 150); // 示例数据，实际需要查询
        lendStatusStats.put("returned", 300);
        model.addAttribute("lendStatusStats", lendStatusStats);

        // 新增：月度借阅趋势（最近6个月）
        List<Map<String, Object>> monthlyTrend = new ArrayList<>();
        // 示例数据，实际需要从数据库查询
        for(int i = 5; i >= 0; i--) {
            Map<String, Object> monthData = new HashMap<>();
            monthData.put("month", "2024-" + String.format("%02d", 12-i));
            monthData.put("count", 50 + i * 10);
            monthlyTrend.add(monthData);
        }
        model.addAttribute("monthlyTrend", monthlyTrend);

        return "count/statisticIndex";
    }
}
