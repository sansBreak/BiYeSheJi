package per.liu.service.impl;

import org.springframework.stereotype.Service;
import per.liu.dao.ApplicationDao;
import per.liu.dao.BookDao;
import per.liu.domain.Book;
import per.liu.service.BookService;
import per.liu.utils.DateTimeUtil;
import per.liu.utils.RandomID;
import per.liu.vo.ApplicationVo;

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
        List<Book> bookList = bookDao.queryAllBookInfo();

        return bookList;
    }

    @Override
    public Book queryBookInfoById(String id) {
        System.out.println("已经到了service层的queryBookInfoById方法！！！！");
        Book book = bookDao.queryBookInfoById(id);

        return book;
    }

    //根据图书id，更新图书信息
    @Override
    public Boolean updateBookById(Book book) {
        Boolean flag = true;
        int result = bookDao.updateBookById(book);
        if (result != 1) {
            flag = false;
        }
        return flag;
    }

    //管理员：图书入库
    @Override
    public Boolean bookAdd(Book book) {
        Boolean flag = true;

        //1、取得一个bId，放入参数中
        String bId = RandomID.createOrderId();
        bId = "BK" + bId;
        book.setbId(bId);

        //2、取得今天的日期，放入参数中
        String time = DateTimeUtil.getSysTimeMin();
        book.setStorage_time(time);
        int result = bookDao.bookAdd(book);

        if (result != 1) {
            flag = false;
        }

        return flag;
    }

    //根据学生班级查询，已通过审批的图书信息，即学生即将领到的书籍
    @Override
    public List<ApplicationVo> queryReceiveBooks(String classId) {
        System.out.println("-------service层------");
        List<ApplicationVo> voList = null;
        try {
            voList = bookDao.queryReceiveBooks(classId,"1");
        }catch (Exception e){
            e.printStackTrace();
        }


        System.out.println("=======================================");

        for (ApplicationVo vo:voList) {
            System.out.println("vo:" + vo);
        }

        System.out.println("=======================================");

        return voList;
    }

    @Override
    public List<Book> queryBook(String name, String author, String publisher) {
        List<Book> bookList= bookDao.queryBook(name, author, publisher);
        for (Book book:bookList ) {
            System.out.println(":::::"+book);
        }
        return  bookList;
    }


}
