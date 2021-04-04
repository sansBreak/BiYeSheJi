package per.liu.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import per.liu.domain.Book;
import per.liu.service.BookService;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-04 13:26
 */
@Controller
@RequestMapping("workbench/book")
public class BookController {

    @Resource
    private BookService bookService;

    @RequestMapping("/query-AllBookInfo.do")
    @ResponseBody
    public List<Book> queryAllBookInfo(){

        System.out.println("已经到了controller层！！！！");
        List<Book> bookList = bookService.queryAllBookInfo();

        /*System.out.println("------------------------------");
        for (Book book:bookList ) {
            System.out.println(book);
        }
        System.out.println("------------------------------");*/
        return bookList;
    }


}
