package per.liu.dao;

import org.apache.ibatis.annotations.Param;
import per.liu.domain.Student;

import java.util.Map;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 15:48
 */
public interface StudentDao {

    //学生登录
    Student login(Map<String, String> map);

    //学生修改密码
    int changePwd(@Param("loginPwd") String loginPwd, @Param("loginAct") String loginAct );



}