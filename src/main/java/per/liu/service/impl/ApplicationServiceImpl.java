package per.liu.service.impl;

import org.springframework.stereotype.Service;
import per.liu.dao.ApplicationDao;
import per.liu.dao.BookDao;
import per.liu.domain.Application;
import per.liu.domain.Book;
import per.liu.service.ApplicationService;
import per.liu.vo.ApplicationVo;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-04 13:40
 */
@Service
public class ApplicationServiceImpl implements ApplicationService {

    @Resource
    private BookDao bookDao;
    @Resource
    private ApplicationDao applicationDao;

    //教师为班级申请图书
    @Override
    public Boolean addAppli(String tch_id, String book_id, String appli_amount, String class_id, String kuchun_amount) {
        boolean flag = true;

        //1、将申请放入tbl_application表中      同时，将状态改为0申请状态（0：未审批 1：审批通过 -1：审批未通过）

        int result1 = 0;
        try {
            result1 = applicationDao.addAppli(tch_id, book_id, appli_amount, class_id, "0");

        } catch (Exception e) {
            e.printStackTrace();
        }

        if (result1 != 1) {
            flag = false;
        }

        //2、对tbl_books表内容进行更新

        //取得库存更新后的数据
        Integer i = null;
        Integer j = null;
        if (appli_amount != null && kuchun_amount != null) {
            i = Integer.valueOf(appli_amount);
            j = Integer.valueOf(kuchun_amount);
        }

        String amount = String.valueOf(j - i);
        int result2 = bookDao.updataBookAmount(book_id, amount);

        if (result2 != 1) {
            flag = false;
        }
        System.out.println("result1" + result1 + "  " + "result2" + result2);
        return flag;
    }

    //根据老师的id，查询老师所负责班级的申请情况
    @Override
    public List<ApplicationVo> queryAllApplicationByTch(String tch_id) {

        //多表联查
        List<ApplicationVo> voList = applicationDao.queryAllApplicationByTch(tch_id);

        System.out.println("-------------service层-----------------");
        for (ApplicationVo a : voList) {

            if ("0".equals(a.getStatus())) {
                a.setStatus("未审批");
            } else if ("1".equals(a.getStatus())) {
                a.setStatus("审批通过");
            } else if ("-1".equals(a.getStatus())) {
                a.setStatus("审批未通过");
            }
        }
        System.out.println("-------------service层-----------------");
        return voList;
    }

    @Override
    public List<ApplicationVo> queryAllApplication() {
        //多表联查
        List<ApplicationVo> voList = applicationDao.queryAllApplication();

        System.out.println("-------------service层----------------");
        for (ApplicationVo a : voList) {

            if ("0".equals(a.getStatus())) {
                a.setStatus("未审批");
            } else if ("1".equals(a.getStatus())) {
                a.setStatus("审批通过");
            } else if ("-1".equals(a.getStatus())) {
                a.setStatus("审批未通过");
            }
        }
        System.out.println("-------------service层-----------------");
        return voList;
    }

    //管理员模块：管理员同意老师的申请
    @Override
    public Boolean agreeAppli(String id, String grant_place, String grant_time) {
        Boolean flag = true;

        int result = applicationDao.agreeAppli(id, "1", grant_place, grant_time);

        if (result != 1) {
            flag = false;
        }
        return flag;
    }

    //管理员模块：管理员驳回老师的申请

    @Override
    public Boolean rejectionAppli(String id) {
        Boolean flag = true;
        /*
         * 驳回时，不仅要将tbl_application表中的status改为-1，还有将申请时取得书本数量放回仓库内
         * */

        //1、修改status
        int result1 = applicationDao.rejectionAppli(id, "-1");
        if (result1 != 1) {
            flag = false;
        }

        //2、先根据订单id查出图书的id与数量
        Application application = applicationDao.queryBookInfoById(id);

        /*
         * 根据图书ID，找到相应图书，更新数量
         * */

        //3.找到先有图书数量
        Book book = bookDao.queryBookInfoById(application.getBook_id());

        /*  book.getAmount()————————————————先有的数量
        *   application.getAppli_amount()——————要放回的数量
        */
        //4、更新tbl_books表中的图书数量
        String  xianyouAmount= book.getAmount();
        String  fanghuiAmount= application.getAppli_amount();
        //取得库存更新后的数据
        Integer i = null;
        Integer j = null;
        if (xianyouAmount != null && fanghuiAmount != null) {
            i = Integer.valueOf(xianyouAmount);
            j = Integer.valueOf(fanghuiAmount);
        }
        String amount = String.valueOf(j + i);

        int result2 =bookDao.updataBookAmount(application.getBook_id(), amount);
        System.out.println("==================");
        System.out.println(result2);
        System.out.println("==================");
        if (result2 != 1) {
            flag = false;
        }

        return flag;
    }

}
