package per.liu.service;

import per.liu.domain.Book;

import java.util.List;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-04 13:39
 */

public interface BookService {

    //查询全部图书
    List<Book> queryAllBookInfo();
}
