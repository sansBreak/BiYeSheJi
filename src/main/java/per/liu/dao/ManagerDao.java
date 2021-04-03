package per.liu.dao;

import org.apache.ibatis.annotations.Param;
import per.liu.domain.Manager;
import per.liu.domain.Teacher;

import java.util.Map;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 15:48
 */
public interface ManagerDao {

    //管理员登录
    Manager login(Map<String, String> map);

    //管理员改密码
    int changePwd(@Param("loginPwd") String loginPwd, @Param("loginAct") String loginAct);
}
