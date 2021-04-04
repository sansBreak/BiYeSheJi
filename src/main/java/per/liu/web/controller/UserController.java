package per.liu.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import per.liu.domain.Manager;
import per.liu.domain.Student;
import per.liu.domain.Teacher;
import per.liu.service.ManagerService;
import per.liu.service.StudentService;
import per.liu.service.TeacherService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.time.temporal.TemporalAccessor;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description 该controller用于处理用户登录相关实现
 * @Author Alex
 * @Date 2021-04-01 10:48
 */

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private StudentService studentService;
    @Resource
    private TeacherService teacherService;
    @Resource
    private ManagerService managerService;

    /*登录账号*/
    @RequestMapping("/login.do")
    @ResponseBody
    public Map<String, Object> login(String identity, String loginAct, String loginPwd, HttpServletRequest request) {
        //用于存放返回值
        Map<String, Object> map = new HashMap<>();
        System.out.println("进入到验证登录操作");
        System.out.println("identity:" + identity + "\nloginAct:" + loginAct + "\nloginPwd:" + loginPwd);

        try {
            /*
             * 登录用户是学生的情形下
             * */
            if ("stu".equals(identity)) {
                System.out.println("用户是学生！");

                Student student = studentService.login(loginAct, loginPwd);
                System.out.println("这里是controller层 我已收到数据，感觉良好！\n" + student);

                // __________________________________________
                //将取得的student放在session中备用
                request.getSession().setAttribute("stu", student);
                request.getSession().setAttribute("identity", identity);

                //程序成功运行到此处，说明业务层没有为controller抛出任何异常，登录成功
                //此时应该通过ajax发给前台这个消息  {"success":true}
                map.put("success", true);

            } else if ("tch".equals(identity)) {
                /*
                 * 登录用户是老师的情形下
                 * */
                Teacher teacher = teacherService.login(loginAct, loginPwd);

                request.getSession().setAttribute("tch", teacher);
                request.getSession().setAttribute("identity", identity);
                System.out.println(identity + "已放进");
                map.put("success", true);

            } else if ("mgr".equals(identity)) {
                /*
                 * 登录用户是管理员的情形下
                 * */
                Manager manager = managerService.login(loginAct, loginPwd);

                request.getSession().setAttribute("mgr", manager);
                request.getSession().setAttribute("identity", identity);

                map.put("success", true);
            }

        } catch (Exception e) {
            e.printStackTrace();
            //一旦程序执行到catch块，说明业务层为我们的验证失败，为controller抛出异常，登录失败
            //此时应该通过ajax发给前台这个消息  {"success":false, "msg":?}
            String msg = e.getMessage();
            map.put("success", false);
            map.put("msg", msg);
        }

        return map;
    }

    /*查询当前登陆用户信息*/
    @RequestMapping("/personal-info.do")
    @ResponseBody
    public Object personalInfo(HttpServletRequest request) {
        //当前用户的信息，在登录时已经放在session中，直接取出即可，无需经过数据库
        Object objectInfo = null;
        String identity = (String) request.getSession().getAttribute("identity");

        if ("stu".equals(identity)) {
            objectInfo = (Student) request.getSession().getAttribute("stu");

        } else if ("tch".equals(identity)) {
            objectInfo = (Teacher) request.getSession().getAttribute("tch");

        } else if ("mgr".equals(identity)) {
            objectInfo = (Manager) request.getSession().getAttribute("mgr");
        }
        System.out.println(identity);
        System.out.println(objectInfo);
        System.out.println("查询当前登陆用户信息的 controloler");
        return objectInfo;
    }

    /*更改用户密码*/
    @RequestMapping("/change-password.do")
    @ResponseBody
    public Boolean changePwd(String loginPwd, HttpServletRequest request) {
        Boolean flag = false;
        System.out.println("controller层   这里是更改用户密码");

        String identity = (String) request.getSession().getAttribute("identity");
        System.out.println(identity);

        //学生
        if ("stu".equals(identity)) {
            Student student = (Student) request.getSession().getAttribute("stu");
            flag = studentService.changePwd(loginPwd, student.getLoginAct());
            //老师
        } else if ("tch".equals(identity)) {
            Teacher teacher = (Teacher) request.getSession().getAttribute("tch");
            flag = teacherService.changePwd(loginPwd, teacher.getLoginAct());

            //管理员
        } else if ("mgr".equals(identity)) {
            Manager manager = (Manager) request.getSession().getAttribute("mgr");
            flag = managerService.changePwd(loginPwd, manager.getLoginAct());
        }

        return flag;
    }
}
