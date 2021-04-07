package per.liu.dao;

import org.apache.ibatis.annotations.Param;
import per.liu.domain.Book;
import per.liu.vo.ApplicationVo;

import java.util.List;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 15:48
 */
public interface ApplicationDao {

    //根据老师的id，查询老师所负责班级的申请情况  多表联查
    List<ApplicationVo> queryAllApplicationByTch(String tch_id) ;

    //管理员模块 查询老师所负责班级的申请情况
    List<ApplicationVo> queryAllApplication();

    //教师为班级申请图书
    int addAppli(@Param("tch_id") String tch_id,
                 @Param("book_id") String book_id,
                 @Param("appli_amount") String appli_amount,
                 @Param("class_id") String class_id,
                 @Param("status_0") String status_0);

}
