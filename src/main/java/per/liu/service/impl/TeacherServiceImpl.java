package per.liu.service.impl;

import javafx.fxml.LoadException;
import org.springframework.stereotype.Service;
import per.liu.dao.TeacherDao;
import per.liu.domain.Teacher;
import per.liu.exception.LoginException;
import per.liu.service.TeacherService;

import javax.annotation.Resource;
import java.util.HashMap;
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
}
