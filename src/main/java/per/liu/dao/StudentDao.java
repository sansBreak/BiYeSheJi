package per.liu.dao;

import org.apache.ibatis.annotations.Param;
import per.liu.domain.Student;
import per.liu.vo.StudentExtend;

import java.util.List;
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

    //管理员模块：查询所有学生信息
    List<StudentExtend> query_AllStudent();

    //管理员模块：添加学生
    int addStudent(Student student);
}