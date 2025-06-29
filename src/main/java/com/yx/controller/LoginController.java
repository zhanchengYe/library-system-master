package com.yx.controller;

import com.yx.codeutil.IVerifyCodeGen;
import com.yx.codeutil.SimpleCharVerifyCodeGenImpl;
import com.yx.codeutil.VerifyCode;
import com.yx.po.Admin;
import com.yx.po.ReaderInfo;
import com.yx.service.AdminService;
import com.yx.service.ReaderInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class LoginController {

    @Autowired
    private AdminService adminService;
    @Autowired
    private ReaderInfoService readerService;
    /**
     * 登录页面的转发
     */
    @GetMapping("/login")
    public String login(){
        return "login";
    }

    /**
     * 获取验证码方法
     * @param request
     * @param response
     */


    /**
     * 登录验证
     */
    @RequestMapping("/loginIn")
    public String loginIn(HttpServletRequest request, Model model){
        //获取用户名与密码
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String code=request.getParameter("captcha");
        String type=request.getParameter("type");

//        code="";
        //判断验证码是否正确（验证码已经放入session）
        HttpSession session = request.getSession();
        String realCode = (String)session.getAttribute("VerifyCode");

            //验证码正确则判断用户名和密码
            if(type.equals("1")){//管理员信息
                //用户名和密码是否正确
                Admin admin=adminService.queryUserByNameAndPassword(username,password);
                if(admin==null){//该用户不存在
                    model.addAttribute("msg","用户名或密码错误");
                    return "login";
                }
                session.setAttribute("user",admin);
                session.setAttribute("type","admin");
            }else{//来自读者信息表
                ReaderInfo readerInfo=readerService.queryUserInfoByNameAndPassword(username,password);
                if(readerInfo==null){
                    model.addAttribute("msg","用户名或密码错误");
                    return "login";
                }
                session.setAttribute("user",readerInfo);
                session.setAttribute("type","reader");
            }

            return "index";

    }
    /**
     * 退出功能
     */
    @GetMapping("loginOut")
    public String loginOut(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.invalidate();//注销
        return "/login";
    }

}
