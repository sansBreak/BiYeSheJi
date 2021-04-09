package per.liu.domain;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-04 13:36
 */
public class Book {

    private String id;      //编号 主键 自增长
    private String bId;     //图书编号
    private String name;    //图书名称
    private String ISBN;        //ISBN编码
    private String author;      //作者
    private String price;       //价格
    private String publisher;       //出版社
    private String pub_time;        //出版时间
    private String storage_time;        //入库时间
    private String amount;        //库存数量

    public String getId() {
        return id;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getbId() {
        return bId;
    }

    public void setbId(String bId) {
        this.bId = bId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getPub_time() {
        return pub_time;
    }

    public void setPub_time(String pub_time) {
        this.pub_time = pub_time;
    }

    public String getStorage_time() {
        return storage_time;
    }

    public void setStorage_time(String storage_time) {
        this.storage_time = storage_time;
    }

    @Override
    public String toString() {
        return "Book{" +
                "id='" + id + '\'' +
                ", bId='" + bId + '\'' +
                ", name='" + name + '\'' +
                ", ISBN='" + ISBN + '\'' +
                ", author='" + author + '\'' +
                ", price='" + price + '\'' +
                ", publisher='" + publisher + '\'' +
                ", pub_time='" + pub_time + '\'' +
                ", storage_time='" + storage_time + '\'' +
                ", amount='" + amount + '\'' +
                '}';
    }

}
