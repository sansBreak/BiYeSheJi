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

    //管理员：图书入库
    Boolean bookAdd(Book book);

    //根据学生班级查询，已通过审批的图书信息，即学生即将领到的书籍
    List<ApplicationVo> queryReceiveBooks(String classId);

    //搜索
    List<Book> queryBook(String name, String author, String publisher);
}
