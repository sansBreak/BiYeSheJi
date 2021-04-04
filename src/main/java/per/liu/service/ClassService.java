package per.liu.service;


import per.liu.domain.Classe;

import java.util.List;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-04 13:39
 */

public interface ClassService {


    //根据教师id，查询所负责班级
    List<Classe> queryClassByTch(String id);
}
