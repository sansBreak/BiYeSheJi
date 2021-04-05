package per.liu.dao;

import org.apache.ibatis.annotations.Param;
import per.liu.domain.Book;

import java.util.List;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 15:48
 */
public interface ApplicationDao {
    //教师为班级申请图书
    int addAppli(@Param("tch_id") String tch_id,
                 @Param("book_id") String book_id,
                 @Param("appli_amount") String appli_amount,
                 @Param("class_id") String class_id,
                 @Param("status_0") String status_0);

}
