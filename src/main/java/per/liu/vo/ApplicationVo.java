package per.liu.vo;

/**
 * @Description  该类里放的是申请的查询详细结果
 * @Author Alex
 * @Date 2021-04-06 17:03
 */
public class ApplicationVo {
    //涉及表格 tbl_application tbl_teacher tbl_books tbl_class

    private String id;      //申请编号

    private String book_id;     //图书id
    private String book_name;     //图书名称
    private String book_price;     //图书价格
    private String book_publisher;     //图书出版社
    private String tch_id;      //申请老师id
    private String tch_name;      //申请老师姓名
    private String appli_amount;        //申请数量
    private String grant_time;        //领书时间
    private String grant_place;        //领书地点
    private String class_id;        //班级id
    private String class_name;        //班级名称
    private String status;      //申请状态（0：未审批 1：审批通过 -1：审批未通过）

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBook_id() {
        return book_id;
    }

    public void setBook_id(String book_id) {
        this.book_id = book_id;
    }

    public String getBook_name() {
        return book_name;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }

    public String getBook_price() {
        return book_price;
    }

    public void setBook_price(String book_price) {
        this.book_price = book_price;
    }

    public String getBook_publisher() {
        return book_publisher;
    }

    public void setBook_publisher(String book_publisher) {
        this.book_publisher = book_publisher;
    }

    public String getTch_id() {
        return tch_id;
    }

    public void setTch_id(String tch_id) {
        this.tch_id = tch_id;
    }

    public String getTch_name() {
        return tch_name;
    }

    public void setTch_name(String tch_name) {
        this.tch_name = tch_name;
    }

    public String getAppli_amount() {
        return appli_amount;
    }

    public void setAppli_amount(String appli_amount) {
        this.appli_amount = appli_amount;
    }

    public String getGrant_time() {
        return grant_time;
    }

    public void setGrant_time(String grant_time) {
        this.grant_time = grant_time;
    }

    public String getGrant_place() {
        return grant_place;
    }

    public void setGrant_place(String grant_place) {
        this.grant_place = grant_place;
    }

    public String getClass_id() {
        return class_id;
    }

    public void setClass_id(String class_id) {
        this.class_id = class_id;
    }

    public String getClass_name() {
        return class_name;
    }

    public void setClass_name(String class_name) {
        this.class_name = class_name;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "ApplicationVo{" +
                "id='" + id + '\'' +
                ", book_id='" + book_id + '\'' +
                ", book_name='" + book_name + '\'' +
                ", book_price='" + book_price + '\'' +
                ", book_publisher='" + book_publisher + '\'' +
                ", tch_id='" + tch_id + '\'' +
                ", tch_name='" + tch_name + '\'' +
                ", appli_amount='" + appli_amount + '\'' +
                ", grant_time='" + grant_time + '\'' +
                ", grant_place='" + grant_place + '\'' +
                ", class_id='" + class_id + '\'' +
                ", class_name='" + class_name + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
