package per.liu.dao;

import per.liu.domain.Student;

import java.util.Map;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 15:48
 */
public interface StudentDao {


    public Student login(Map<String, String> map);
}
