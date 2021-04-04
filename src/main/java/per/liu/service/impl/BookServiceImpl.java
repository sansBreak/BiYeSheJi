package per.liu.service.impl;

import org.springframework.stereotype.Service;
import per.liu.dao.BookDao;
import per.liu.domain.Book;
import per.liu.service.BookService;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-04 13:40
 */
@Service
public class BookServiceImpl implements BookService {

    @Resource
    private BookDao bookDao;

    @Override
    public List<Book> queryAllBookInfo() {

        System.out.println("已经到了service层！！！！");
        List<Book> bookList =  bookDao.queryAllBookInfo();

        return bookList;
    }
}
