package per.liu.service.impl;

import javafx.fxml.LoadException;
import org.springframework.stereotype.Service;
import per.liu.dao.ManagerDao;
import per.liu.domain.Manager;
import per.liu.domain.Student;
import per.liu.exception.LoginException;
import per.liu.service.ManagerService;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 18:05
 */
@Service
public class ManagerServiceImpl implements ManagerService {
    @Resource
    private ManagerDao managerDao;

    @Override
    public Manager login(String loginAct, String loginPwd) throws LoadException, LoginException {
        Map<String, String> map = new HashMap<>();
        map.put("loginAct", loginAct);
        map.put("loginPwd", loginPwd);

        Manager manager = managerDao.login(map);

        if (manager == null) {
            throw new LoginException("账号密码错误");
        }

        System.out.println("service层--——" + manager);

        return manager;
    }

    @Override
    public Boolean changePwd(String loginPwd, String loginAct) {
        boolean flag = false;

        System.out.println("service层：：：" + loginAct + "   " + loginPwd);
        int count = 0;
        try {
            count = managerDao.changePwd(loginPwd,loginAct);

        } catch (Exception e) {
            e.printStackTrace();
        }
        if (count != 1) {
            flag = false;
        }
        return flag;
    }
}
