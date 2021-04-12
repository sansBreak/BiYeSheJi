package per.liu.dao;

import per.liu.domain.Book;
import per.liu.domain.Classe;

import java.util.List;
import java.util.Map;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 15:48
 */

public interface ClassDao {
    //根据教师id，查询所负责班级
    List<Classe> queryClassByTch(String id);


    List<Classe> queryClass();

    //查询所有班级信息，包括老师姓名
    List<Map<String, Object>> query_AllClass();

    //根据班级id，查询其他信息
    Classe queryClassById(String id);

    //修改班级信息
    int editClass(Classe classe);

    //根据班级id，查询其他信息
    int deleteClassById(String id);
}
