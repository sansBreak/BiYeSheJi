package per.liu.service;

import javafx.fxml.LoadException;
import per.liu.domain.Manager;
import per.liu.domain.Student;
import per.liu.exception.LoginException;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 18:05
 */
public interface ManagerService {
    //管理员模块登录功能
    Manager login(String loginAct, String loginPwd) throws LoadException, LoginException;
}
