package per.liu.service.impl;

import org.springframework.stereotype.Service;
import per.liu.dao.ApplicationDao;
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
    @Resource
    private ApplicationDao applicationDao;

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

    //教师为班级申请图书
    @Override
    public Boolean addAppli(String tch_id, String book_id, String appli_amount, String class_id, String kuchun_amount) {
        boolean flag = true;

        //1、将申请放入tbl_application表中      同时，将状态改为0申请状态（0：未审批 1：审批通过 -1：审批未通过）
        int result1 = applicationDao.addAppli(tch_id, book_id, appli_amount, class_id,"0");

        if (result1 != 1){
            flag = false;
        }


        //2、对tbl_books表内容进行更新

        //取得库存更新后的数据
        Integer i = null;
        Integer j = null;
        if(appli_amount!=null && kuchun_amount!=null){
            i = Integer.valueOf(appli_amount);
            j = Integer.valueOf(kuchun_amount);
        }
        String amount = String.valueOf(j - i);

        int result2 = bookDao.updataBookAmount(book_id, amount);

        if (result2 != 1){
            flag = false;
        }

        return flag;
    }


    //教师为班级申请图书

}
