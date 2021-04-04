package per.liu.service.impl;

import org.springframework.stereotype.Service;
import per.liu.dao.BookDao;
import per.liu.dao.ClassDao;
import per.liu.domain.Classe;
import per.liu.service.ClassService;

import javax.annotation.Resource;
import java.util.List;

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
}
