%������ʶ�� ����C�汾
%http://cache.baiducontent.com/c?m=9f65cb4a8c8507ed4fece7631046893b4c4380147d8c8c4668d4e419ce3b4c413037bfa6663f405a8e906b6075a9185be8f53122340123b59b8c8e16d7ac925f75ce786a6459db0144dc46fc8d18769137902ba8f446f0bb8025e5abc5a0ac4352ba02&p=8a7dd315d9c041ab05be9b7c544293&newp=8f65c54ad5c345eb0be2963444418d231610db2151d4d7116b82c825d7331b001c3bbfb423261105d6c2796406a54958ebf63c78300021a3dda5c91d9fb4c57479cc&user=baidu&fm=sc&query=MATLAB+SIM?C&qid=918823b900013473&p1=1
%�����繤���䲻֧�ֱ���C
%net��Աֱ���ó�����ֵ���Բ���load����ٶȼ��㷨
%Test_data��Ҫ��һ��
function out = BPSim(net,Test_data)
    %Test_data������������ݣ�ÿ�б�ʾһ����������
    IW = net.IW{1,1};  % net��ѵ���õ������磬IW��ʾ�������Ȩ����
                       % ά�� = ��������Ԫ���� * ������
    LW = net.LW{2,1};  % LW��ʾ������Ȩ����ά�� = 1 * ��������Ԫ����
    b1 = net.b{1,1};    % ��������ֵ
    b2 = net.b{2,1};    % ���������ֵ
    n1 = (IW * Test_data) + b1;
    out1 = 2./(1 + exp(-2 .* n1)) - 1;    % tansig�����ı��ʽ��out1��ʾ������������
    out = LW * out1 + b2;             % purelin������������ y = x������ֱ�ӿ��Եõ�out2
end