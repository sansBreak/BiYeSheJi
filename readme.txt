SpringMvc:��ͼ�㣬����㣬�������������ʾ������
Spring��ҵ��㣬�����service��dao�����������ġ�
MyBatis���־ò㣬�������ݿ��

�û���������--SpringMVC����--Spring�е�Service����--MyBatis��������

SSM����Ҳ����SSI��������������
1.��һ������SpringMVC����������Controller����������ġ�
2.�ڶ�������Spring����������Service��Dao������������
����Ҫ���İ�ʹ�õĶ��󽻸����ʵ�����������������Controller����web��������ض��󽻸�springmvc��������Щweb�õĶ���д��springmvc�����ļ���

service��dao��������spring�������ļ��У���spring������Щ����

springmvc������spring�������й�ϵ�ģ���ϵ�Ѿ�ȷ������
springmvc������spring������������������java�еļ̳С��ӿ��Է��ʸ�������
���������е�Controller���Է��ʸ�������Service���󣬾Ϳ���ʵ��controllerʹ��service����

ʵ�ֲ��裺
0.ʹ��springdb��mysql�⣬��ʹ��student��id auto_increment, name, age��
1.�½�maven web��Ŀ
2.��������
    springmvc��spring��mybatis������ܵ�������Jackson������mysql������druid���ӳ�
    jsp��servlet����

3.дweb.xml
    1��ע��DispatcherServlet��Ŀ�ģ�1������springmvc�������󣬲��ܴ���Controller�����
                                    2����������Servlet�����ܽ����û�������
    2��ע��spring�ļ�������ContextLoaderListener��Ŀ�ģ�����spring���������󣬲��ܴ���service��dao�ȶ���
    3��ע���ַ��������������post�������������

4.��������Controller����service��dao��ʵ�������������
5.дspringmvc��spring��mybatis�������ļ�
    1��springmvc�����ļ�
    2��spring�����ļ�
    3��mybatis�������ļ�
    4�����ݿ�����������ļ�

6.д���룬dao�ӿں�mapper�ļ���service��ʵ���࣬controller��ʵ����
7.дjspҳ��
