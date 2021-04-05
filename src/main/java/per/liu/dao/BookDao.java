package per.liu.dao;

import org.apache.ibatis.annotations.Param;
import per.liu.domain.Book;
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
}
