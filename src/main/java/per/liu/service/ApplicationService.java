package per.liu.service;

import per.liu.domain.Book;
import per.liu.vo.ApplicationVo;

import java.util.List;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-04 13:39
 */


public interface ApplicationService {

    //教师为班级申请图书
    Boolean addAppli(String teacher_id, String book_id, String appli_amount, String class_id, String kuchun_amount);

    //根据老师的id，查询老师所负责班级的申请情况
    List<ApplicationVo> queryAllApplicationByTch(String tch_id);

    //管理员模块 查询老师所负责班级的申请情况
    List<ApplicationVo> queryAllApplication();
}