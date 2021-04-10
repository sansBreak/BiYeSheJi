package per.liu.utils;

import java.util.UUID;

/**
 * @Description
 * @Author Alex
 * @Date 2021-04-10 18:13
 */
public class RandomID {

    //由UUID取得一串编码
    public static String createOrderId() {
        int machineId = 1;//最大支持1-9个集群机器部署
        int hashCodeV = UUID.randomUUID().toString().hashCode();
        if(hashCodeV < 0) {//有可能是负数
            hashCodeV = - hashCodeV;
        }
        // 0 代表前面补充0
        // 4 代表长度为4
        // d 代表参数为正数型
        return machineId+String.format("%015d", hashCodeV);
    }
}
