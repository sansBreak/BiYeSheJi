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

    //管理员模块：管理员同意老师的申请
    Boolean agreeAppli( String  id, String grant_place, String grant_time);

    //管理员模块：管理员驳回老师的申请
    Boolean rejectionAppli(String id);

    //管理员模块：删除已审批的申请
    Boolean deleteApplication(String id);
}
