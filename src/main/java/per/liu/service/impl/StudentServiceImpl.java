package per.liu.service.impl;

import org.springframework.stereotype.Service;
import per.liu.dao.StudentDao;
import per.liu.domain.Student;
import per.liu.exception.LoginException;
import per.liu.service.StudentService;

import javax.annotation.Resource;
import java.util.HashMap;
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
}
