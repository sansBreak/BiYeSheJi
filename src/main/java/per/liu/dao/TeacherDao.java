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

    //查询所有老师信息
    List<Teacher> queryAllTch();

    //查询所有老师信息
    int addTch(Teacher teacher);

    //根据id查询教师信息
    Teacher queryTchById(@Param("id")String id);

    //修改老师信息
    int editTch(Teacher teacher);

    //删除老师信息
    int deleteTchById(String id);
}
