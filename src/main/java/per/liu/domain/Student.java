package per.liu.domain;

/**
 * @Description
 * @Author Alex
 * @Date 2021-03-31 15:55
 */
public class Student {
    private String id;              //编号 主键 自增长
    private String loginAct;     //学号       同时也是登录账号
    private String name;        //学生姓名
    private String email;       //邮箱
    private String loginPwd;        //登录密码
    private String grade;       //年级
    private String major;       //专业
    private String department;      //所属学院
    private String classe;      //班级英文class在java中是关键字，所以使用classe代替
    private String classId;     //班级编号

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLoginAct() {
        return loginAct;
    }

    public void setLoginAct(String loginAct) {
        this.loginAct = loginAct;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getLoginPwd() {
        return loginPwd;
    }

    public void setLoginPwd(String loginPwd) {
        this.loginPwd = loginPwd;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getClasse() {
        return classe;
    }

    public void setClasse(String classe) {
        this.classe = classe;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    @Override
    public String toString() {
        return "Student{" +
                "id='" + id + '\'' +
                ", loginAct='" + loginAct + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", loginPwd='" + loginPwd + '\'' +
                ", grade='" + grade + '\'' +
                ", major='" + major + '\'' +
                ", department='" + department + '\'' +
                ", classe='" + classe + '\'' +
                ", classId='" + classId + '\'' +
                '}';
    }
}
