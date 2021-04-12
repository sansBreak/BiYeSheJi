package per.liu.service.impl;

import org.springframework.stereotype.Service;
import per.liu.dao.BookDao;
import per.liu.dao.ClassDao;
import per.liu.domain.Classe;
import per.liu.service.ClassService;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-04 18:19
 */
@Service
public class ClassServiceImpl implements ClassService {
    @Resource
    private ClassDao classDao;

    //根据教师id，查询所负责班级
    @Override
    public List<Classe> queryClassByTch(String id) {

        return classDao.queryClassByTch(id);
    }

    @Override
    public List<Classe> queryClass() {


        return classDao.queryClass();
    }

    //查询所有班级信息，包括老师姓名
    @Override
    public List<Map<String, Object>> query_AllClass() {


        List<Map<String, Object>> list = null;

        try {
            list = classDao.query_AllClass();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //根据班级id，查询其他信息
    @Override
    public Classe queryClassById(String id) {

        return classDao.queryClassById(id);
    }

    //修改班级信息
    @Override
    public Boolean editClass(Classe classe) {
        boolean flag = true;

        int result = classDao.editClass(classe);

        if (result != 1) {
            flag = false;
        }


        return flag;
    }

    //根据班级id，查询其他信息
    @Override
    public Boolean deleteClassById(String id) {
        boolean flag = true;

        int result = classDao.deleteClassById(id);

        if (result != 1) {
            flag = false;
        }

        return flag;
    }

    //管理员：添加班级
    @Override
    public Boolean addClass(Classe classe) {
        boolean flag = true;

        int result = classDao.addClass(classe);

        if (result != 1) {
            flag = false;
        }

        return flag;
    }
}
