package per.liu.dao;

import org.apache.ibatis.annotations.Param;
import per.liu.domain.Application;
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


    //管理员模块：管理员同意老师的申请
    int agreeAppli(@Param("id")String id,
                   @Param("status")String status,
                   @Param("grant_place")String grant_place,
                   @Param("grant_time")String grant_time);

    //管理员模块：管理员驳回老师的申请
    int rejectionAppli(@Param("id")String id, @Param("status")String status);

    //2、先根据订单id查出图书的id与数量
    Application queryBookInfoById(@Param("id")String id);
}
