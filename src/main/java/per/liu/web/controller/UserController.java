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
            if ("stu".equals(identity)){
                System.out.println("用户是学生！");

                Student student = studentService.login(loginAct, loginPwd);
                System.out.println("这里是controller层 我已收到数据，感觉良好！\n" + student);

                // __________________________________________
                //将取得的student放在session中备用
                request.getSession().setAttribute("user", student);

                //程序成功运行到此处，说明业务层没有为controller抛出任何异常，登录成功
                //此时应该通过ajax发给前台这个消息  {"success":true}
                map.put("success", true);

            }else if ("tch".equals(identity)){
                /*
                 * 登录用户是老师的情形下
                 * */
                Teacher teacher = teacherService.login(loginAct, loginPwd);

                request.getSession().setAttribute("user", teacher);
                map.put("success", true);

            }else if ("mgr".equals(identity)){
                /*
                 * 登录用户是管理员的情形下
                 * */
                Manager manager = managerService.login(loginAct, loginPwd);

                request.getSession().setAttribute("user", manager);
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
}
