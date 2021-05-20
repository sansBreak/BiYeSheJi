package per.liu.service.impl;

import org.springframework.stereotype.Service;
import per.liu.dao.StudentDao;
import per.liu.domain.Student;
import per.liu.exception.LoginException;
import per.liu.service.StudentService;
import per.liu.vo.StudentExtend;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 11:13
 */
@Service
public class StudentServiceImpl implements StudentService {
    @Resource
    private StudentDao studentDao;

    @Override
    public Student login(String loginAct, String loginPwd) throws LoginException {
        Map<String, String> map = new HashMap<>();
        map.put("loginAct", loginAct);
        map.put("loginPwd", loginPwd);
        Student student = studentDao.login(map);
        if (student == null) {
            throw new LoginException("账号密码错误");
        }
        System.out.println("service层——" + student);
        return student;
    }

    @Override
    public Boolean changePwd(String loginPwd, String loginAct) {
        boolean flag = true;

        System.out.println("service层：：：" + loginAct + "   " + loginPwd);
        int count = 0;
        try {
             count = studentDao.changePwd(loginPwd,loginAct);

        } catch (Exception e) {
            e.printStackTrace();
        }
        if (count != 1) {  
            flag = false;
        }
        return flag;
    }

    //管理员模块：查询所有学生信息
    @Override
    public List<StudentExtend> query_AllStudent() {

        List<StudentExtend>list = studentDao.query_AllStudent();


        return list;
    }

    //管理员模块：添加学生
    @Override
    public Boolean addStudent(Student student) {
        boolean flag = true;

        //完善数据
        student.setLoginPwd("123456");

        int result = 0;
        try {
            result = studentDao.addStudent(student);
        }catch (Exception e){
            e.printStackTrace();
        }

        if (result != 1) {
            flag = false;
        }

        return flag;
    }

    //管理员：修改学生信息
    @Override
    public Boolean editStu(Student student) {
        boolean flag = true;


        int result = 0;
        try {
            result = studentDao.editStu(student);
        }catch (Exception e){
            e.printStackTrace();
        }

        if (result != 1) {
            flag = false;
        }


        System.out.println(flag);

        return flag;
    }

    //管理员：根据id查询学生信息
    @Override
    public Student queryStuById(String id) {


        return  studentDao.queryStuById(id);
    }

    //管理员：根据id删除学生信息
    @Override
    public Boolean deleteStuById(String id) {
        boolean flag = true;


        int result = 0;
        try {
            result = studentDao.deleteStuById(id);
        }catch (Exception e){
            e.printStackTrace();
        }

        if (result != 1) {
            flag = false;
        }


        return flag;
    }
}
