package per.liu.domain;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-04 19:07
 */
public class Classe {
    private String id;      //班级编号
    private String name;        //班级名称
    private String teacherId;       //负责老师的id

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    @Override
    public String toString() {
        return "Classe{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", teacherId='" + teacherId + '\'' +
                '}';
    }
}
