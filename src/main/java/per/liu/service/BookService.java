package per.liu.service;

import org.springframework.stereotype.Service;
import per.liu.domain.Book;
import per.liu.vo.ApplicationVo;

import java.util.List;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-04 13:39
 */


public interface BookService {

    //查询全部图书
    List<Book> queryAllBookInfo();

    //根据图书id查询图书
    Book queryBookInfoById(String id);

    //根据图书id，更新图书信息
    Boolean updateBookById(Book book);
}
