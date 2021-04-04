package per.liu.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import per.liu.domain.Book;
import per.liu.domain.Classe;
import per.liu.domain.Student;
import per.liu.domain.Teacher;
import per.liu.service.BookService;
import per.liu.service.ClassService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
    @Resource
    private ClassService classService;

    //直接查询全部图书信息
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

    //根据图书id，查询图书信息
    @RequestMapping("/query-BookInfo-ById.do")
    @ResponseBody
    public Book queryAllBookInfoById(String id){

        System.out.println("queryAllBookInfoById的controller层！！！！");
        Book book = bookService.queryBookInfoById(id);

        /*System.out.println("------------------------------");
        for (Book book:bookList ) {
            System.out.println(book);
        }
        System.out.println("------------------------------");*/

        System.out.println(book);
        return book;
    }

    //根据教师id，查询所负责班级
    @RequestMapping("/query-Class-ByTch.do")
    @ResponseBody
    public List<Classe> queryClassByTch(HttpServletRequest request){

        System.out.println("queryClassByTch的controller层！！！！");

        Teacher teacher = (Teacher) request.getSession().getAttribute("tch");
        List<Classe> classeList = classService.queryClassByTch(teacher.getId());

        return classeList;
    }


}
