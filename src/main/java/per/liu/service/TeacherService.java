package per.liu.service;

import javafx.fxml.LoadException;
import per.liu.domain.Student;
import per.liu.domain.Teacher;
import per.liu.exception.LoginException;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 17:20
 */
public interface TeacherService {
    //老师模块登录功能
    Teacher login(String loginAct, String loginPwd) throws LoadException, LoginException;
}
