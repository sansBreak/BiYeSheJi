package per.liu.service;

import javafx.fxml.LoadException;
import per.liu.domain.Student;
import per.liu.exception.LoginException;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 11:11
 */
public interface StudentService {
    //学生模块登录功能
    Student login(String loginAct, String loginPwd) throws LoadException, LoginException;
}
