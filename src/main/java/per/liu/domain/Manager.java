package per.liu.domain;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-01 18:02
 */
public class Manager {
    private String id;      //编号 主键 自增长
    private String loginAct;        //工号       同时也是登录账号
    private String name;        //管理员姓名
    private String email;       //邮箱
    private String loginPwd;        //登录密码

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

    @Override
    public String toString() {
        return "Manager{" +
                "id='" + id + '\'' +
                ", loginAct='" + loginAct + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", loginPwd='" + loginPwd + '\'' +
                '}';
    }
}
