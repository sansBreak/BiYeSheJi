package per.liu.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import per.liu.domain.Teacher;
import per.liu.service.ApplicationService;
import per.liu.service.BookService;
import per.liu.vo.ApplicationVo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-06 17:32
 */

@Controller
@RequestMapping("workbench/application")
public class ApplicationController {

    @Resource
    private BookService bookService;
    @Resource
    private ApplicationService applicationService;

    /**
     * @param book_id       申请的图书id
     * @param appli_amount  申请数量
     * @param class_id      申请班级
     * @param kuchun_amount 库存数量
     * @return
     */
    //教师为班级申请图书
    @RequestMapping("/addAppli.do")
    @ResponseBody
    public Boolean addAppli(String book_id, String appli_amount, String class_id, String kuchun_amount, HttpServletRequest request) {
        /*
         * 需要的参数：
         *          教师信息————从session中获取  |教师id
         *          图书信息————前端获取         |书的id、申请数量
         *          申请班级————前端获取         |班级id
         * */

        Teacher teacher = (Teacher) request.getSession().getAttribute("tch");
        String teacher_id = teacher.getId();    //申请教师id

        Boolean flag = applicationService.addAppli(teacher_id, book_id, appli_amount, class_id, kuchun_amount);

        System.out.println((flag) ? "申请成功" : "申请失败");

        return flag;
    }


    @RequestMapping("/query-AllApplication-ByTch.do")
    @ResponseBody
    public List<ApplicationVo> queryAllApplicationByTch(HttpServletRequest request) {
        /*
        1、根据老师的id，查询老师所负责班级的申请情况
        * */
        Teacher teacher = (Teacher) request.getSession().getAttribute("tch");
        String tch_id = teacher.getId();
        System.out.println("======"+tch_id+"=====");
        List<ApplicationVo> voList = applicationService.queryAllApplicationByTch(tch_id);

        System.out.println("---------------controller------------------");
        for (ApplicationVo a : voList) {
            System.out.println(a);
        }

        System.out.println("----------------------------------------");

        return voList;
    }


    @RequestMapping("/query-AllApplication.do")
    @ResponseBody
    public List<ApplicationVo> queryAllApplication(HttpServletRequest request) {
        /*
        1、查询所有班级的申请情况
        * */

        List<ApplicationVo> voList = applicationService.queryAllApplication();

        System.out.println("---------------controller------------------");
        for (ApplicationVo a : voList) {
            System.out.println(a);
        }

        System.out.println("----------------------------------------");

        return voList;
    }
}
