package per.liu.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import per.liu.domain.Classe;
import per.liu.domain.Manager;
import per.liu.domain.Student;
import per.liu.domain.Teacher;
import per.liu.service.ClassService;
import per.liu.service.ManagerService;
import per.liu.service.StudentService;
import per.liu.service.TeacherService;
import per.liu.vo.StudentExtend;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.time.temporal.TemporalAccessor;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description 该controller用于处理用户登录相关实现
 * @Author Alex
 * @Date 2021-04-01 10:48
 */

@Controller
@RequestMapping("user")
public class UserController {

    @Resource
    private StudentService studentService;
    @Resource
    private TeacherService teacherService;
    @Resource
    private ManagerService managerService;
    @Resource
    private ClassService classService;

    /*登录账号*/
    @RequestMapping("/login.do")
    @ResponseBody
    public Map<String, Object> login(String identity, String loginAct, String loginPwd, HttpServletRequest request) {
        //用于存放返回值
        Map<String, Object> map = new HashMap<>();

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
                System.out.println(identity + "已放进session");
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

    //根据老师信息查询所负责学生信息
    @RequestMapping("/query_AllStudentByTch.do")
    @ResponseBody
    public List<Student> query_AllStudentByTch(HttpServletRequest request){

        Teacher teacher = (Teacher) request.getSession().getAttribute("tch");
        List<Student> list = teacherService.query_AllStudent(teacher);


        return list;
    }


    //管理员模块：查询学生信息
    @RequestMapping("/query_AllStudent.do")
    @ResponseBody
    public List<StudentExtend> query_AllStudent(){
        List<StudentExtend> list =studentService.query_AllStudent();

        return list;
    }

    @RequestMapping("/query-Class.do")
    @ResponseBody
    public List<Classe> queryClass(){

        List<Classe> classeList = classService.queryClass();

        return classeList;
    }


    @RequestMapping("/addStu.do")
    @ResponseBody
    public Boolean addStudent(Student student){

        Boolean flag = studentService.addStudent(student);

        return flag;
    }

    @RequestMapping("/editStu.do")
    @ResponseBody
    public Boolean editStu(Student student){

        System.out.println(student);
        return studentService.editStu(student);
    }

    @RequestMapping("/queryStuById.do")
    @ResponseBody
    public Student queryStuById(String id){

        Student student = studentService.queryStuById(id);

        System.out.println(student);

        return student;
    }


    @RequestMapping("/deleteStuById.do")
    @ResponseBody
    public Boolean deleteStuById(String id){

        return studentService.deleteStuById(id);
    }


    @RequestMapping("/query_AllClass.do")
    @ResponseBody
    public List<Map<String, Object>> query_AllClass(){
        /*
        * 返回值为tbl_class 中的id name teacherId 和tbl_teacher 中的name
        * */

        List<Map<String, Object>> mapList = classService.query_AllClass();


        return mapList;
    }

    @RequestMapping("/queryAllTch.do")
    @ResponseBody
    public List<Teacher> queryAllTch(){

        return teacherService.queryAllTch();

    }

    @RequestMapping("/queryClassById.do")
    @ResponseBody
    public Classe queryClassById(String id){

        //根据班级id，查询其他信息
        return  classService.queryClassById(id);
    }

    @RequestMapping("/editClass.do")
    @ResponseBody
    public Boolean editClass(Classe classe){

        System.out.println("=======================\n"+ classe);
        //修改班级信息
        Boolean flag = classService.editClass(classe);

        return flag;
    }

    @RequestMapping("/deleteClassById.do")
    @ResponseBody
    public Boolean deleteClassById(String id){

        return  classService.deleteClassById(id);

    }

    @RequestMapping("/addClass.do")
    @ResponseBody
    public Boolean addClass(Classe classe){
        System.out.println(classe);

        Boolean flag = classService.addClass(classe);

        System.out.println("=---------------------------=");

        return flag;
    }

    @RequestMapping("/addTch.do")
    @ResponseBody
    public Boolean addTch(Teacher teacher){

        System.out.println(teacher);


        return teacherService.addTch(teacher);
    }


    @RequestMapping("/queryTchById.do")
    @ResponseBody
    public Teacher queryTchById(String id){
        Teacher teacher =   teacherService.queryTchById(id);

        return teacher;

    }

    @RequestMapping("/editTch.do")
    @ResponseBody
    public Boolean editTch(Teacher teacher){


        return teacherService.editTch(teacher);

    }

    @RequestMapping("/deleteTchById.do")
    @ResponseBody
    public Boolean deleteTchById(String id){


        return teacherService.deleteTchById(id);
    }
}
