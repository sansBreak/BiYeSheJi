package per.liu.dao;

import org.apache.ibatis.annotations.Param;
import per.liu.domain.Classe;
import per.liu.domain.Student;
import per.liu.domain.Teacher;

import java.util.List;
import java.util.Map;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 15:48
 */
public interface TeacherDao {

    public Teacher login(Map<String, String> map);

    int changePwd(@Param("loginPwd") String loginPwd, @Param("loginAct") String loginAct );


    //根据老师信息查询所负责学生信息
    List<Student> query_AllStudentByTchId(List<Classe> classeList);

}
