package per.liu.domain;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-05 16:53
 *
 *          教师为班级申请图书
 */
public class Application {

    private String id;      //申请编号
    private String tch_id;      //申请人
    private String book_id;     //图书id
    private String appli_amount;        //申请数量
    private String class_id;        //班级id
    private String status;      //申请状态（0：未审批 1：审批通过 -1：审批未通过）

    @Override
    public String toString() {
        return "application{" +
                "id='" + id + '\'' +
                ", tch_id='" + tch_id + '\'' +
                ", book_id='" + book_id + '\'' +
                ", appli_amount='" + appli_amount + '\'' +
                ", class_id='" + class_id + '\'' +
                ", status='" + status + '\'' +
                '}';
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTch_id() {
        return tch_id;
    }

    public void setTch_id(String tch_id) {
        this.tch_id = tch_id;
    }

    public String getBook_id() {
        return book_id;
    }

    public void setBook_id(String book_id) {
        this.book_id = book_id;
    }

    public String getAppli_amount() {
        return appli_amount;
    }

    public void setAppli_amount(String appli_amount) {
        this.appli_amount = appli_amount;
    }

    public String getClass_id() {
        return class_id;
    }

    public void setClass_id(String class_id) {
        this.class_id = class_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
