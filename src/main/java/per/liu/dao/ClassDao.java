package per.liu.dao;

import per.liu.domain.Book;
import per.liu.domain.Classe;

import java.util.List;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 15:48
 */

public interface ClassDao {
    //根据教师id，查询所负责班级
    List<Classe> queryClassByTch(String id);


    List<Classe> queryClass();
}
