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
public interface BookDao {

    //查询全部图书信息
    List<Book> queryAllBookInfo();

    //根据图书id查询图书
    Book queryBookInfoById(String id);

    int updataBookAmount(@Param("id") String id,@Param("amount") String amount);

    //根据图书id，更新图书信息
    int updateBookById(Book book);

    //管理员：图书入库
    int bookAdd(Book book);

    //根据学生班级查询，已通过审批的图书信息，即学生即将领到的书籍
    List<ApplicationVo> queryReceiveBooks(@Param("classId")String classId,
                                          @Param("status")String status);

    //搜索
    List<Book> queryBook(@Param("name")String name,
                         @Param("author")String author,
                         @Param("publisher")String publisher);
}