package per.liu.service;

import javafx.fxml.LoadException;
import per.liu.domain.Student;
import per.liu.domain.Teacher;
import per.liu.exception.LoginException;

import java.util.List;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 17:20
 */
public interface TeacherService {
    //老师模块登录功能
    Teacher login(String loginAct, String loginPwd) throws LoadException, LoginException;

    //老师模块 修改密码
    Boolean changePwd(String pwd, String loginAct);

    //根据老师信息查询所负责学生信息
    List<Student> query_AllStudent(Teacher teacher);

    //查询所有老师信息
    List<Teacher> queryAllTch();

    //添加新的老师
    Boolean addTch(Teacher teacher);

    //根据id查询教师信息
    Teacher queryTchById(String id);

    //修改老师信息
    Boolean editTch(Teacher teacher);
}
