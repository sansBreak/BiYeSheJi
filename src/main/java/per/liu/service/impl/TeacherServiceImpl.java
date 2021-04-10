package per.liu.service.impl;

import javafx.fxml.LoadException;
import org.springframework.stereotype.Service;
import per.liu.dao.ClassDao;
import per.liu.dao.TeacherDao;
import per.liu.domain.Classe;
import per.liu.domain.Student;
import per.liu.domain.Teacher;
import per.liu.exception.LoginException;
import per.liu.service.TeacherService;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 17:21
 */
@Service
public class TeacherServiceImpl implements TeacherService {
    @Resource
    private TeacherDao teacherDao;
    @Resource
    private ClassDao classDao;

    @Override
    public Teacher login(String loginAct, String loginPwd) throws LoadException, LoginException {
        Map<String, String> map = new HashMap<>();
        map.put("loginAct", loginAct);
        map.put("loginPwd", loginPwd);

        Teacher teacher = teacherDao.login(map);
        if (teacher == null) {
            throw new LoginException("账号密码错误");
        }
        System.out.println("service层——" + teacher);

        return teacher;
    }

    @Override
    public Boolean changePwd(String loginPwd, String loginAct) {

        boolean flag = false;

        System.out.println("service层：：：" + loginAct + "   " + loginPwd);
        int count = 0;
        try {
            count = teacherDao.changePwd(loginPwd, loginAct);

        } catch (Exception e) {
            e.printStackTrace();
        }
        if (count != 1) {
            flag = false;
        }
        return flag;
    }

    //根据老师信息查询所负责学生信息
    @Override
    public List<Student> query_AllStudent(Teacher teacher) {

        //1、先由教师id经tbl_class 表，查出班级信息
        List<Classe> classList = classDao.queryClassByTch(teacher.getId());


        //2、根据班级信息，查出这些所属学生信息
        List<Student> studentList = null;
        try {
         studentList=  teacherDao.query_AllStudentByTchId(classList);
        }catch (Exception e){
            e.printStackTrace();
        }

        return studentList;
    }


}
