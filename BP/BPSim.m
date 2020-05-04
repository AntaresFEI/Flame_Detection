%神经网络识别 编译C版本
%http://cache.baiducontent.com/c?m=9f65cb4a8c8507ed4fece7631046893b4c4380147d8c8c4668d4e419ce3b4c413037bfa6663f405a8e906b6075a9185be8f53122340123b59b8c8e16d7ac925f75ce786a6459db0144dc46fc8d18769137902ba8f446f0bb8025e5abc5a0ac4352ba02&p=8a7dd315d9c041ab05be9b7c544293&newp=8f65c54ad5c345eb0be2963444418d231610db2151d4d7116b82c825d7331b001c3bbfb423261105d6c2796406a54958ebf63c78300021a3dda5c91d9fb4c57479cc&user=baidu&fm=sc&query=MATLAB+SIM?C&qid=918823b900013473&p1=1
%神经网络工具箱不支持编译C
%net成员直接拿出来赋值可以不用load提高速度简化算法
%Test_data需要归一化
function out = BPSim(net,Test_data)
    %Test_data，待分类的数据，每行表示一个特征向量
    IW = net.IW{1,1};  % net是训练得到的网络，IW表示隐含层的权矩阵
                       % 维数 = 隐含层神经元个数 * 特征数
    LW = net.LW{2,1};  % LW表示隐含层权矩阵，维数 = 1 * 隐含层神经元个数
    b1 = net.b{1,1};    % 输入层的阈值
    b2 = net.b{2,1};    % 隐含层的阈值
    n1 = (IW * Test_data) + b1;
    out1 = 2./(1 + exp(-2 .* n1)) - 1;    % tansig函数的表达式，out1表示输入层的输出结果
    out = LW * out1 + b2;             % purelin函数就是形如 y = x，所以直接可以得到out2
end