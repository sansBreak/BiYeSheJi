package per.liu.service;

import javafx.fxml.LoadException;
import per.liu.domain.Student;
import per.liu.domain.Teacher;
import per.liu.exception.LoginException;
import per.liu.vo.StudentExtend;

import java.util.List;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 11:11
 */
public interface StudentService {

    //学生模块登录功能
    Student login(String loginAct, String loginPwd) throws LoadException, LoginException;

    //学生模块 修改密码
    Boolean changePwd(String pwd, String loginAct);

    //管理员模块：查询所有学生信息
    List<StudentExtend> query_AllStudent();

    //管理员模块：添加学生
    Boolean addStudent(Student student);

    //管理员：修改学生信息
    Boolean editStu(Student student);

    //管理员：根据id查询学生信息
    Student queryStuById(String id);

    //管理员：根据id删除学生信息
    Boolean deleteStuById(String id);
}
