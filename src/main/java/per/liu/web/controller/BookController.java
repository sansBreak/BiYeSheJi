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
    public List<Book> queryAllBookInfo() {

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
    public Book queryAllBookInfoById(String id) {

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
    public List<Classe> queryClassByTch(HttpServletRequest request) {

        System.out.println("queryClassByTch的controller层！！！！");

        Teacher teacher = (Teacher) request.getSession().getAttribute("tch");
        List<Classe> classeList = classService.queryClassByTch(teacher.getId());

        return classeList;
    }


    /**
     *
     * @param ap_book_id        //申请的图书id
	 * @param apply_amount     //申请图书数量
	 * @param apply_class_id   //申请班级id
	 * @param kuchun_amount   //图书库存数量
     */
    //教师为班级申请图书
    @RequestMapping("/addAppli.do")
    @ResponseBody
    public Boolean addAppli(String book_id,String appli_amount, String class_id,String kuchun_amount ,HttpServletRequest request) {
        /*
         * 需要的参数：
         *          教师信息————从session中获取  |教师id
         *          图书信息————前端获取         |书的id、申请数量
         *          申请班级————前端获取         |班级id
         * */

        Teacher teacher = (Teacher) request.getSession().getAttribute("tch");
        String teacher_id = teacher.getId();    //申请教师id

        System.out.println(
                        "教师id："+ teacher_id +
                        "   图书id：" + book_id +
                        "   图书申请数量：" +appli_amount +
                        "   申请班级id：" + class_id +
                        "   库存数量" + kuchun_amount
        );

        Boolean flag = bookService.addAppli(teacher_id, book_id, appli_amount, class_id,kuchun_amount);



        System.out.println( (flag)?"申请成功":"申请失败" );

        return flag;
    }
}
