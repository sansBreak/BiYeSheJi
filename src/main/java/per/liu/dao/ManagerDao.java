package per.liu.dao;

import per.liu.domain.Manager;
import per.liu.domain.Teacher;

import java.util.Map;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 15:48
 */
public interface ManagerDao {

    public Manager login(Map<String, String> map);
}
