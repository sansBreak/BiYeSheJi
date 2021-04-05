package per.liu.service;

import org.springframework.stereotype.Service;
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

    //根据图书id查询图书
    Book queryBookInfoById(String id);

    //教师为班级申请图书
    Boolean addAppli(String teacher_id, String book_id, String appli_amount, String class_id, String kuchun_amount);
}
